import { StatusError } from 'itty-router-extras'
import { Router } from 'itty-router'
import { cors } from '../helpers/cors'
import { feRouter } from '../routers/frontend'
import { authRouter } from './auth/router'
import { gatewayRouter } from './gateway/router'
import { DEBUG } from '../constants'

const localRouter = Router()

localRouter
  .options('*', cors)
  .all('/api/auth/*', authRouter.handle)
  .all('/api/gateway/*', gatewayRouter.handle)
  .get('/api/ping', () => new Response('pong'))
  .all('/api/*', () => {
    throw new StatusError(404, 'Api route not found')
  })

if (!DEBUG) {
  localRouter.all('*', feRouter.handle)
} else {
  localRouter.all('*', () => {
    throw new StatusError(404, 'route not found - pages not availible in dev')
  })
}

export const router = localRouter