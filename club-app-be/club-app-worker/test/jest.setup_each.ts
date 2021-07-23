import { MockKvs } from './fixtures/mock_kvs'

global.afterEach(() => {
    const kvs = [ONLINE_USERS, PUBLIC_KEYS, REFRESH_TOKENS];

    (kvs as unknown as MockKvs[]).forEach(kv => kv.clear())
})
