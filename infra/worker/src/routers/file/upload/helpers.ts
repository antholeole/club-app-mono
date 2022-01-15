/// validates that the required permissions are satisfied;

import { PutObjectCommandInput, PutObjectCommand } from '@aws-sdk/client-s3'
import { getSignedUrl } from '@aws-sdk/s3-request-presigner'
import { StatusError } from 'itty-router-extras'
import { BUCKET_NAME } from '../../../constants'
import { cryptoRandomString } from '../../../helpers/crypto'
import { validateUserIsOwner } from './gql_queries'
import { getClient } from '../download/helpers'
import { getGroupFromThread, verifyUserInDm } from '../download/gql_queries'

/// returns satisfied bucketPath.
export const validateUploadBucketPaths = {
    /*
    bucket structure:
    
    BUCKET
       - users
          // <userID>.jpeg
       - groups
          - <groupId>
             //avatar.jpeg
          - <threadId>
             //<generatedImageId>.jpeg
    */

    message: async (threadId: string, userId: string): Promise<[path: string, needImageName: boolean]> => {
        let imagePath: string | null = null

        const maybeGroupId = await getGroupFromThread(userId, threadId)
        if (maybeGroupId) {
            imagePath = `groups/${maybeGroupId}/${threadId}`
        }

        const userInDm = await verifyUserInDm(userId, threadId)
        if (userInDm) {
            imagePath = `dms/${threadId}`
        }

        if (!imagePath) {
            throw new StatusError(400, 'user not in source group')
        }

        return [imagePath, true]
    },
    groupAvatarUrl: async (groupId: string, userId: string): Promise<[path: string, needImageName: boolean]> => {
        const userOwnsGroup = await validateUserIsOwner(userId, groupId)

        if (!userOwnsGroup) {
            throw new StatusError(400, 'user does not own group')
        }

        return [`groups/${groupId}/avatar`, false]
    },
    userAvatarUrl: async (userId: string): Promise<Promise<[path: string, needImageName: boolean]>> => {
        //no validation required; user-id gotten from x-hasura-id, 
        //which means that it can't be spoofed.
        return [`users/${userId}`, false]
    }
}

export const generateUploadBucketLink = async (
    bucketPath: string,
    contentLength: number,
    contentType: string,
    generateKey = false
): Promise<[signedUrl: string, fileName: string | null]> => {
    let path = bucketPath
    const key = cryptoRandomString(50)

    if (generateKey) {
        path = bucketPath + '/' + key
    }



    const bucketParams: PutObjectCommandInput = {
        Bucket: BUCKET_NAME,
        Key: path,
        ContentLength: contentLength,
        ContentType: contentType
    }

    const command = new PutObjectCommand(bucketParams)

    const client = getClient()

    const signedUrl = await getSignedUrl(client, command, {
        expiresIn: 3600
    })

    return [signedUrl, generateKey ? key : null]
}