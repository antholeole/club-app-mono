
import { Literal, Record, Union, String, Array } from 'runtypes'
import { Uuid } from '../../helpers/types'

const messageTypes = Union(
    Literal('Message'),
    Literal('Edit')
)

export const WsMessage = Record({
    id: String,
    event: Record({
        multiValueHeaders: Record({
            authorization: Array(String)
        })
    })
})

const Message = Record({
    type: messageTypes
})


export const WsMessageMessage = WsMessage.extend({
    message: Message.extend({
        message: String,
        toId: Uuid
    })
})
export const WsEditMessage = WsMessage.extend({
    message: Message.extend({
        messageId: Uuid
    })
})

export const RecieveableMessage = Union(WsMessageMessage, WsEditMessage)