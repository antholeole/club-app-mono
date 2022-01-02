import { GetObjectCommand, GetObjectCommandInput, HeadObjectCommand, HeadObjectCommandInput, PutObjectCommand, PutObjectCommandInput } from '@aws-sdk/client-s3'
import { getSignedUrl } from '@aws-sdk/s3-request-presigner'
import { B2_ENDPOINT, BUCKET_NAME } from '../../constants'
import { S3Client } from '@aws-sdk/client-s3'
import { cryptoRandomString } from '../../helpers/crypto'
import { join } from 'path'
import { getGroupFromMessage, getGroupFromThread, validateUserIsOwner } from './gql_queries'
import { StatusError } from 'itty-router-extras'

/// validates that the required permissions are satisfied;
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
      const maybeGroupId = await getGroupFromThread(userId, threadId)

      if (!maybeGroupId) {
         throw new StatusError(400, 'user not in thread')
      }

      return [`groups/${maybeGroupId}/${threadId}`, true]
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
      path = join(bucketPath, key)
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

export const validateDownloadBucketPaths = {
   message: async (messageId: string, userId: string): Promise<string> => {
      const maybeGroup = await getGroupFromMessage(userId, messageId)

      if (!maybeGroup) {
         throw new StatusError(400, 'user not in thread')
      }

      const [groupId, threadId, imageName] = maybeGroup

      return `groups/${groupId}/${threadId}/${imageName}`
   },
   groupAvatarUrl: async (groupId: string): Promise<string> => {
      //no validation required: all users can see the pfp of all groups
      return `groups/${groupId}/avatar`
   },
   userAvatarUrl: async (userId: string): Promise<string> => {
      //no validation required: all users can see the pfp of all users
      return `users/${userId}`
   }
}


export const generateDownloadBucketLink = async (
   bucketPath: string
): Promise<string> => {
   const bucketParams: GetObjectCommandInput = {
      Bucket: BUCKET_NAME,
      Key: bucketPath
   }

   const command = new GetObjectCommand(bucketParams)

   const client = getClient()

   return await getSignedUrl(client, command, {
      expiresIn: 3600
   })
}

export const fileExists = async (
   bucketPath: string
): Promise<boolean> => {
   const bucketParams: HeadObjectCommandInput = {
      Bucket: BUCKET_NAME,
      Key: bucketPath
   }

   const command = new HeadObjectCommand(bucketParams)

   const client = getClient()

   try {
      await client.send(command)
      return true
   } catch (e) {
      const asS3Error = e as { name: string }

      if (asS3Error.name === 'NotFound') {
         return false
      } else {
         throw e
      }
   }


}

const getClient = () => {
   return new S3Client({
      endpoint: B2_ENDPOINT,
      forcePathStyle: true,
      credentials: {
         'accessKeyId': B2_ACCESS_KEY_ID,
         'secretAccessKey': B2_SECRET_ACCESS_KEY,
      },
      'region': 'us-west-000'
   })
}