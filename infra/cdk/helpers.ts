import * as Pulumi from '@pulumi/pulumi'

export const generateName = (config: Pulumi.Config, baseName: string): string =>  
    `${config.require('stage')}-clubapp-${baseName}`
