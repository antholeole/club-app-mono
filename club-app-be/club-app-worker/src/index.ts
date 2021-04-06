import { router } from './routers'

addEventListener('fetch', async (event) => {
  event.respondWith((router.handle(event.request, event)))
})

