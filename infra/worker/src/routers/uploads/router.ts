import { Router } from 'itty-router'
import { authRoute } from '../../helpers/action_input'
import { joinRoleWithJoinCodes } from './handlers'



export const uploadRouter = Router({
    base: '/api/upload'
})

uploadRouter.post('/image', async (req: Request) => await authRoute(req, getSignedUrl))