export const generateMessageUrl = (threadId: string, userId: string): string => {
    //validate the user is in the thread
    return 'hi'
}

export const generateGroupAvatarUrl = (groupId: string, userId: string): string => {
    //validate that the user owns the group
    return 'hi'
}

export const generateUserAvatarUrl = (userId: string): string => {

}

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