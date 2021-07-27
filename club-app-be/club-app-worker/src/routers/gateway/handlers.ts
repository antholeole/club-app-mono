import { decodeJwt } from '../../helpers/jwt'
import { IAccessToken } from '../../helpers/types/access_token'
import { status, StatusError } from 'itty-router-extras'
import type { Static } from 'runtypes'
import { handleEditMessage, handleMessageMessage } from './message_handlers'
import { EmptyRecieveable, RecieveableMessage } from '../../messages/recieveable'
import { BaseMessages } from '../../messages/message_types'

export const connectRoute = async (wsMessage: Static<typeof EmptyRecieveable>): Promise<Response> => {
    let auth: string

    if (!wsMessage.event.multiValueHeaders?.authorization?.[0]) {
        throw new StatusError(401)
    } else {
        auth = wsMessage.event.multiValueHeaders.authorization[0]
    }

    const jwt = decodeJwt(auth) as unknown as IAccessToken

    await ONLINE_USERS.put(jwt.sub, wsMessage.id)

    return status(200)
}

export const disconnectRoute = async (wsMessage: Static<typeof EmptyRecieveable>): Promise<Response> => {
    //SAFETY: can ignore expiration because this client has successfully connected with this token.
    //if the token is expired, no big deal - accept the disconnect.
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0], true) as unknown as IAccessToken

    try {
        await ONLINE_USERS.delete(jwt.sub)
    } catch {
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

    const matcher = BaseMessages.match<Promise<Response> | Response>(
        handleMessageMessage,
        handleEditMessage
    )

    return await matcher(wsMessage.message)
}