import { DiscriminatorError } from '../../helpers/discriminator_error'

const validProviders = <const>[
    'Google'
  ]

export interface IAccessToken {
    idToken: string
    from: typeof validProviders[number],
    name?: string,
    email?: string
}

export const discrimiateAccessToken = (input: unknown): IAccessToken => {
    const inputAsAccessToken = input as IAccessToken
    if (inputAsAccessToken.from && validProviders.includes(inputAsAccessToken.from) && inputAsAccessToken.idToken) {
        return input as IAccessToken
    } else {
        throw new DiscriminatorError()
    }
}

export interface IRefresh {
    userId: string,
    refreshToken: string
}

export const discriminateRefresh = (input: unknown): IRefresh => {
    const inputAsRefresh = input as IRefresh
    if (inputAsRefresh.userId && inputAsRefresh.refreshToken) {
        return input as IRefresh
    } else {
        throw new DiscriminatorError()
    }
}