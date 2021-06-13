declare module 'itty-router-extras'

//declared vars
declare const PUBLIC_KEYS: KVNamespace
declare const REFRESH_TOKENS: KVNamespace
declare const ONLINE_USERS: KVNamespace

declare const HASURA_PASSWORD = 'PASSWORD'
declare const SECRET = 'SECRET'
declare const ENVIRONMENT = 'dev'

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type HkdfParams = any
