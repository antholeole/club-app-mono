import { Static } from 'runtypes'
import { decodeJwt } from '../../../src/helpers/jwt'
import { MessageTypes } from '../../../src/messages/message_types'
import { EmptyRecieveable } from '../../../src/messages/recieveable'
import { connectRoute, disconnectRoute, messageRoute } from '../../../src/routers/gateway/handlers'
import { handleEditMessage } from '../../../src/routers/gateway/message_handlers'
import { UUID } from '../../fixtures/uuid'

jest.mock('../../../src/routers/gateway/message_handlers')
jest.mock('../../../src/helpers/jwt')

const mockDecodeJwt = decodeJwt as jest.Mock
const mockHandleEditMessage = handleEditMessage as jest.Mock


describe('gateway handlers', () => {
    const id = 'asdasdasdjoiasjdoia3i49'
    const sub = 'sub'
    
    const mockWsMessage: Static<typeof EmptyRecieveable> = {
        id,
        event: {
            multiValueHeaders: {
                authorization: ['fake auth']
            }
        }
    }


    beforeEach(() => {
        mockDecodeJwt.mockReturnValue({
            sub
        })
    })

    afterEach(() => {
        mockDecodeJwt.mockReset()
    })

    describe('connect route', () => {
        test('should throw 401 if no authorization header', async () => {
            await expect(async () => await connectRoute({
                id,
                event: {
                    multiValueHeaders: {
                        authorization: []
                    }
                }
            })).toThrowStatusError(401)
        })

        describe('on successful request', () => {
            test('should return 200', async () => {
                const resp = await connectRoute(mockWsMessage)
                expect(resp.status).toEqual(200)
            })

            test('should add online user', async () => {
                await connectRoute(mockWsMessage)
                expect(await ONLINE_USERS.get(sub)).toEqual(id)
            })
        })
    })

    describe('disconnect', () => {
        test('should call decodeJwt without caring about exipiration', async () => {
            await disconnectRoute(mockWsMessage)
            expect(mockDecodeJwt.mock.calls[0][1]).toBe(true)
        })

        describe('online users', () => {
            test('should delete online user', async () => {
                await ONLINE_USERS.put(sub, 'no matter')

                await disconnectRoute(mockWsMessage)

                expect(await ONLINE_USERS.get(sub)).toBeNull()

            })
        })

        test('should ignore throws from inside kvs', async () => {
            const resp = await disconnectRoute(mockWsMessage)
            expect(resp.status).toEqual(200)
        })
    })

    describe('message', () => {
        const fakeMessage = {
            ...mockWsMessage,
            message: {
                type: MessageTypes.edit as MessageTypes.edit,
                messageId: UUID
            },
        }

        test('should throw if user offline', async () => {
            await expect(async () => await messageRoute(fakeMessage)).toThrowStatusError(404)
        })

        test('should call correct message handler', async () => {
            await ONLINE_USERS.put(sub, 'asdas')
            
            await messageRoute(fakeMessage)

            expect(mockHandleEditMessage.mock.calls.length).toBe(1)
        })
    })
})