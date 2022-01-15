import { StatusError } from 'itty-router-extras'
import { DEBUG, DEFAULT_USERNAME, GOOGLE_CERTS, GOOGLE_PEM_SRC, GOOGLE_VALID_AUDS, GOOGLE_VALID_ISSUER } from '../../../constants'
import * as jose from 'jose'

export interface IIdentifier {
    sub: string,
    email?: string,
    name: string
}

interface IGoogleAccessToken {
    family_name: string
    given_name: string
    sub: string
    email?: string
}

export const verifyIdTokenWithGoogle = async (idToken: string): Promise<IIdentifier> => {
    const parts = idToken.split('.')

    let kid: string
    if (parts.length < 3) {
        throw new StatusError(400, 'invalid idToken JWT')
    } else {
        const noKid = new StatusError(400, 'malformed JWT input; no KID in header')
        try {
            kid = JSON.parse(atob(parts[0]))['kid']
        } catch {
            throw noKid
        }

        if (!kid) {
            throw noKid
        }
    }

    let googleCertsJson = await PUBLIC_KEYS.get(GOOGLE_CERTS)

    if (googleCertsJson === null) {
        const resp = await fetch(GOOGLE_PEM_SRC)
        googleCertsJson = await resp.text()

        const maxAge = resp.headers.get('Cache-Control')?.split(', ')
            .find((v) => v.startsWith('max-age='))
            ?.split('=')[1] as string

        await PUBLIC_KEYS.put(GOOGLE_CERTS, googleCertsJson, {
            expirationTtl: parseInt(maxAge) - 60
        })
    }

    let jwtBody: IGoogleAccessToken
    try {
        const jwk = JSON.parse(googleCertsJson).keys.filter((v: { kid: string }) => v['kid'] === kid)[0]
        const cert = await jose.importJWK(jwk, jwk['alg'])
        const decrypted = await jose.jwtVerify(idToken, cert, {
            audience: GOOGLE_VALID_AUDS,
            issuer: GOOGLE_VALID_ISSUER
        })
        jwtBody = decrypted.payload as unknown as IGoogleAccessToken
    } catch (e) {
        throw new StatusError(402, `Invalid id token: ${e}`)
    }


    const returnedIdentfier: Partial<IIdentifier> = {}
    returnedIdentfier.sub = 'google:' + jwtBody['sub']

    if (jwtBody['given_name']) {
        returnedIdentfier.name =
            `${jwtBody['given_name']} ${jwtBody['family_name'] ?? ''}`.trim()
    }

    if (jwtBody['email']) {
        returnedIdentfier.email = jwtBody['email']

        if (!returnedIdentfier.name) {
            returnedIdentfier.name = jwtBody['email'].split('@')[0]
        }
    }

    if (!returnedIdentfier.name) {
        returnedIdentfier.name = DEFAULT_USERNAME
    }

    return returnedIdentfier as IIdentifier
}


export const getFakeIdentifier = (accessToken: string): IIdentifier => {
    if (!DEBUG) {
        throw new StatusError(400, 'Debug Access Tokens only allowed in dev.')
    }
    const identifier: IIdentifier = JSON.parse(accessToken)

    if (!identifier?.name || !identifier?.sub) {
        throw new StatusError(300, 'invalid input, u need name and sub')
    }

    return identifier
}
