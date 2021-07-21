import type { Static } from 'runtypes'
import { WS_API_GATEWAY } from '../constants'
import { Sendable } from './sendable_messages'

export const sendToWs = async (to: string, message: Static<typeof Sendable>): Promise<void> => {
    const userConnection = await ONLINE_USERS.get(to)

    await fetch(WS_API_GATEWAY + '/@connections/' + userConnection, {
        method: 'POST',
        body: JSON.stringify(message)
    })
}