import { Record, String, Array } from 'runtypes'
import { BaseMessages } from './message_types'

export const EmptyRecieveable = Record({
    id: String,
    event: Record({
        multiValueHeaders: Record({
            authorization: Array(String)
        })
    }),
})

export const RecieveableMessage = EmptyRecieveable.extend({
    message: BaseMessages
})