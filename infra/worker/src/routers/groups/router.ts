import { Router } from 'itty-router'
import { authRoute } from '../../helpers/action_input'
import { joinRoleWithJoinCodes } from './handlers'


export const groupRouter = Router({
    base: '/api/group'
})

groupRouter.post('/join/joincode', async (req: Request) => await authRoute(req, joinRoleWithJoinCodes))