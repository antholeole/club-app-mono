import { GOOGLE_CERTS, GOOGLE_PEM_SRC, GOOGLE_VALID_AUDS, GOOGLE_VALID_ISSUER } from '../../constants'
import { StatusError } from 'itty-router-extras'
import { encodeJwt } from '../../helpers/jwt'
import jwt from 'jsonwebtoken'


const throwInvalid = () => {
    throw new StatusError(402, 'Invalid id token.') 
}
export const verifyIdTokenWithGoogle = async (idToken: string): Promise<string> => {
    const parts = idToken.split('.')

    let kid
    if (parts.length < 3) {
        throw new StatusError(400, 'invalid idToken JWT')
    } else {
        try {
        kid = JSON.parse(atob(parts[0]))['kid']
        } catch (_) {
            throw new StatusError(400, 'malformed JWT input; no KID in header')
        }
    }

    let googleCertsJson = await PUBLIC_KEYS.get(GOOGLE_CERTS)

    if (googleCertsJson == null) {
        const resp = await fetch(GOOGLE_PEM_SRC)

        googleCertsJson = await resp.text()

        const maxAge = resp.headers.get('Cache-Control')?.split(', ')
        .find((v) => v.startsWith('max-age='))
        ?.split('=')[1] as string

        await PUBLIC_KEYS.put(GOOGLE_CERTS, googleCertsJson, {
            expirationTtl: parseInt(maxAge) - 60
        })
    }

    let jwtBody: unknown
    try {
        jwtBody = (jwt.verify(idToken, JSON.parse(googleCertsJson)[kid], {
            audience: GOOGLE_VALID_AUDS,
            issuer: GOOGLE_VALID_ISSUER
        }) as unknown)
    } catch {
        throwInvalid()
    }

    return (jwtBody as { sub: string })['sub']
}

export const generateAccessToken = (id: string): string => {
    return encodeJwt({
        sub: id,
        'https://hasura.io/jwt/claims': {
            'x-hasura-allowed-roles': ['user', 'guest'],
            'x-hasura-user-id': id,
            'x-hasura-default-role': 'user'
        }
    })
}