import * as pulumi from '@pulumi/pulumi'
import * as aws from '@pulumi/aws'
import { generateName } from '../helpers'

export const createLogGroup = (config: pulumi.Config, name: string): aws.cloudwatch.LogGroup => 
    new aws.cloudwatch.LogGroup(generateName(config, `${name}-logs`), {
    retentionInDays: 30,
    tags: {
        Application: name,
        Environment: config.require('stage'),
    },
})
