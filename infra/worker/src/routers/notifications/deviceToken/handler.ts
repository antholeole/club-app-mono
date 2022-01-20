//resonable level of entropy.
//typically, device tokens are alphanumberic and a -,

import { STANDARD_SUCCESS_JSON } from '../../../constants'
import { IAuthActionInput } from '../../../helpers/event_listeners'
import { addDeviceIdToUser, removeDeviceIdFromUser } from '../helpers'

export interface IHandleDeviceToken {
    deviceToken: string,
    handle: 'Add' | 'Remove'
}



export const handleDeviceTokens = async (req: IAuthActionInput<IHandleDeviceToken>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']

    if (req.input.handle === 'Remove') {
        await removeDeviceIdFromUser(userId, req.input.deviceToken)
    } else if (req.input.handle === 'Add') {
        await addDeviceIdToUser(userId, req.input.deviceToken)
    }

    return STANDARD_SUCCESS_JSON()
}
