import { GetObjectCommand, GetObjectCommandInput, HeadObjectCommand, HeadObjectCommandInput } from '@aws-sdk/client-s3'
import { getSignedUrl } from '@aws-sdk/s3-request-presigner'
import { B2_ENDPOINT, BUCKET_NAME } from '../../../constants'
import { S3Client } from '@aws-sdk/client-s3'
import { getDmFromMessage, getGroupFromMessage } from './gql_queries'
import { StatusError } from 'itty-router-extras'



export const validateDownloadBucketPaths = {
   message: async (messageId: string, userId: string): Promise<string> => {
      const maybeGroup = await getGroupFromMessage(userId, messageId)
      if (maybeGroup) {
         const [groupId, threadId, imageName] = maybeGroup

         return `groups/${groupId}/${threadId}/${imageName}`
      }

      const maybeDm = await getDmFromMessage(userId, messageId)
      if (maybeDm) {
         const [dmId, imagePath] = maybeDm

         return `dms/${dmId}/${imagePath}`
      }

      throw new StatusError(400, 'user not in source')
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

export const getClient = (): S3Client => {
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