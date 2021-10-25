import * as pulumi from '@pulumi/pulumi'
import * as aws from '@pulumi/aws'
import { generateName } from '../helpers'


export const createRds = (config: pulumi.Config): aws.rds.Instance => {
    const name = generateName(config, 'rds')

    return new aws.rds.Instance(name, {
        enabledCloudwatchLogsExports: ['postgresql'],
        allocatedStorage: 10,
        engine: 'postgres',
        engineVersion: '13.4',
        instanceClass: 'db.t3.micro',
        name: 'clubapp',
        password: config.requireSecret('db_password'),
        skipFinalSnapshot: true,
        username: 'clubappDbUser',
    })
}
