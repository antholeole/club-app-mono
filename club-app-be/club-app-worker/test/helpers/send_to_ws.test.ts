import { Static } from 'runtypes'
import { sendToWs } from '../../src/helpers/send_to_ws'
import { Uuid } from '../../src/helpers/types'
import { MessageTypes } from '../../src/messages/message_types'
import { SendableMessage } from '../../src/messages/sendable'
import { UUID } from '../fixtures/uuid'

describe('handler returns response with request method', () => {
    const SEND_TO_ID = 'eb48ae7d-aaa0-4cff-8785-20bd536da6d3'

    const testMessage: Static<typeof SendableMessage> = {
        to: SEND_TO_ID,
        message: {
            type: MessageTypes.message,
            data: 'Hello friend!',
            toId: Uuid.check(UUID)
        }
    }

    describe('user not found', () => {
        test('should 404', async () => {
            await expect(sendToWs(testMessage)).toThrowStatusError(404)})
    })

    describe('user found', () => {
        test.todo('should throw error if post fails')
        test.todo('should url encode ws connection id')
    })
})