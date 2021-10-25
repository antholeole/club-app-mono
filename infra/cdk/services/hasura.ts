import * as pulumi from '@pulumi/pulumi'
import * as awsx from '@pulumi/awsx'
import * as aws from '@pulumi/aws'
import { generateName } from '../helpers'


export const createHasura = (config: pulumi.Config, rds: aws.rds.Instance): awsx.ecs.FargateService => {
    const databaseUrl = rds.endpoint //this isnt enough... needs the rest!

    const listener = new awsx.lb.NetworkLoadBalancer('lb')
        .createTargetGroup('group', { port: 8080, protocol: 'TCP' })
        .createListener('listener', {
            port: 80,
            protocol: 'TCP',
        })
        

    const cluster = awsx.ecs.Cluster.getDefault()

    const service = new awsx.ecs.FargateService(generateName(config, 'hasura'), {
        cluster,
        desiredCount: 1,
        taskDefinitionArgs: {
            container: {
                image: 'hasura/graphql-engine:v2.0.10',
                portMappings: [listener],

                environment: [
                    { name: 'HASURA_GRAPHQL_ENABLED_LOG_TYPES', value: 'http-log, webhook-log, websocket-log, query-log' },
                    {
                        name: 'HASURA_GRAPHQL_JWT_SECRET',
                        value: config.requireSecret('jwt_secret').apply((jwtSecret) => `{"type": "HS256","key": "${jwtSecret}"}`)
                    },
                    { name: 'HASURA_GRAPHQL_ADMIN_SECRET', value: 'my_secret' },
                    { name: 'HASURA_GRAPHQL_DEV_MODE', value: 'false' },
                    { name: 'HASURA_GRAPHQL_ENABLE_CONSOLE', value: 'false' },
                    { name: 'HASURA_GRAPHQL_UNAUTHORIZED_ROLE', value: 'anonymous' },
                    { name: 'HASURA_GRAPHQL_UNAUTHORIZED_ROLE', value: 'unauthenticated' },
                    { name: 'WEBHOOK_URL', value: 'getclub.app/api' },
                    {
                        name: 'WEBHOOK_SECRET_KEY',
                        value: config.requireSecret('webhook_secret').apply((webhookSecret) => webhookSecret)
                    },
                    {
                        name: 'HASURA_GRAPHQL_DATABASE_URL',
                        value: databaseUrl,
                    },
                ],
            },
        },
    })

    return service
}




