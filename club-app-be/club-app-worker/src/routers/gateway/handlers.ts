import { decodeJwt } from '../../helpers/jwt'
import { IAccessToken } from '../../helpers/types/access_token'
import { IWsConnectMessage, IWsMessage, IWsMessageMessage, messageTypes } from './discriminators'
import { status, StatusError } from 'itty-router-extras'
import { handleMessageMessage } from './message_handlers'
import { DiscriminatorError } from '../../helpers/discriminator_error'
import { discriminate } from '../../helpers/discriminators/base_discriminator'
import { EnumFieldOption, FieldOption, MockValues } from '../../helpers/discriminators/field_options'

export const connectRoute = async (wsMessage: IWsConnectMessage): Promise<Response> => {
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0]) as unknown as IAccessToken

    await ONLINE_USERS.put(jwt.sub, wsMessage.id)

    return status(200)
}

export const disconnectRoute = async (wsMessage: IWsConnectMessage): Promise<Response> => {
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

export const messageRoute = async (wsMessage: IWsMessage): Promise<Response> => {
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0]) as unknown as IAccessToken

    const onlineUser = await ONLINE_USERS.get(jwt.sub)

    if (onlineUser == null) {
        throw new StatusError(404, 'user not online; connect first.')
    }

    switch (wsMessage.message.type) {
        case 'message':
            handleMessageMessage(discriminate<IWsMessageMessage>(
                {
                    event: {
                        multiValueHeaders: {
                            authorization: new FieldOption([MockValues.mockString])
                        }
                    },
                    message: {
                        toId: new FieldOption(MockValues.mockString),
                        message: new FieldOption(MockValues.mockString),
                        type: new EnumFieldOption<typeof messageTypes>(messageTypes)
                    },
                    id: new FieldOption(MockValues.mockString)
                },
                wsMessage as unknown as Record<string, unknown>
            ))
            break
        default:
            throw new DiscriminatorError()
    }

    return status(200)
}