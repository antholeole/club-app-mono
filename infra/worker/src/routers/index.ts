import { StatusError } from 'itty-router-extras'
import { Router } from 'itty-router'
import { authRouter } from './auth/router'
import { chatRouter } from './chat/router'
import { groupRouter } from './groups/router'
import { uploadRouter } from './uploads/router'

const localRouter = Router()

localRouter
  .all('/api/auth/*', authRouter.handle)
  .all('/api/chat/*', chatRouter.handle)
  .all('/api/group/*', groupRouter.handle)
  .all('/api/upload/*', uploadRouter.handle)
  .get('/api/ping', () => new Response('pong'))
  .all('/api/*', () => {
    throw new StatusError(404, 'Api route not found')
  })

export const router = localRouter