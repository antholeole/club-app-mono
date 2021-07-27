import jwt from 'jsonwebtoken'
import { StatusError } from 'itty-router-extras'

const ISSUER = 'Club App'

export const decodeJwt = (token: string, ignoreExpiration = false): Record<string, unknown> => {
    if (!token.startsWith('Bearer ')) {
        throw new StatusError(401, 'token must be the format "Bearer <token>')
    }

    try {
        return jwt.verify(token, SECRET, {
            issuer: ISSUER,
            ignoreExpiration
        }) as Record<string, unknown>
    } catch (e) {
        throw new StatusError(401, 'Unauthorized JWT')
    }
}

export const encodeJwt = (payload: Record<string, unknown>, opts?: jwt.SignOptions): string => {
    return jwt.sign(payload, SECRET, {
        ...(opts ?? {}), //cannot override defaults
        issuer: ISSUER,
        expiresIn: '1h',
    })
}