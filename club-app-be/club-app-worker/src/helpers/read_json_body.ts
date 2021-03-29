import { GlobalError } from './global_error'

export const readJsonBody = async (req: Request): Promise<any> => {
    try {
        const t = await req.json()
        return t
    } catch {
        throw new GlobalError('Malformed json in request body.', 400)
    }
}