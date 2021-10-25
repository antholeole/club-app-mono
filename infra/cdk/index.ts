import * as pulumi from '@pulumi/pulumi'
import { createHasura } from './services/hasura'
import { createRds } from './services/rds'


const config = new pulumi.Config()

const rds = createRds(config)
createHasura(config, rds)