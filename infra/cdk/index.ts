import * as pulumi from '@pulumi/pulumi'
import { createHasura } from './services/aws/hasura'
import { createRds } from './services/aws/rds'
import * as awsx from '@pulumi/awsx'

const config = new pulumi.Config()

const vpc = awsx.ec2.Vpc.getDefault()
const cluster = awsx.ecs.Cluster.getDefault()

let adminSecret

if (process.env.ADMIN_SECRET) {
    adminSecret = process.env.ADMIN_SECRET
} else {
    throw Error('need to set admin secret')
}

const rds = createRds(config, vpc, cluster)
const hasura = createHasura(config, adminSecret, rds, cluster)

export const endpoint = hasura

