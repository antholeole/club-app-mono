
import { json } from 'itty-router-extras'
import { IAuthActionInput } from '../../helpers/action_input'
import { generateGroupAvatarUrl, generateMessageUrl, generateUserAvatarUrl } from './helpers'
import { IInsertImageRequest } from './types'

export const getSignedUrl = async (req: IAuthActionInput<IInsertImageRequest>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']
    const sourceId = req.input.imageData.sourceId

    let url: string
    switch (req.input.imageData.uploadType) {
        case 'Message':
            url = generateMessageUrl(sourceId, userId)
            break
        case 'GroupAvatar':
            url = generateGroupAvatarUrl(sourceId, userId)
            break
        case 'UserAvatar':
            url = generateUserAvatarUrl(userId)
            break
    }



    return json({
        uploadUrl: url
    })
}