import * as pulumi from '@pulumi/pulumi'
import * as aws from '@pulumi/aws'
import * as awsx from '@pulumi/awsx'
import { generateName } from '../../helpers'


export const createRds = (config: pulumi.Config, vpc: awsx.ec2.Vpc, cluster: awsx.ecs.Cluster): aws.rds.Instance => {
    const subnetGroup = new aws.rds.SubnetGroup(generateName(config, 'db_subnets'), {
        subnetIds: vpc.publicSubnetIds,
    })

    return new aws.rds.Instance(generateName(config, 'rds'), {
        enabledCloudwatchLogsExports: ['postgresql'],
        allocatedStorage: 10,
        engine: 'postgres',
        engineVersion: '13.4',
        dbSubnetGroupName: subnetGroup.id,
        vpcSecurityGroupIds: cluster.securityGroups.map(g => g.id),
        instanceClass: aws.rds.InstanceTypes.T3_Micro,
        name: 'clubapp',
        password: config.requireSecret('db_password'),
        skipFinalSnapshot: true,
        username: 'clubappDbUser',
    })
}
