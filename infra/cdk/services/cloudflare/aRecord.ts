import * as pulumi from '@pulumi/pulumi'
import * as cloudflare from '@pulumi/cloudflare'
import { generateName } from '../../helpers'

export const generateARecord = (config: pulumi.Config, from: pulumi.Output<string>, serverIp: pulumi.Output<string>, name: string): void => {
    const zone = config.requireSecret('CF_ZONE')

    new cloudflare.Record(generateName(config, name), {
        zoneId: zone,
        allowOverwrite: true,
        proxied: true,
        value: serverIp,
        name: from,
        type: 'CNAME'
    })
}

/*
need to somehow run 
hasura migrate apply --all-databases --endpoint http://dev-clubapp-hasura-lb-db28be5-a4561e257a559394.elb.us-east-1.amazonaws.com:8080
anthony@Anthonys-MacBook-Pro hasura --admin-secret <SECRET>
in CI/CD?
*/