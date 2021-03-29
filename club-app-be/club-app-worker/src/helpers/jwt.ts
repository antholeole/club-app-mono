import jwt from 'jsonwebtoken'
import { GlobalError } from './global_error'

const ISSUER = 'Club App'

export const decodeJwt = (token: string): Map<string, unknown> => {
    try {
        const payload = jwt.verify(token, SECRET, {
            issuer: ISSUER,
        })

        return new Map(Object.entries(payload))
    } catch (e) {
        throw new GlobalError('Unauthorized JWT', 401)
    }
}

export const encodeJwt = (payload: Record<string, unknown>, opts?: jwt.SignOptions): string => {
    return jwt.sign(payload, SECRET, {
        ...(opts ?? {}), //cannot override defaults
        issuer: ISSUER,
        expiresIn: '1h',
    })
}