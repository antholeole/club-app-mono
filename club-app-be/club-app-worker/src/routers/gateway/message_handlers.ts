import type { Static } from 'runtypes'
import { RecieveableMessageMessage } from '../../messages/recieveable'

export const handleMessageMessage = async (message: Static<typeof RecieveableMessageMessage>): Promise<Response> => {
    console.log('hi, ' + message.message.message)

    return new Response('hi')
}