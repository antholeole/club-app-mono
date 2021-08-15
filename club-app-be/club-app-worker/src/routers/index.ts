import { StatusError } from 'itty-router-extras'
import { Router } from 'itty-router'
import { cors } from '../helpers/cors'
import { authRouter } from './auth/router'
import { gatewayRouter } from './gateway/router'

const localRouter = Router()

localRouter
  .options('*', cors)
  .all('/api/auth/*', authRouter.handle)
  .all('/api/gateway/*', gatewayRouter.handle)
  .get('/api/ping', () => new Response('pong'))
  .all('/api/*', () => {
    throw new StatusError(404, 'Api route not found')
  })

export const router = localRouter