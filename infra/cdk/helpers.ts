import * as Pulumi from '@pulumi/pulumi'

export const generateName = (config: Pulumi.Config, baseName: string): string =>  
    `${config.require('stage')}-${baseName}`

export const generateUserFacingName = (config: Pulumi.Config, baseName: string): string => {
    const stage = config.require('stage')

    if (stage !== 'dev') {
        return baseName
    } 

    return `${stage}-${baseName}`
}
