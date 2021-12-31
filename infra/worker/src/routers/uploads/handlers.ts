
import { json, StatusError } from 'itty-router-extras'
import { MAX_FILE_SIZE, VALID_CONTENT_TYPES } from '../../constants'
import { IAuthActionInput } from '../../helpers/action_input'
import { generateBucketLink, validateBucketPaths } from './helpers'
import { IInsertImageRequest } from './types'

export const getSignedUrl = async (req: IAuthActionInput<IInsertImageRequest>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']
    const sourceId = req.input.sourceId

    if (req.input.fileSize > MAX_FILE_SIZE) {
        throw new StatusError(400, 'Max file size is 5MB')
    }

    if (!VALID_CONTENT_TYPES.includes(req.input.contentType)) {
        throw new StatusError(400, `must be gif, jpeg, or png. got: ${req.input.contentType}`)
    }

    let url: string
    switch (req.input.uploadType) {
        case 'Message':
            url = await validateBucketPaths.message(sourceId, userId)
            break
        case 'GroupAvatar':
            url = await validateBucketPaths.groupAvatarUrl(sourceId, userId)
            break
        case 'UserAvatar':
            url = await validateBucketPaths.userAvatarUrl(userId)
            break
    }

    return json({
        uploadUrl: generateBucketLink(url, req.input.fileSize, req.input.contentType)
    })
}