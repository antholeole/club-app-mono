import { Router } from 'itty-router'
import { authRoute } from '../../helpers/action_input'
import { getSignedDownloadUrl, getSignedUploadUrl } from './handlers'



export const fileRouter = Router({
    base: '/api/file'
})

fileRouter.post('/upload', async (req: Request) => await authRoute(req, getSignedUploadUrl))
fileRouter.post('/download', async (req: Request) => await authRoute(req, getSignedDownloadUrl))