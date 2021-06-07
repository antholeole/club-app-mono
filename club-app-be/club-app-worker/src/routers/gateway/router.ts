import { Router } from 'itty-router'
import { readJsonBody } from '../../helpers/read_json_body'
import { discrimiateWsConnectMessage } from './discriminators'
import { connectRoute } from './handlers'

export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', async (req: Request) => {
  const message = discrimiateWsConnectMessage(await readJsonBody(req))
  return connectRoute(message)
})