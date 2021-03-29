import { GOOGLE_CERTS, GOOGLE_PEM_SRC, GOOGLE_VALID_AUDS, GOOGLE_VALID_ISSUER } from '../../constants'
import { GlobalError } from '../../helpers/global_error'
import { encodeJwt } from '../../helpers/jwt'
import type { IUser } from './gql_queries'
import jwt from 'jsonwebtoken'


const throwInvalid = () => {
    throw new GlobalError('Invalid id token.', 402) 
}
export const verifyIdTokenWithGoogle = async (idToken: string): Promise<string> => {
    const parts = idToken.split('.')

    let kid
    if (parts.length < 3) {
        throw new GlobalError('invalid idToken JWT', 400)
    } else {
        kid = JSON.parse(atob(parts[0]))['kid']
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

    let jwtBody: any
    try {
        jwtBody = (jwt.verify(idToken, JSON.parse(googleCertsJson)[kid], {
            audience: GOOGLE_VALID_AUDS,
            issuer: GOOGLE_VALID_ISSUER
        }) as any)
    } catch {
        throwInvalid()
    }

    return jwtBody['sub']
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