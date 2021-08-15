import { StatusError } from 'itty-router-extras'
import { HASURA_ENDPOINT } from '../constants'

export const gqlReq = async <T>(req: string): Promise<T> => {
    let response: Response

    try {
        response = await fetch(HASURA_ENDPOINT, {
            body: JSON.stringify({ query: req }),
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'x-hasura-admin-secret': HASURA_PASSWORD
            },
        })
    } catch (e) {
        console.error(e)
        throw new StatusError(502, `Error connecting to GQL endpoint: ${e.message}`)
    }

    if (!response.ok) {
        throw new StatusError(502, `error connecting to GQL endpont: ${await response.text()}`)
    }

    const json = await response.json()
    return json.data
}
