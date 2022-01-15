import { putEncryptedKV } from 'encrypt-workers-kv'
import { json } from 'itty-router-extras'
import { cryptoRandomString } from '../../../helpers/crypto'
import { addUser, getUserBySub } from './gql_queries'
import { generateAccessToken } from '../helpers'
import { getFakeIdentifier, IIdentifier, verifyIdTokenWithGoogle } from './helpers'
import { IActionInput } from '../../../helpers/event_listeners'

export interface IAccessTokenRequest {
    idToken: string,
    identityProvider: 'Google' | 'Debug'
}

export const registerRoute = async (req: IActionInput<IAccessTokenRequest>): Promise<Response> => {
    let identifier: IIdentifier
    switch (req.input.identityProvider) {
        case 'Google':
            identifier = await verifyIdTokenWithGoogle(req.input.idToken)
            break
        case 'Debug':
            identifier = getFakeIdentifier(req.input.idToken)
            break
    }

    let user = await getUserBySub(identifier.sub)

    if (user == null) {
        user = await addUser(identifier.sub, identifier.name, identifier.email)
    }

    const refreshUnhashed = cryptoRandomString(300)

    await putEncryptedKV(REFRESH_TOKENS, user.id, refreshUnhashed, SECRET)
    const aToken = await generateAccessToken(user.id)
    return json({
        accessToken: aToken,
        refreshToken: refreshUnhashed,
        id: user.id,
        email: user.email,
        name: user.name
    })
}