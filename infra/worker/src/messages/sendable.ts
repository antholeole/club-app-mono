import { Record, String } from 'runtypes'
import { BaseMessages } from './message_types'

export const SendableMessage = Record({
    to: String,
    message: BaseMessages
})