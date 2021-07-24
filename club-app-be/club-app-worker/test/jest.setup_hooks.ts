import { StatusError } from 'itty-router-extras'
import { MockKvs } from './fixtures/mock_kvs'

global.afterEach(() => {
    const kvs = [ONLINE_USERS, PUBLIC_KEYS, REFRESH_TOKENS];

    (kvs as unknown as MockKvs[]).forEach(kv => kv.clear())
})


global.beforeAll(() => {
    process.on('unhandledRejection', (err) => {
      fail(err)
    })

    expect.extend({
        async toThrowStatusError(resp: Promise<Response>, expected: number): Promise<jest.CustomMatcherResult> {
          try {
            await resp
          } catch (e) {
            if (!(e instanceof StatusError)) {
              return {
                message: () => `handler threw ${typeof e} instead of StatusError`,
                pass: false
              }
            }
    
            if (e.status != expected) {
              return {
                message: () => `handler threw status ${e.status}, not ${expected}`,
                pass: false
              }
            }
    
            return {
              message: () => 'pass',
              pass: true
            }
          }
          return {
            message: () => 'handler did not throw',
            pass: false,
          }
        },
      })
})