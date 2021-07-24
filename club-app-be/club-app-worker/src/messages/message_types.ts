
import { Literal, Record, Union, String } from 'runtypes'
import { Uuid } from '../helpers/types'

export enum MessageTypes {
    message = 'Message',
    edit = 'Edit',
}

const messageTypes = Union(Literal(MessageTypes.message), Literal(MessageTypes.edit))


export const BaseMessage = Record({
    type: messageTypes
})

export const MessageMessage = BaseMessage.extend({
    type: Literal(MessageTypes.message),
    data: String,
    toId: Uuid
})

export const EditMessage = BaseMessage.extend({
    type: Literal(MessageTypes.edit),
    messageId: Uuid
})

export const BaseMessages = Union(MessageMessage, EditMessage)

