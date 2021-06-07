import { DiscriminatorError } from '../../helpers/discriminator_error'

const validProviders = <const>[
    'Google',
    'Debug'
]

export interface IAccessTokenRequest {
    idToken: string
    from: typeof validProviders[number]
}

export const discrimiateAccessToken = (input: Record<string, unknown>): IAccessTokenRequest => {
    const inputAsAccessToken = input as unknown as IAccessTokenRequest
    if (inputAsAccessToken.from && validProviders.includes(inputAsAccessToken.from) && inputAsAccessToken.idToken) {
        return inputAsAccessToken
    } else {
        throw new DiscriminatorError()
    }
}

export interface IRefresh {
    userId: string,
    refreshToken: string
}

export const discriminateRefresh = (input: Record<string, unknown>): IRefresh => {
    const inputAsRefresh = input as unknown as IRefresh
    if (inputAsRefresh.userId && inputAsRefresh.refreshToken) {
        return inputAsRefresh
    } else {
        throw new DiscriminatorError()
    }
}