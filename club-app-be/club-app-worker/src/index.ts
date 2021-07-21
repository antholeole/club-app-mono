import { router } from './routers'
import { errorHandler } from './error_handler'

addEventListener('fetch', async (event) => {
  event.respondWith((router.handle(event.request, event) as Promise<Response>).catch(errorHandler))
})

