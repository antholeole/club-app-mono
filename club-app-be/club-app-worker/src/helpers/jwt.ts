import jwt from 'jsonwebtoken'
import { StatusError } from 'itty-router-extras'

const ISSUER = 'Club App'

export const decodeJwt = (token: string): Map<string, unknown> => {
    try {
        const payload = jwt.verify(token, SECRET, {
            issuer: ISSUER,
        })

        return new Map(Object.entries(payload))
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