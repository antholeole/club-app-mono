
import { json, StatusError } from 'itty-router-extras'
import { MAX_FILE_SIZE, VALID_CONTENT_TYPES } from '../../constants'
import { IAuthActionInput } from '../../helpers/action_input'
import { generateUploadBucketLink, validateUploadBucketPaths, validateDownloadBucketPaths, generateDownloadBucketLink, fileExists } from './helpers'
import { IGetSignedDownloadRequest, IInsertImageRequest } from './types'

export const getSignedDownloadUrl = async (req: IAuthActionInput<IGetSignedDownloadRequest>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']
    const sourceId = req.input.sourceId


    let url: string

    switch (req.input.uploadType) {
        case 'Message':
            url = await validateDownloadBucketPaths.message(sourceId, userId)
            break
        case 'GroupAvatar':
            url = await validateDownloadBucketPaths.groupAvatarUrl(sourceId)
            break
        case 'UserAvatar':
            url = await validateDownloadBucketPaths.userAvatarUrl(sourceId)
            console.log('user avatar url: ', url)
            break
    }

    if (!(await fileExists(url))) {
        console.log('file does not exist @ ', url)
        return json({
            downloadUrl: null
        })
    }

    console.log('file exists @ ', url)

    return json({
        downloadUrl: await generateDownloadBucketLink(url)
    })
}

export const getSignedUploadUrl = async (req: IAuthActionInput<IInsertImageRequest>): Promise<Response> => {
    const userId = req.session_variables['x-hasura-user-id']
    const sourceId = req.input.sourceId

    if (req.input.fileSize > MAX_FILE_SIZE) {
        throw new StatusError(400, 'Max file size is 5MB')
    }

    if (!VALID_CONTENT_TYPES.includes(req.input.contentType)) {
        throw new StatusError(400, `must be gif, jpeg, or png. got: ${req.input.contentType}`)
    }

    let url: string
    let needImageName: boolean
    switch (req.input.uploadType) {
        case 'Message':
            [url, needImageName] = await validateUploadBucketPaths.message(sourceId, userId)
            break
        case 'GroupAvatar':
            [url, needImageName] = await validateUploadBucketPaths.groupAvatarUrl(sourceId, userId)
            break
        case 'UserAvatar':
            [url, needImageName] = await validateUploadBucketPaths.userAvatarUrl(userId)
            break
    }

    const [uploadUrl, imageName] = await generateUploadBucketLink(url, req.input.fileSize, req.input.contentType, needImageName)

    return json({
        uploadUrl,
        imageName
    })
}

