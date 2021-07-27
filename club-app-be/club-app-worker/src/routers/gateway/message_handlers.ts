import type { Static } from 'runtypes'
import { EditMessage, MessageMessage } from '../../messages/message_types'

export const handleMessageMessage = async (message: Static<typeof MessageMessage>): Promise<Response> => {
    console.log('hi, ' + message.data)

    return new Response('hi')
}

export const handleEditMessage = async (message: Static<typeof EditMessage>): Promise<Response> => {
    return new Response(`got it ${message.messageId}`)
}