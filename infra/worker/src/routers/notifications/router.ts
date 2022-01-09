import { Router } from 'itty-router'
import { authRoute, hookRoute } from '../../helpers/action_input'
import { handleDeviceTokens, handleNewMessageSent } from './handlers'



export const notificationRouter = Router({
    base: '/api/notifications'
})

notificationRouter.post('/deviceToken', async (req: Request) => await authRoute(req, handleDeviceTokens))
notificationRouter.post('/messageSent', async (req: Request) => await hookRoute(req, handleNewMessageSent))