import { StatusError } from 'itty-router-extras'
import { getDecryptedKV, putEncryptedKV } from 'encrypt-workers-kv'
import { setMockKvs } from '../../fixtures/mock_kvs'
import { setGlobalValue } from '../../fixtures/set_global_value'
import { Crypto } from '@peculiar/webcrypto'
import * as authHelpers from '../../../src/routers/auth/helpers'
import * as authGqlQueries from '../../../src/routers/auth/gql_queries'
import { refreshRoute, registerRoute } from '../../../src/routers/auth/handlers'
import makeServiceWorkerEnv from 'service-worker-mock'

// eslint-disable-next-line @typescript-eslint/no-explicit-any, no-var
declare var global: any

describe('auth routes', () => {
    beforeEach(() => {
        Object.assign(global, makeServiceWorkerEnv())
        jest.resetModules()
    })

    beforeEach(() => {
        jest.resetAllMocks()
    })

    describe('get access token', () => {
        describe('new user', () => {
            const userName = 'anthony'
            const userSub = 'subject'
            const userId = 'userId'
            const userEmail = 'im an email'

            beforeEach(() => {
                setGlobalValue('crypto', new Crypto())
                setGlobalValue('SECRET', 'IM A SECRET')
                setMockKvs('REFRESH_TOKENS')
                jest.spyOn(authGqlQueries, 'getUserBySub')
                    .mockReturnValue(Promise.resolve(null))
            })

            test('should add user with no email', async () => {
                const addUserStub = jest.spyOn(authGqlQueries, 'addUser').mockReturnValue(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))


                jest.spyOn(authHelpers, 'verifyIdTokenWithGoogle').mockReturnValue(Promise.resolve({
                    name: userName,
                    sub: userSub,
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(addUserStub.mock.calls[0]).toEqual([userSub, userName, undefined])
            })

            test('should add user with email', async () => {
                const addUserStub = jest.spyOn(authGqlQueries, 'addUser').mockReturnValue(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                jest.spyOn(authHelpers, 'verifyIdTokenWithGoogle').mockReturnValue(Promise.resolve({
                    name: userName,
                    sub: userSub,
                    email: userEmail
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(addUserStub.mock.calls[0]).toEqual([userSub, userName, userEmail])
            })

            test('should create refresh token', async () => {
                jest.spyOn(authGqlQueries, 'addUser').mockReturnValue(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                const verifyStub = jest.spyOn(authHelpers, 'verifyIdTokenWithGoogle')

                verifyStub.mockReturnValue(Promise.resolve({
                    name: userName,
                    sub: userSub,
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET))).not.toBeNull

                REFRESH_TOKENS.delete(userId)
                verifyStub.mockClear()

                verifyStub.mockReturnValue(Promise.resolve({
                    name: userName,
                    sub: userSub,
                    email: userEmail
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                //'should have changed refresh token'
                expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET))).not.toBeNull
            })
        })

        test('should get old user if one exists', async () => {
            const userName = 'anthony'
            const userSub = 'subject'
            const userId = 'userId'
            const userEmail = 'im an email'

            const startingRefreshToken = 'STARTING REFRESH TOKEN'

            setGlobalValue('crypto', new Crypto())
            setGlobalValue('SECRET', 'IM A SECRET')
            setMockKvs('REFRESH_TOKENS')

            REFRESH_TOKENS.put(userId, startingRefreshToken)

            jest.spyOn(authHelpers, 'verifyIdTokenWithGoogle').mockReturnValue(Promise.resolve({
                name: userName,
                sub: userSub,
            }))

            jest.spyOn(authGqlQueries, 'getUserBySub').mockReturnValue(Promise.resolve({
                id: userId,
                name: userName,
                sub: userSub,
                email: userEmail
            }))

            const resp = await registerRoute({
                from: 'Google',
                idToken: 'fake.id.token'
            })

            expect(await resp.json()).toHaveProperty('id', userId)

            //'should have changed refresh token'
            expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET))).not.toEqual(startingRefreshToken)
        })
    })

    describe('refresh', () => {
        test('should refresh the token if it exists in the KV storage', async () => {
            const testUserId = 'test_id'
            const fakeRefreshToken = 'fake_refresh_token'

            setMockKvs('REFRESH_TOKENS')
            setGlobalValue('SECRET', 'FAKE SECRET')
            setGlobalValue('crypto', new Crypto())


            await putEncryptedKV(REFRESH_TOKENS, testUserId, fakeRefreshToken, SECRET)

            const resp = await refreshRoute({
                userId: testUserId,
                refreshToken: fakeRefreshToken
            })

            expect(resp.status).toEqual(200)
        })

        test('should 404 if user does not exist in refresh token', async () => {
            const testUserId = 'test_id'
            const fakeRefreshToken = 'fake_refresh_token'

            setMockKvs('REFRESH_TOKENS')
            setGlobalValue('SECRET', 'FAKE SECRET')
            setGlobalValue('crypto', new Crypto())



            try {
                refreshRoute({
                    userId: testUserId,
                    refreshToken: fakeRefreshToken
                })

            } catch (e) {
                expect(e).toBeInstanceOf(StatusError)
                expect(e).toHaveProperty('status', 404)
            }
        })

        test('should 402 if refresh token is different', async () => {
            const testUserId = 'test_id'
            const fakeRefreshToken = 'fake_refresh_token'
            const notFakeRefreshToken = 'not_fake_refresh_token'

            setMockKvs('REFRESH_TOKENS')
            setGlobalValue('SECRET', 'FAKE SECRET')
            setGlobalValue('crypto', new Crypto())

            await putEncryptedKV(REFRESH_TOKENS, testUserId, fakeRefreshToken, SECRET)

            try {
                refreshRoute({ /ErROR im here
                    userId: testUserId,
                    refreshToken: notFakeRefreshToken
                })
            } catch (e) {
                expect(e).toBeInstanceOf(StatusError)
                expect(e).toHaveProperty('status', 402)
            }
        })
    })
})
