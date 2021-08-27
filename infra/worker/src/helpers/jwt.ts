import jwt from 'jsonwebtoken'
import { StatusError } from 'itty-router-extras'

const ISSUER = 'Club App'
const BEARER = 'Bearer '

export const decodeJwt = (token: string, ignoreExpiration = false): Record<string, unknown> => {
    if (!token.startsWith(BEARER)) {
        throw new StatusError(401, 'token must be the format "Bearer <token>')
    }

    try {
        console.log(token)
        return jwt.verify(token.replace(BEARER, ''), SECRET, {
            issuer: ISSUER,
            ignoreExpiration
        }) as Record<string, unknown>
    } catch (e: unknown) {
        if (e instanceof Error) {
            throw new StatusError(401, `JWT verification failed: ${e.message}`)
        } else {
            throw new StatusError(401, `JWT verification failed for unknown reason: ${e}`)
        }
        
    }
}

export const encodeJwt = (payload: Record<string, unknown>, opts?: jwt.SignOptions): string => {
    return jwt.sign(payload, SECRET, {
        ...(opts ?? {}), //cannot override defaults
        issuer: ISSUER,
        expiresIn: '1h',
    })
}