import type { WsMessageMessage } from './types'
import type { Static } from 'runtypes'

export const handleMessageMessage = async (message: Static<typeof WsMessageMessage>): Promise<Response> => {
    console.log('hi, ' + message.message.message)

    return new Response('hi')
}