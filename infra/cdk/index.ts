import * as pulumi from '@pulumi/pulumi'
import { createHasura } from './services/aws/hasura'
import { createRds } from './services/aws/rds'
import * as awsx from '@pulumi/awsx'
import { addSecret } from './services/github/add_secret'
import { createWorker } from './services/cloudflare/worker'
import { generateUserFacingName } from './helpers'

const config = new pulumi.Config()

const vpc = awsx.ec2.Vpc.getDefault()
const cluster = awsx.ecs.Cluster.getDefault()

export const workerEndpoint = pulumi.interpolate `${generateUserFacingName(config, 'worker')}.${config.require('base_url')}`

const rds = createRds(config, vpc, cluster)
export const hasuraEndpoint = createHasura(config, rds, cluster, workerEndpoint)

createWorker(config, hasuraEndpoint)

addSecret(config, pulumi.interpolate `${config.require('stage')}_hasura_admin_key`, config.requireSecret('hasura_admin_key'))

export const hasuraVersion = config.require('hasura_version')


