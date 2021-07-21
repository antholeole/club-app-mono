import { Union, Record, Literal, String } from 'runtypes'

const ValidProviders = Union(
    Literal('Google'),
    Literal('Debug')
)

export const AcessTokenRequest = Record({
    idToken: String,
    from: ValidProviders
})

export const RefreshRequest = Record({
    userId: String,
    refreshToken: String
})
