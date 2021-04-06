import { StatusError } from 'itty-router-extras'

export const readJsonBody = async (req: Request): Promise<any> => {
    try {
        const t = await req.json()
        return t
    } catch {
        throw new StatusError(400, 'Json body unexpected request body.')
    }
}