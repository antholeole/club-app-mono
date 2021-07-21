import { WS_API_GATEWAY } from "../constants"

export const sendToWs = async (to: string, message: any): Promise<void> => {
    const userConnection = await ONLINE_USERS.get(to)

    await fetch(WS_API_GATEWAY + '/@connections/' + userConnection, {
        method: 'POST',
        body: JSON.stringify(message)
    })
}