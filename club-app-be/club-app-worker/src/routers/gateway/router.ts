import { Router } from 'itty-router'
import { readJsonBody } from '../../helpers/read_json_body'
import { simpleRoute } from '../../helpers/simple_route'
import { connectRoute, disconnectRoute, messageRoute } from './handlers'
import { RecieveableMessage, WsMessage } from './types'

export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', (req: Request) => simpleRoute(req, WsMessage, connectRoute))
gatewayRouter.post('/disconnect', (req: Request) => simpleRoute(req, WsMessage, disconnectRoute))
gatewayRouter.post('/message', (req: Request) => simpleRoute(req, RecieveableMessage, messageRoute))
