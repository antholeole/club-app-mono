import { Router } from 'itty-router'
import { AcessTokenRequest, RefreshRequest } from './types'
import { refreshRoute, registerRoute } from './handlers'
import { simpleRoute } from '../../helpers/simple_route'

export const authRouter = Router({
  base: '/api/auth'
})

authRouter.post('/', (req: Request) => simpleRoute(req, AcessTokenRequest, registerRoute))
authRouter.post('/refresh', async (req: Request) => simpleRoute(req, RefreshRequest, refreshRoute))