import { Router } from 'itty-router'
import { response } from 'cfw-easy-utils'
import { feRouter } from './routers/frontend'
import { authRouter } from './routers/auth/auth'
import { GlobalError } from './helpers/global_error'
import { gatewayRouter } from './routers/gateway/gateway'

const router = Router()


router
  .all('/auth/*', authRouter.handle)
  .all('/gateway/*', gatewayRouter.handle)
  .all('/*', feRouter.handle)
  .all('*', () => new Response('Not Found.', { status: 404 }))

// attach the router "handle" to the event handler
addEventListener('fetch', async (event) => {
  if (event.request.method == 'OPTIONS') {
    event.respondWith(response.cors())
  }


  event.respondWith((router.handle(event.request, event) as Promise<Response>).catch((e) => {
    if (e instanceof GlobalError) {
       return response.json({
        'error': e.message,
        'status': e.status
      }, {
        status: e.status,
        statusText: e.message
      })
    } else {
      throw e
    }
  }))
})

