import { StatusError } from 'itty-router-extras'

export const errorHandler = (e: unknown): Response => {
    if (e instanceof StatusError) {
        return new Response(JSON.stringify({
            'message': e.message,
            extensions: {
                'code': e.status
            }
        }), {
            status: 400
        })
    } else {
        return new Response(JSON.stringify({
            'message': (e as Error).message || 'unknown error',
        }), {
            status: 400,
        })
    }

}