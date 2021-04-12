import { router } from './routers'

addEventListener('fetch', async (event) => {
  event.respondWith((router.handle(event.request, event) as Promise<Response>).catch((e) => {
    console.log(e)
    console.log(e.message)
    console.log(e.name)
    throw e
  }))
})