import { Router } from 'itty-router'
import { simpleRoute } from '../../helpers/simple_route'
import { EmptyRecieveable, RecieveableMessage } from '../../messages/recieveable'
import { connectRoute, disconnectRoute, messageRoute } from './handlers'


export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', (req: Request) => simpleRoute(req, EmptyRecieveable, connectRoute))
gatewayRouter.post('/disconnect', (req: Request) => simpleRoute(req, EmptyRecieveable, disconnectRoute))
gatewayRouter.post('/message', (req: Request) => simpleRoute(req, RecieveableMessage, messageRoute))
