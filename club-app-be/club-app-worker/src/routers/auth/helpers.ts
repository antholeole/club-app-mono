import { GOOGLE_CERTS, GOOGLE_PEM_SRC, GOOGLE_VALID_AUDS, GOOGLE_VALID_ISSUER } from '../../constants'
import { StatusError } from 'itty-router-extras'
import { randomBytes, scrypt } from 'crypto'
import { encodeJwt } from '../../helpers/jwt'
import type { IUser } from './gql_queries'
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

export const hash = (toHash: string): Promise<string> => {
    return new Promise((resolve, reject) => {
        const salt = randomBytes(16).toString('hex')

        scrypt(toHash, salt, 64, (err, derivedKey) => {
            if (err) reject(err)
            resolve(salt + ':' + derivedKey.toString('hex'))
        })
    })
}

export const verifyHash = (plaintext: string, hash: string): Promise<boolean> => {
    return new Promise((resolve, reject) => {
        const [salt, key] = hash.split(':')
        scrypt(plaintext, salt, 64, (err, derivedKey) => {
            if (err) reject(err)
            resolve(key == derivedKey.toString('hex'))
        })
    })
}
