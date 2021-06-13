import { StatusError, json } from 'itty-router-extras'
import { IAccessTokenRequest, IRefresh } from './discriminators'
import { generateAccessToken, getFakeIdentifier, IIdentifier, verifyIdTokenWithGoogle } from './helpers'
import { addUser, getUserBySub } from './gql_queries'
import { cryptoRandomString } from '../../helpers/crypto'
import { getDecryptedKV, putEncryptedKV } from 'encrypt-workers-kv'
import { NO_V_GET_DECRYPTED_KV } from '../../constants'

export const registerRoute = async (tokens: IAccessTokenRequest): Promise<Response> => {
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

export const refreshRoute = async (refreshParams: IRefresh): Promise<Response> => {
    let decryptedHash: ArrayBuffer
    try {
        decryptedHash = await getDecryptedKV(REFRESH_TOKENS, refreshParams.userId, SECRET)
    } catch (e) {
        if (e instanceof Error && e.message.includes(NO_V_GET_DECRYPTED_KV)) {
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