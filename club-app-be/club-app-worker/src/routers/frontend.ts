import { getAssetFromKV } from '@cloudflare/kv-asset-handler'
import { Router } from 'itty-router'

export const feRouter = Router()

const fetchFromPages = (event: FetchEvent) => event.respondWith(getAssetFromKV(event))


feRouter.get('/tos.html', (_, event: FetchEvent) => fetchFromPages(event))
feRouter.get('/privacy.html', (_, event: FetchEvent) => fetchFromPages(event))
feRouter.get('/', (_, event: FetchEvent) => fetchFromPages(event))

//images
feRouter.get('/logo.png', (_, event: FetchEvent) => fetchFromPages(event))
