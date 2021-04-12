import { ThrowableRouter, StatusError } from 'itty-router-extras'
import { cors } from '../helpers/cors'
import { feRouter } from '../routers/frontend'
import { authRouter } from '../routers/auth/auth'
import { gatewayRouter } from '../routers/gateway/gateway'
import { DEBUG } from '../constants'

const localRouter = ThrowableRouter()

localRouter
  .options('*', cors)
  .all('/api/auth/*', authRouter.handle)
  .all('/api/gateway/*', gatewayRouter.handle)
  .all('/api/*', () => {
    throw new StatusError(404, 'Api route not found')
  })
  .get('/ping', () => new Response('pong'))
  
if (!DEBUG) {
  localRouter.all('*', feRouter.handle)
} else {
  localRouter.all('*', () => { 
    throw new StatusError(404, 'route not found - pages not availible in dev')
  })
}

export const router = localRouter