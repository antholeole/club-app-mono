import { StatusError, json } from 'itty-router-extras'
import { AcessTokenRequest, RefreshRequest } from './types'
import type { Static } from 'runtypes'
import { generateAccessToken, getFakeIdentifier, IIdentifier, verifyIdTokenWithGoogle } from './helpers'
import { addUser, getUserBySub } from './gql_queries'
import { cryptoRandomString } from '../../helpers/crypto'
import { getDecryptedKV, putEncryptedKV } from 'encrypt-workers-kv'

export const registerRoute = async (tokens: Static<typeof AcessTokenRequest>): Promise<Response> => {
    let identifier: IIdentifier
    switch (tokens.from) {
        case 'Google':
            identifier = await verifyIdTokenWithGoogle(tokens.idToken)
            break
        case 'Debug':
            identifier = getFakeIdentifier(tokens.idToken)
    }

    let user = await getUserBySub(identifier.sub)

    if (user == null) {
        user = await addUser(identifier.sub, identifier.name, identifier.email)
    }

    const refreshUnhashed = cryptoRandomString(20)

    await putEncryptedKV(REFRESH_TOKENS, user.id, refreshUnhashed, SECRET)

    const aToken = generateAccessToken(user.id)
    return json({
        accessToken: aToken,
        refreshToken: refreshUnhashed,
        ...user,
    })
}

export const refreshRoute = async (refreshParams: Static<typeof RefreshRequest>): Promise<Response> => {
    let decryptedHash: ArrayBuffer
    try {
        decryptedHash = await getDecryptedKV(REFRESH_TOKENS, refreshParams.userId, SECRET)
    } catch (e) {
        //instanceof does not work here. idk y
        if (e.constructor.name == 'NotFoundError') {
            throw new StatusError(404, `user with id ${refreshParams.userId} not found`)
        } else {
            throw e
        }
    }

    if (new TextDecoder().decode(decryptedHash) === refreshParams.refreshToken) {
        return new Response(generateAccessToken(refreshParams.userId))
    } else {
        throw new StatusError(402, `invalid refresh token ${refreshParams.refreshToken}`) //returns 402 to avoid loop
    }
}