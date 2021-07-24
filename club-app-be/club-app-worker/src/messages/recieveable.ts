import { Record, String, Array } from 'runtypes'
import { BaseMessages } from './message_types'

export const RecieveableMessage = Record({
    id: String,
    event: Record({
        multiValueHeaders: Record({
            authorization: Array(String)
        })
    }),
    message: BaseMessages
})