import * as jose from 'jose'

const ISSUER = 'Club App'

export const generateAccessToken = (id: string): Promise<string> => {
    const payload = {
        sub: id,
        'https://hasura.io/jwt/claims': {
            'x-hasura-allowed-roles': ['user', 'guest'],
            'x-hasura-user-id': id,
            'x-hasura-default-role': 'user'
        }
    }

    return new jose.SignJWT(payload)
        .setProtectedHeader({ alg: 'HS512' })
        .setIssuedAt()
        .setIssuer(ISSUER)
        .setExpirationTime('1h')
        .sign(new TextEncoder().encode(SECRET))

}


