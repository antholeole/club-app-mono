import { expect } from 'chai'
import { StatusError } from 'itty-router-extras'
import { getDecryptedKV, putEncryptedKV } from 'encrypt-workers-kv'
import { setMockKvs } from '../../fixtures/mock_kvs'
import { setGlobalValue } from '../../fixtures/set_global_value'
import { Crypto } from '@peculiar/webcrypto'
import { createSandbox } from 'sinon'
import * as authHelpers from '../../../src/routers/auth/helpers'
import * as authGqlQueries from '../../../src/routers/auth/gql_queries'
import { refreshRoute, registerRoute } from '../../../src/routers/auth/handlers'

describe('auth routes', () => {
    const sandbox = createSandbox()

    beforeEach(() => {
        sandbox.restore()
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
                sandbox.stub(authGqlQueries, 'getUserBySub').returns(Promise.resolve(null))
            })

            it('should add user with no email', async () => {
                const addUserStub = sandbox.stub(authGqlQueries, 'addUser').returns(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                sandbox.stub(authHelpers, 'verifyIdTokenWithGoogle').returns(Promise.resolve({
                    name: userName,
                    sub: userSub,
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(addUserStub.firstCall.args).deep.equal([userSub, userName, undefined])
            })

            it('should add user with email', async () => {
                const addUserStub = sandbox.stub(authGqlQueries, 'addUser').returns(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                sandbox.stub(authHelpers, 'verifyIdTokenWithGoogle').returns(Promise.resolve({
                    name: userName,
                    sub: userSub,
                    email: userEmail
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(addUserStub.firstCall.args).deep.equal([userSub, userName, userEmail])
            })

            it('should create refresh token', async () => {
                sandbox.stub(authGqlQueries, 'addUser').returns(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                const verifyStub = sandbox.stub(authHelpers, 'verifyIdTokenWithGoogle')

                verifyStub.returns(Promise.resolve({
                    name: userName,
                    sub: userSub,
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET)), 'should have changed refresh token').to.not.be.null

                REFRESH_TOKENS.delete(userId)
                verifyStub.reset()

                verifyStub.returns(Promise.resolve({
                    name: userName,
                    sub: userSub,
                    email: userEmail
                }))

                await registerRoute({
                    from: 'Google',
                    idToken: 'fake.id.token'
                })

                expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET)), 'should have changed refresh token').to.not.be.null
            })
        })

        it('should get old user if one exists', async () => {
            const userName = 'anthony'
            const userSub = 'subject'
            const userId = 'userId'
            const userEmail = 'im an email'

            const startingRefreshToken = 'STARTING REFRESH TOKEN'

            setGlobalValue('crypto', new Crypto())
            setGlobalValue('SECRET', 'IM A SECRET')
            setMockKvs('REFRESH_TOKENS')

            REFRESH_TOKENS.put(userId, startingRefreshToken)

            sandbox.stub(authHelpers, 'verifyIdTokenWithGoogle').returns(Promise.resolve({
                name: userName,
                sub: userSub,
            }))

            sandbox.stub(authGqlQueries, 'getUserBySub').returns(Promise.resolve({
                id: userId,
                name: userName,
                sub: userSub,
                email: userEmail
            }))

            const resp = await registerRoute({
                from: 'Google',
                idToken: 'fake.id.token'
            })

            expect(await resp.json()).to.have.property('id', userId)
            expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET)), 'should have changed refresh token').to.not.equal(startingRefreshToken)
        })
    })

    describe('refresh', () => {
        it('should refresh the token if it exists in the KV storage', async () => {
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

            expect(resp.status).to.equal(200)
        })

        it('should 404 if user does not exist in refresh token', async () => {
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
                expect(e).to.be.instanceOf(StatusError)
                expect(e).to.haveOwnProperty('status', 404)
            }
        })

        it('should 402 if refresh token is different', async () => {
            const testUserId = 'test_id'
            const fakeRefreshToken = 'fake_refresh_token'
            const notFakeRefreshToken = 'not_fake_refresh_token'

            setMockKvs('REFRESH_TOKENS')
            setGlobalValue('SECRET', 'FAKE SECRET')
            setGlobalValue('crypto', new Crypto())

            await putEncryptedKV(REFRESH_TOKENS, testUserId, fakeRefreshToken, SECRET)

            try {
                refreshRoute({
                    userId: testUserId,
                    refreshToken: notFakeRefreshToken
                })
            } catch (e) {
                expect(e).to.be.instanceOf(StatusError)
                expect(e).to.haveOwnProperty('status', 402)
            }
        })
    })
})
