import * as pulumi from '@pulumi/pulumi'
import { createHasura } from './services/aws/hasura'
import { createRds } from './services/aws/rds'
import * as awsx from '@pulumi/awsx'
import { addSecret } from './services/github/add_secret'

const config = new pulumi.Config()

const vpc = awsx.ec2.Vpc.getDefault()
const cluster = awsx.ecs.Cluster.getDefault()

const rds = createRds(config, vpc, cluster)
const hasura = createHasura(config, rds, cluster)

addSecret(config, pulumi.interpolate `${config.require('stage')}-hasura_admin_key`, config.requireSecret('hasura_admin_key'))

export const endpoint = hasura

