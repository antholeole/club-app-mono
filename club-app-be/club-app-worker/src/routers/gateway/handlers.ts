import { decodeJwt } from '../../helpers/jwt'
import { IAccessToken } from '../../helpers/types/access_token'
import { IWsConnectMessage } from './discriminators'
import { status } from 'itty-router-extras'

export const connectRoute = async (wsMessage: IWsConnectMessage): Promise<Response> => {
    const jwt = decodeJwt(wsMessage.event.multiValueHeaders.authorization[0]) as unknown as IAccessToken
    await ONLINE_USERS.put(jwt.sub, wsMessage.id)

    return status(200)
}