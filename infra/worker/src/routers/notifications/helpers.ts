import { FIREBASE_FCM_ENDPOINT } from '../../constants'

const DEVICE_TOKEN_SEPERATOR = ',,,@@@!'

interface IMessageDataPayload {
    typename: string
    [key: string]: unknown
}

export const getUserDeviceIds = async (userId: string): Promise<Set<string>> => {
    return new Set((await DEVICE_TOKENS.get(userId))?.split(DEVICE_TOKEN_SEPERATOR) ?? [])
}

export const removeDeviceIdFromUser = async (userId: string, deviceId: string): Promise<void> => {
    const tokens = await getUserDeviceIds(userId)
    tokens.delete(deviceId)
    await DEVICE_TOKENS.put(userId, Array.from(tokens).join(DEVICE_TOKEN_SEPERATOR))
}

export const addDeviceIdToUser = async (userId: string, deviceId: string): Promise<void> => {
    const tokens = await getUserDeviceIds(userId)
    tokens.add(deviceId)
    await DEVICE_TOKENS.put(userId, Array.from(tokens).join(DEVICE_TOKEN_SEPERATOR))
}

export const sendNotification = async <T extends IMessageDataPayload>(userIds: string[], notificationData: T): Promise<void> => {
    //TODO make this concurrent
    for (const userId of userIds) {
        const deviceIds = await getUserDeviceIds(userId)

        for (const deviceId of deviceIds) {
            const body = JSON.stringify({
                data: notificationData,
                to: deviceId
            })


            const a = await fetch(FIREBASE_FCM_ENDPOINT, {
                headers: {
                    Authorization: `key=${FIREBASE_FCM_KEY}`,
                    'Content-Type': 'application/json'
                },
                method: 'POST',
                body
            })

            const text = JSON.parse(await a.text())

            if (text.results[0].error) {
                await removeDeviceIdFromUser(userId, deviceId)
            }
        }
    }


}

