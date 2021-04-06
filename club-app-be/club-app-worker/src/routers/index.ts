import { ThrowableRouter, StatusError } from 'itty-router-extras'
import { cors } from '../helpers/cors'
import { feRouter } from '../routers/frontend'
import { authRouter } from '../routers/auth/auth'
import { gatewayRouter } from '../routers/gateway/gateway'

const localRouter = ThrowableRouter()

localRouter
  .options('*', cors)
  .all('/api/auth/*', authRouter.handle)
  .all('/api/gateway/*', gatewayRouter.handle)
  .all('/api/*', () => {
    throw new StatusError(404, 'Api route not found')
  })
  .get('/ping', () => new Response('pong'))
  .all('*', feRouter.handle)

export const router = localRouter