import { STANDARD_SUCCESS_JSON } from '../../constants'
import { IAuthActionInput, IHookInput } from '../../helpers/action_input'
import { IHandleDeviceToken } from './types'

//resonable level of entropy.
//typically, device tokens are alphanumberic and a -,
//but there's no harm in being safe
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

export const handleNewMessageSent = async (req: IHookInput<string>): Promise<Response> => {
    console.log(req.event.data.new)
    return STANDARD_SUCCESS_JSON
}