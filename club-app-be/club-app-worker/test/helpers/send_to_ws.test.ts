import { Static } from 'runtypes'
import { sendToWs } from '../../src/helpers/send_to_ws'
import { Uuid } from '../../src/helpers/types'
import { MessageTypes } from '../../src/messages/message_types'
import { SendableMessage } from '../../src/messages/sendable'
import { UUID } from '../fixtures/uuid'

describe('send to ws', () => {
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
            await expect(async () => await sendToWs(testMessage)).toThrowStatusError(404)})
    })

    describe('user found', () => {
        const WS_ID = '9asdja903@'

        beforeEach(() => {
            ONLINE_USERS.put(SEND_TO_ID, WS_ID)
        })

        test('should throw error if post fails to connect', async () => {
            fetchMock.mockAbort()

            await expect(async () => await sendToWs(testMessage)).toThrowStatusError(502)
        })

        test('should throw error if post not return 2xx', async () => {
            fetchMock.mockResolvedValueOnce(new Response(JSON.stringify({
                'test': 'Test'
            }), {
                status: 411
            }))

            await expect(async () => await sendToWs(testMessage)).toThrowStatusError(503)
        })

        test('should url encode ws connection id', async () => {
            fetchMock.mockResolvedValueOnce(new Response('hi'))

            await sendToWs(testMessage)

            const mockedUrl = fetchMock.mock.calls[0][0] as string
            
            expect(mockedUrl?.split('/').pop()).toEqual(encodeURIComponent(WS_ID))
        })
    })
})