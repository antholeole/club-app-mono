import { putEncryptedKV } from 'encrypt-workers-kv'
import { refreshRoute } from '../../../../src/routers/auth/refresh/handler'

describe('refresh', () => {
    test('should refresh the token if it exists in the KV storage', async () => {
        const testUserId = 'test_id'
        const fakeRefreshToken = 'fake_refresh_token'

        await putEncryptedKV(REFRESH_TOKENS, testUserId, fakeRefreshToken, SECRET)

        const resp = await refreshRoute({
            action: 'asdasd',
            input: {
                userId: testUserId,
                refreshToken: fakeRefreshToken
            },
            session_variables: {}
        })

        expect(resp.status).toEqual(200)
    })

    test('should 404 if user does not exist in the KV storage', async () => {
        const testUserId = 'test_id'
        const fakeRefreshToken = 'fake_refresh_token'

        await expect(async () => await refreshRoute({
            action: 'asdasd',
            input: {
                userId: testUserId,
                refreshToken: fakeRefreshToken
            },
            session_variables: {}
        })).toThrowStatusError(404)
    })

    test('should 402 if refresh token is different', async () => {
        const testUserId = 'test_id'
        const fakeRefreshToken = 'fake_refresh_token'
        const notFakeRefreshToken = 'not_fake_refresh_token'

        await putEncryptedKV(REFRESH_TOKENS, testUserId, fakeRefreshToken, SECRET)

        await expect(async () => await refreshRoute({
            action: 'asdasd',
            input: {
                refreshToken: notFakeRefreshToken,
                userId: testUserId
            },
            session_variables: {}
        })).toThrowStatusError(402)
    })
})


