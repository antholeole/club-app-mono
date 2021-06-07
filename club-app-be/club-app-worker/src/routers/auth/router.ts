import { readJsonBody } from '../../helpers/read_json_body'
import { Router } from 'itty-router'
import { discrimiateAccessToken, discriminateRefresh } from './discriminators'
import { refreshRoute, registerRoute } from './handlers'


export const authRouter = Router({
  base: '/api/auth'
})

authRouter.post('/', async (req: Request) => {
  const body = discrimiateAccessToken(await readJsonBody(req))
  return await registerRoute(body)
})

authRouter.post('/refresh', async (req: Request) => {
  const refreshParams = discriminateRefresh(await readJsonBody(req))
  return await refreshRoute(refreshParams)
})
