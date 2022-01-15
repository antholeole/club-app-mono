import { getDecryptedKV } from 'encrypt-workers-kv'
import { registerRoute } from '../../../../src/routers/auth/register/handler'

import * as authHelpers from '../../../../src/routers/auth/register/helpers'
import * as authGqlQueries from '../../../../src/routers/auth/register/gql_queries'

describe('register route', () => {
    describe('new user', () => {
        const userName = 'anthony'
        const userSub = 'subject'
        const userId = 'userId'
        const userEmail = 'im an email'

        beforeEach(() => {
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
                action: 'adasd',
                input: {
                    identityProvider: 'Google',
                    idToken: 'fake.id.token'
                },
                session_variables: {}
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
                action: 'adasd',
                input: {
                    identityProvider: 'Google',
                    idToken: 'fake.id.token'
                },
                session_variables: {}
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
                action: 'adasd',
                input: {
                    identityProvider: 'Google',
                    idToken: 'fake.id.token'
                },
                session_variables: {}
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
                action: 'adasd',
                input: {
                    identityProvider: 'Google',
                    idToken: 'fake.id.token'
                },
                session_variables: {}
            })

            expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET))).not.toBeNull
        })

        describe('provider', () => {
            test('google should verify with google', async () => {
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
                    action: 'adasd',
                    input: {
                        identityProvider: 'Google',
                        idToken: 'fake.id.token'
                    },
                    session_variables: {}
                })

                expect(verifyStub.mock.calls.length).toBe(1)
            })

            test('debug should call get debug key', async () => {
                jest.spyOn(authGqlQueries, 'addUser').mockReturnValue(Promise.resolve({
                    id: userId,
                    name: userName,
                    sub: userSub
                }))

                const verifyStub = jest.spyOn(authHelpers, 'getFakeIdentifier')

                verifyStub.mockReturnValue({
                    name: userName,
                    sub: userSub,
                })

                await registerRoute({
                    action: 'adasd',
                    input: {
                        identityProvider: 'Debug',
                        idToken: JSON.stringify({
                            'name': 'hi',
                            'sub': 'blah'
                        })
                    },
                    session_variables: {}
                })

                expect(verifyStub.mock.calls.length).toBe(1)
            })
        })
    })

    test('should get old user if one exists', async () => {
        const userName = 'anthony'
        const userSub = 'subject'
        const userId = 'userId'
        const userEmail = 'im an email'

        const startingRefreshToken = 'STARTING REFRESH TOKEN'

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
            action: 'adasd',
            input: {
                identityProvider: 'Google',
                idToken: 'fake.id.token'
            },
            session_variables: {}
        })

        expect(await resp.json()).toHaveProperty('id', userId)

        //'should have changed refresh token'
        expect(new TextDecoder().decode(await getDecryptedKV(REFRESH_TOKENS, userId, SECRET))).not.toEqual(startingRefreshToken)
    })
})

