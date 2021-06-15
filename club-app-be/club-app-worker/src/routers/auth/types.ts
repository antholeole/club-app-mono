export const validProviders = <const>[
    'Google',
    'Debug'
]

export interface IAccessTokenRequest {
    idToken: string
    from: typeof validProviders[number]
}

export interface IRefresh {
    userId: string,
    refreshToken: string
}
