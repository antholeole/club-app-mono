import { HASURA_ENDPOINT } from '../constants'

export const gqlReq = async <T>(req: string): Promise<T> => {
    const response = await fetch(HASURA_ENDPOINT, {
        body: JSON.stringify({ query: req }),
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'x-hasura-admin-secret': HASURA_PASSWORD
        },
    })
    
    if (!response.ok) {
        return new Promise((_, reject) => {
            response
                .text()
                .then((text) => {
                    try {
                        reject(JSON.parse(text))
                    } catch (err) {
                        reject(text)
                    }
                })
                .catch(reject)
        })
    }

    const json = await response.json()
    return json.data
}
