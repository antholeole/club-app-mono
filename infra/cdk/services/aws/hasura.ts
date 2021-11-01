import * as pulumi from '@pulumi/pulumi'
import * as awsx from '@pulumi/awsx'
import * as aws from '@pulumi/aws'
import { generateName } from '../../helpers'
import { generateARecord } from '../cloudflare/aRecord'

export const createHasura = (
    config: pulumi.Config, hasuraAdminKey: pulumi.Input<string>, rds: aws.rds.Instance, cluster: awsx.ecs.Cluster
): pulumi.Output<string> => {
    // TODO: a user can easily hit ALB directly. need to add a secret header on CF side and then
    // verify it in ALB side. don't worr
    const databaseUrl = pulumi.interpolate`postgres://${rds.username}:${rds.password}@${rds.endpoint}:5432/${rds.name}`

    const alb = new awsx.elasticloadbalancingv2.ApplicationLoadBalancer(
        generateName(config, 'hasura-alb'), { external: true, securityGroups: [...cluster.securityGroups, ] })

    const atg = alb.createTargetGroup(
        'app-tg', { port: 8080, deregistrationDelay: 0 }, )

    const web = atg.createListener('web', { port: 80 }) 
    
    new awsx.ecs.FargateService(generateName(config, 'hasura'), {
        cluster,
        desiredCount: 1,
        taskDefinitionArgs: {
            container: {
                image: 'hasura/graphql-engine:v2.0.10',
                portMappings: [web],
                environment: [
                    { name: 'HASURA_GRAPHQL_ENABLED_LOG_TYPES', value: 'http-log, webhook-log, websocket-log, query-log' },
                    {
                        name: 'HASURA_GRAPHQL_JWT_SECRET',
                        value: config.requireSecret('jwt_secret').apply((jwtSecret) => `{"type": "HS256","key": "${jwtSecret}"}`)
                    },
                    { name: 'HASURA_GRAPHQL_ADMIN_SECRET', value: hasuraAdminKey },
                    { name: 'HASURA_GRAPHQL_DEV_MODE', value: 'false' },
                    { name: 'HASURA_GRAPHQL_ENABLE_CONSOLE', value: 'false' },
                    { name: 'HASURA_GRAPHQL_UNAUTHORIZED_ROLE', value: 'unauthenticated' },
                    { name: 'WEBHOOK_URL', value: 'getclub.app/api' },
                    {
                        name: 'WEBHOOK_SECRET_KEY',
                        value: config.requireSecret('webhook_secret')
                    },
                    {
                        name: 'HASURA_GRAPHQL_DATABASE_URL',
                        value: databaseUrl,
                    },
                ],
            },
        },
    })

    generateARecord(config, pulumi.interpolate`${config.get('stage')}-hasura.${config.get('base_url')}`, alb.loadBalancer.dnsName, 'hasura')

    return pulumi.interpolate`http://${web.endpoint.hostname}:${web.endpoint.port}`
}




