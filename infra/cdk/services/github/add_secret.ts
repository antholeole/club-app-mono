import * as github from '@pulumi/github'
import * as pulumi from '@pulumi/pulumi'

export const addSecret = (config: pulumi.Config, secretName: pulumi.Output<string>, secret: pulumi.Input<string>): pulumi.Output<github.ActionsSecret> => {
    const gh = new github.Provider('gh', {
        token: config.getSecret('github_token')
    })

    return secretName.apply(secretName => new github.ActionsSecret(secretName, {
        repository: 'club-app-mono',
        secretName: secretName,
        plaintextValue: secret
    }, {
        provider: gh
    }))   
}