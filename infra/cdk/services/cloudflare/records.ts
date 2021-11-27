import * as pulumi from '@pulumi/pulumi'
import * as cloudflare from '@pulumi/cloudflare'
import { generateName } from '../../helpers'
import { RecordType } from '@pulumi/aws/route53'


export const generateRecord = (config: pulumi.Config, from: pulumi.Output<string>, name: string, recordType: RecordType, serverIp?: pulumi.Output<string>): void => {
    const zone = config.requireSecret('CF_ZONE')

    new cloudflare.Record(generateName(config, name), {
        zoneId: zone,
        allowOverwrite: true,
        proxied: true,
        value: serverIp ?? '192.0.2.1',
        name: from,
        type: recordType
    })
}
