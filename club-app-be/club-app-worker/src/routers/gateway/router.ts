import { Router } from 'itty-router'
import { readJsonBody } from '../../helpers/read_json_body'
import { discrimiateWsConnectMessage, discrimiateWsMessage } from './discriminators'
import { connectRoute, disconnectRoute, messageRoute } from './handlers'

export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', async (req: Request) => {
  const message = discrimiateWsConnectMessage(await readJsonBody(req))
  return connectRoute(message)
})

gatewayRouter.post('/disconnect', async (req: Request) => {
  const message = discrimiateWsConnectMessage(await readJsonBody(req))
  return disconnectRoute(message)
})

gatewayRouter.post('/message', async (req: Request) => {
  const message = discrimiateWsMessage(await readJsonBody(req))
  return messageRoute(message)
})
