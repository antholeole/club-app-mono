import { StatusError } from 'itty-router-extras'
import { STANDARD_SUCCESS_JSON } from '../../../constants'
import { IHookInput } from '../../../helpers/event_listeners'
import { sendNotification } from '../helpers'
import { determineSourceType, getUsersInDm, getUsersInThread } from './gql_queries'

export interface IMessage {
    message_type: 'TEXT' | 'IMAGE'
    source_id: string
    body: string
    id: string
}



export const handleNewMessageSent = async (req: IHookInput<IMessage>): Promise<Response> => {
    const sentFrom = req.event.session_variables['x-hasura-user-id']

    const groupType = await determineSourceType(req.event.data.new.source_id)

    let sendToUserIds: string[] | null = null

    switch (groupType) {
        case 'dm': {
            sendToUserIds = await getUsersInDm(req.event.data.new.source_id)
            break
        }
        case 'thread': {
            sendToUserIds = await getUsersInThread(req.event.data.new.source_id)
            break
        }
    }


    if (sendToUserIds === null) {
        throw new StatusError(400, 'bad notification type')
    }


    await sendNotification(sendToUserIds
        .filter((v) => v !== sentFrom)
        , {
            typename: 'newMessage',
            messageId: req.event.data.new.id
        })

    return STANDARD_SUCCESS_JSON()
}