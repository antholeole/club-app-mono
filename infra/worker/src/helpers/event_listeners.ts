import { StatusError } from 'itty-router-extras'
import { errorHandler } from './error_handler'

export interface IActionInput<T> {
    action: string,
    input: T,
    session_variables: {
        [k: string]: unknown
    }
}

export interface IHookInput<T> extends IActionInput<T> {
    event: {
        session_variables: {
            'x-hasura-user-id': string
        },
        data: {
            old: T,
            new: T
        }
    },
    trigger: {
        name: string
    },
}

export interface IAuthActionInput<T> extends IActionInput<T> {
    session_variables: {
        'x-hasura-user-id': string
    },
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const verifyReqFromServer = (req: Request, jsonBody: any): jsonBody is IActionInput<any> => {
    if (req.headers.get('WEBHOOK_SECRET_KEY') != WEBHOOK_SECRET_KEY) {
        //TODO security report
        throw new StatusError(401, 'unauthorized endpoint access')
    }

    return true
}

export function addAuthRouteEventListener<T>(route: (req: IAuthActionInput<T>) => Promise<Response>): void {
    addEventListener('fetch', async (event) => {
        const eventResponder = async (): Promise<Response> => {
            const req = event.request
            try {
                const body = await req.json()

                verifyReqFromServer(req, body)

                if (body.session_variables?.['x-hasura-user-id'] == null) {
                    throw new StatusError(401, 'please authorize')
                }

                const res = await route(body)
                return res
            } catch (e) {
                return errorHandler(e)
            }
        }

        event.respondWith(eventResponder())
    })
}

export function addServerRequestEventListener<B, T extends IActionInput<B>>(route: (req: T) => Promise<Response>): void {
    addEventListener('fetch', async (event) => {
        const eventResponder = async (): Promise<Response> => {
            const req = event.request
            try {
                const body = await req.json()

                verifyReqFromServer(req, body)

                const res = await route(body)
                return res
            } catch (e) {
                return errorHandler(e)
            }
        }

        event.respondWith(eventResponder())
    })
}

