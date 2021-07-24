import { StatusError } from 'itty-router-extras'
import type { Static } from 'runtypes'
import { WS_API_GATEWAY } from '../constants'
import { SendableMessage } from '../messages/sendable'

export const sendToWs = async (message: Static<typeof SendableMessage>): Promise<Response> => {
    const userConnection = await ONLINE_USERS.get(message.to)

    if (!userConnection) {
        throw new StatusError(404)
    }

    const endpoint = WS_API_GATEWAY + '/%40connections/' + encodeURIComponent(userConnection)
    return await fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(message)
    })
}