import type { IWsMessageMessage } from './discriminators'

export const handleMessageMessage = async (message: IWsMessageMessage): Promise<void> => {
    console.log('hi, ' + message.message.message)
}