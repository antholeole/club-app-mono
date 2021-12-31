import * as cloudflare from '@pulumi/cloudflare'
import * as pulumi from '@pulumi/pulumi'
import { generateName, generateUserFacingName } from '../../helpers'
import { execSync } from 'child_process'
import { readFileSync } from 'fs'
import { RecordType } from '@pulumi/aws/route53'
import { generateRecord } from './records'

const createKvStore = (config: pulumi.Config, name: string): cloudflare.WorkersKvNamespace => {
    const qualifiedName = generateName(config, name)

    return new cloudflare.WorkersKvNamespace(qualifiedName, {
        title: qualifiedName
    })
}

export const createWorker = (config: pulumi.Config, hasuraEndpoint: pulumi.Output<string>): void => {
    execSync('cd ../worker && npm i && npm run build')
    
    const workerName = generateName(config, 'worker')

    const script = new cloudflare.WorkerScript(workerName, {
        content: readFileSync('../worker/dist/worker.js', 'utf-8',),
        name: workerName,
        kvNamespaceBindings: ['PUBLIC_KEYS', 'REFRESH_TOKENS'].map(name => ({
            name,
            namespaceId: createKvStore(config, name).id
        })),
        secretTextBindings: [
            {
                text: '0007bb043992e560000000003',
                name: 'B2_ACCESS_KEY_ID'
            },
            {         
                name: 'B2_SECRET_ACCESS_KEY',
                text: config.requireSecret('b2_secret_access_key')
            },
            {
                name: 'HASURA_PASSWORD',
                text: config.requireSecret('hasura_admin_key')
            },
            {
                name: 'SECRET',
                text: config.requireSecret('jwt_secret')
            },
            {
                name: 'WEBHOOK_SECRET_KEY',
                text: config.requireSecret('webhook_secret')
            },
            {
                name: 'ENVIRONMENT',
                text: config.require('stage') 
            },
            {
                name: 'HASURA_ENDPOINT',
                text: pulumi.interpolate `https://${hasuraEndpoint}/v1/graphql`
            }
        ]
    })

    const endpoint = pulumi.interpolate `${generateUserFacingName(config, 'worker')}.${config.require('base_url')}`
    generateRecord(config, endpoint, generateName(config, 'workerRecord'), RecordType.A)

    new cloudflare.WorkerRoute(generateName(config, 'Route'), {
        zoneId: config.requireSecret('CF_ZONE'),
        pattern: pulumi.interpolate `${endpoint}/*`,
        scriptName: script.name,
    })
}