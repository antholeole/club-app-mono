//resonable level of entropy.
//typically, device tokens are alphanumberic and a -,

import { STANDARD_SUCCESS_JSON } from '../../../constants'
import { IAuthActionInput } from '../../../helpers/event_listeners'

export interface IHandleDeviceToken {
    deviceToken: string,
    handleType: 'Add' | 'Remove'
}

const DEVICE_TOKEN_SEPERATOR = ',,,@@@!'

export const handleDeviceTokens = async (req: IAuthActionInput<IHandleDeviceToken>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']

    let tokens = (await DEVICE_TOKENS.get(userId))?.split(DEVICE_TOKEN_SEPERATOR) ?? []

    if (req.input.handleType === 'Remove') {
        tokens = tokens.filter((token) => token !== req.input.deviceToken)
    } else if (!tokens.includes(req.input.deviceToken)) {
        tokens.push(req.input.deviceToken)
    }

    await DEVICE_TOKENS.put(userId, tokens.join(DEVICE_TOKEN_SEPERATOR))

    return STANDARD_SUCCESS_JSON
}
