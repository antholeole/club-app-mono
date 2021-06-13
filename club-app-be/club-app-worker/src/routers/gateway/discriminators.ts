import { DiscriminatorError } from '../../helpers/discriminator_error'
import { isUUID } from '../../helpers/uuid_validator'
import { MessageType } from './message_handlers'


interface IWsMessageShape {
    id: string,
    event: {
        multiValueHeaders: {
            authorization: string[]
        }
    }
}

export interface IWsMessage extends IWsMessageShape {
    message: {
        type: MessageType
    }
}

export type IWsConnectMessage = IWsMessageShape

const discriminateWsMessageShape = (input: Record<string, unknown>): IWsMessageShape => {
    const inputAsAccessToken = input as unknown as IWsConnectMessage
    if (inputAsAccessToken.event.multiValueHeaders?.authorization?.[0]
        && inputAsAccessToken.id) {
        return inputAsAccessToken
    } else {
        throw new DiscriminatorError()
    }
}
export const discrimiateWsConnectMessage = (input: Record<string, unknown>): IWsConnectMessage =>
    discriminateWsMessageShape(input)


export const discrimiateWsMessage = (input: Record<string, unknown>): IWsMessage => {
    const wsMsg = discriminateWsMessageShape(input) as IWsMessage

    if (wsMsg.message.type != null && Object.values(MessageType).includes(wsMsg.message.type)) {
        return wsMsg
    } else {
        throw new DiscriminatorError()
    }
}


const toMessageTypes = <const>[
    'thread',
    'dm'
]

//message type discriminators
export interface IWsMessageMessage extends IWsMessage {
    message: {
        type: MessageType
        message: string
        to: [typeof toMessageTypes[number], string]
    }
}

export const discriminateMessageMessage = (input: IWsMessage): IWsMessageMessage => {
    const inputAsMessageMessage = input as IWsMessageMessage

    if (inputAsMessageMessage.message.message != null &&
        toMessageTypes.includes(inputAsMessageMessage.message.to[0]) &&
        isUUID(inputAsMessageMessage.message.to[1])
    ) {
        return inputAsMessageMessage
    } else {
        throw new DiscriminatorError()
    }
}
