import type { Static } from 'runtypes'
import { MessageMessage } from '../../messages/message_types'

export const handleMessageMessage = async (message: Static<typeof MessageMessage>): Promise<Response> => {
    console.log('hi, ' + message.data)

    return new Response('hi')
}