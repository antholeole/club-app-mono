import { json } from 'itty-router-extras'
import { IAuthActionInput } from '../../../helpers/event_listeners'
import { validateDownloadBucketPaths, fileExists, generateDownloadBucketLink } from './helpers'

export interface IGetSignedDownloadRequest {
    sourceId: string,
    uploadType: 'GroupAvatar' | 'UserAvatar' | 'Message'
}

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
            break
    }

    if (!(await fileExists(url))) {
        return json({
            downloadUrl: null
        })
    }

    return json({
        downloadUrl: await generateDownloadBucketLink(url)
    })
}

