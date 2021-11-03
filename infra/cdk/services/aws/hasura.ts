import * as pulumi from '@pulumi/pulumi'
import * as awsx from '@pulumi/awsx'
import * as aws from '@pulumi/aws'
import { generateName, generateUserFacingName } from '../../helpers'
import { generateRecord } from '../cloudflare/records'
import { RecordType } from '@pulumi/aws/route53'

export const createHasura = (
    config: pulumi.Config, rds: aws.rds.Instance, cluster: awsx.ecs.Cluster, workerEndpoint: pulumi.Output<string>
): pulumi.Output<string> => {
    // TODO: a user can easily hit ALB directly. need to add a secret header on CF side and then
    // verify it in ALB side. don't worr
    const databaseUrl = pulumi.interpolate`postgres://${rds.username}:${rds.password}@${rds.endpoint}:5432/${rds.name}`

    const alb = new awsx.elasticloadbalancingv2.ApplicationLoadBalancer(
        generateName(config, 'hasura-alb'), { external: true, securityGroups: [...cluster.securityGroups, ] })

    const atg = alb.createTargetGroup(
        'app-tg', { port: 8080, deregistrationDelay: 0, healthCheck: {
            path: '/healthz'
        } }, )

    const web = atg.createListener('web', { port: 80 }) 
    
    new awsx.ecs.FargateService(generateName(config, 'hasura'), {
        cluster,
        desiredCount: 1,
        taskDefinitionArgs: {
            container: {
                healthCheck: { 
                    command: ['CMD', 'bash', '-c', 'exec 5<>/dev/tcp/127.0.0.1/8080 && echo -e \'GET /healthz HTTP/1.1\n\n\' >&5 && cat <&5 | head -n 1 | grep 200'],
                    interval: 15,
                    timeout: 5,
                    retries: 3
                },
                image: pulumi.interpolate `hasura/graphql-engine:${config.require('hasura_version')}`,
                portMappings: [web],
                environment: [
                    { name: 'HASURA_GRAPHQL_ENABLED_LOG_TYPES', value: 'http-log, webhook-log, websocket-log, query-log' },
                    {
                        name: 'HASURA_GRAPHQL_JWT_SECRET',
                        value: config.requireSecret('jwt_secret').apply((jwtSecret) => `{"type": "HS256","key": "${jwtSecret}"}`)
                    },
                    { name: 'HASURA_GRAPHQL_ADMIN_SECRET', value: config.requireSecret('hasura_admin_key') },
                    { name: 'HASURA_GRAPHQL_DEV_MODE', value: config.require('stage') === 'dev' ? 'true' : 'false' },
                    { name: 'HASURA_GRAPHQL_ENABLE_CONSOLE', value: config.require('stage') === 'dev' ? 'true' : 'false' },
                    { name: 'HASURA_GRAPHQL_UNAUTHORIZED_ROLE', value: 'unauthenticated' },
                    { name: 'WEBHOOK_URL', value: pulumi.interpolate `https://${workerEndpoint}` },
                    { name: 'HASURA_GRAPHQL_ENABLE_ALLOWLIST', value: 'true' },
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

    const endpoint = pulumi.interpolate `${generateUserFacingName(config, 'hasura')}.${config.require('base_url')}`
    generateRecord(config, endpoint, 'hasura', RecordType.CNAME, alb.loadBalancer.dnsName)

    return endpoint
}




