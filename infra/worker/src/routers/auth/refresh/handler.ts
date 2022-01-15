import { getDecryptedKV } from 'encrypt-workers-kv'
import { json, StatusError } from 'itty-router-extras'
import { IActionInput } from '../../../helpers/event_listeners'
import { generateAccessToken } from '../helpers'

export interface IRefreshRequest {
    refreshToken: string
    userId: string
}

export const refreshRoute = async (input: IActionInput<IRefreshRequest>): Promise<Response> => {
    let decryptedHash: ArrayBuffer
    try {
        decryptedHash = await getDecryptedKV(REFRESH_TOKENS, input.input.userId, SECRET)
    } catch (e: unknown) {
        // eslint-disable-next-line @typescript-eslint/ban-types
        if ((e as object).constructor.name == 'NotFoundError') {
            throw new StatusError(404, `user with id ${input.input.userId} not found`)
        } else {
            throw e
        }
    }

    if (new TextDecoder().decode(decryptedHash) === input.input.refreshToken) {
        return json({ accessToken: await generateAccessToken(input.input.userId) })
    } else {
        throw new StatusError(402, `invalid refresh token ${input.input.refreshToken}`) //returns 402 to avoid loop
    }
}
