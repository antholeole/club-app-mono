import { STANDARD_SUCCESS_JSON } from '../../../constants'
import { IHookInput } from '../../../helpers/event_listeners'

export interface IMessage {
    message_type: 'TEXT' | 'IMAGE',
    source_id: string,
    body: string,
}

export const handleNewMessageSent = async (req: IHookInput<IMessage>): Promise<Response> => {
    return STANDARD_SUCCESS_JSON
}