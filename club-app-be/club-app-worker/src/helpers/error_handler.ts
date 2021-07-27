import { StatusError } from 'itty-router-extras'
import { ValidationError } from 'runtypes'

export const errorHandler = (e: Error): Response => {
    if (e instanceof ValidationError) {
        return new Response(e.message, {
            status: 400,
            statusText: e.message
        })
    }
    if (e instanceof StatusError) {
        return new Response(e.message, {
            status: (e as unknown as { status: number }).status,
            statusText: e.message
        })
    } else {
        console.error(e)
        console.error(e.message)
        console.error(e.name)
        throw e
    }

}