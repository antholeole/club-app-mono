import { StatusError } from 'itty-router-extras'

export const readJsonBody = async (req: Request | Response): Promise<Record<string, unknown>> => {
    try {
        const t = await req.json()
        return t
    } catch {
        throw new StatusError(400, 'unexpected request body: Expected valid json')
    }
}