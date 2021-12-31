import { PutObjectCommand, PutObjectCommandInput } from '@aws-sdk/client-s3'
import { getSignedUrl } from '@aws-sdk/s3-request-presigner'
import { B2_ENDPOINT } from '../../constants'
import { S3Client } from '@aws-sdk/client-s3'
import { cryptoRandomString } from '../../helpers/crypto'
import { join } from 'path'
import { getGroupFromThread, validateUserIsOwner } from './gql_queries'
import { StatusError } from 'itty-router-extras'

/// validates that the required permissions are satisfied;
/// returns satisfied bucketPath.
export const validateBucketPaths = {
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

   message: async (threadId: string, userId: string): Promise<string> => {
      const maybeGroupId = await getGroupFromThread(userId, threadId)

      if (!maybeGroupId) {
         throw new StatusError(400, 'user not in thread')
      }

      return `groups/${maybeGroupId}/${threadId}`
   },
   groupAvatarUrl: async (groupId: string, userId: string): Promise<string> => {
      const userOwnsGroup = await validateUserIsOwner(userId, groupId)

      if (!userOwnsGroup) {
         throw new StatusError(400, 'user does not own group')
      }

      return `groups/${groupId}/avatar`
   },
   userAvatarUrl: async (userId: string): Promise<string> => {
      //no validation required; user-id gotten from x-hasura-id, 
      //which means that it can't be spoofed.
      return `users/${userId}`
   }
}

export const generateBucketLink = async (
   bucketPath: string,
   contentLength: number,
   contentType: string
): Promise<string> => {
   const generatedKey = cryptoRandomString(50)

   const bucketParams: PutObjectCommandInput = {
      Bucket: 'dev-club-app',
      Key: join(bucketPath, generatedKey),
      ContentLength: contentLength,
      ContentType: contentType
   }

   const command = new PutObjectCommand(bucketParams)

   const client = new S3Client({
      endpoint: B2_ENDPOINT,
      credentials: {
         'accessKeyId': B2_ACCESS_KEY_ID,
         'secretAccessKey': B2_SECRET_ACCESS_KEY,
      },
      'region': 'us-west-000'
   })

   const signedUrl = await getSignedUrl(client, command, {
      expiresIn: 3600
   })

   return signedUrl
}
