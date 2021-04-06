import { getAssetFromKV, Options } from '@cloudflare/kv-asset-handler'
import { Router } from 'itty-router'
import { DEBUG, DOMAIN } from '../constants'

export const feRouter = Router()

async function handleEvent(event: FetchEvent) {
  const options: Partial<Options> = {}

    options.mapRequestToAsset = (req) => {
        //if we are just using the main route
        if (['', '/'].includes(req.url.replace('https://', '').replace('http://', '').replace(DOMAIN, ''))) {
            return new Request('https://' + DOMAIN + '/index.html')
        } 


        //if there is no file extension
        const maybeExt = req.url.split('.').pop() ?? 'NOT AN EXT'
        if (['css', 'txt', 'js', 'jpeg', 'png', 'jpg', 'ico', 'gif'].indexOf(maybeExt) === -1) {
            console.log(req.url.split('.').pop() ?? '')
            const withHtml = req.url + '.html'
            return new Request(withHtml)
        }

        return req
    }

  try {
    if (DEBUG) {
      options.cacheControl = {
        bypassCache: true,
      }
    }
    return await getAssetFromKV(event, options)
  } catch (e) {
    if (!DEBUG) {
    const notFoundResponse = await getAssetFromKV(event, {
        mapRequestToAsset: req => new Request(`${new URL(req.url).origin}/404.html`, req),
    })

    return new Response(notFoundResponse.body, { ...notFoundResponse, status: 404 })
    }

    return new Response(e.message || e.toString(), { status: 500 })
  }
}


const fetchFromPages = (event: FetchEvent) => event.respondWith(handleEvent(event))


feRouter.get('/*', (_, event: FetchEvent) => fetchFromPages(event))
