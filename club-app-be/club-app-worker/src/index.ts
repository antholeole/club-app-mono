import { router } from './routers'
import { StatusError } from 'itty-router-extras'

addEventListener('fetch', async (event) => {
  event.respondWith((router.handle(event.request, event) as Promise<Response>).catch(e => {
    if (e instanceof StatusError) {
      return new Response(e.message, {
        status: e.status,
        statusText: e.message
      })
    } else {
      console.log(e)
      console.log(e.message)
      console.log(e.name)
      throw e
    }
  }))
})

