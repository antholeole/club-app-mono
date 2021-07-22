import { decodeJwt } from '../../helpers/jwt'
import { IAccessToken } from '../../helpers/types/access_token'
import { status, StatusError } from 'itty-router-extras'
import type { Static } from 'runtypes'
import { RecieveableMessage, WsMessage } from './types'
import { handleMessageMessage } from './message_handlers'

export const connectRoute = async (wsMessage: Static<typeof WsMessage>): Promise<Response> => {
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0]) as unknown as IAccessToken

    await ONLINE_USERS.put(jwt.sub, wsMessage.id)

    return status(200)
}

export const disconnectRoute = async (wsMessage: Static<typeof WsMessage>): Promise<Response> => {
    //SAFETY: can ignore expiration because this client has successfully connected with this token.
    //if the token is expired, no big deal - accept the disconnect.
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0], true) as unknown as IAccessToken

    try {
        await ONLINE_USERS.delete(jwt.sub)
    } catch (_) {
        //Nothing to do here.
    }

    return status(200)
}

export const messageRoute = async (wsMessage: Static<typeof RecieveableMessage>): Promise<Response> => {
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0]) as unknown as IAccessToken

    const onlineUser = await ONLINE_USERS.get(jwt.sub)

    if (onlineUser == null) {
        throw new StatusError(404, 'user not online; connect first.')
    }

    return await RecieveableMessage.match<Promise<Response> | Response>(
        handleMessageMessage,
        () => new Response('hi!')
    )(wsMessage)
}