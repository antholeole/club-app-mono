import { readJsonBody } from './read_json_body'
import { Runtype } from 'runtypes'

export const simpleRoute = async <T>(req: Request, reqType: Runtype<T>, to: (body: T) => PromiseLike<Response>): Promise<Response> => {
    const body = reqType.check(await readJsonBody(req))
    return await to(body)
}