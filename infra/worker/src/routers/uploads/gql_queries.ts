import { gqlReq } from '../../helpers/gql_connector'


export const getGroupFromThread = async (userId: string, threadId: string): Promise<string | null> => {
    const { user_to_thread } = await gqlReq(`
    query {
        user_to_thread(where: {
          user_id: {
            _eq: "${userId}"
          }, 
          thread_id: {
            _eq: "${threadId}"
          }
        }) {
          user_id
        }
      }
      `)

    if (!user_to_thread[0]) {
        return null
    }

    return user_to_thread[0].thread.group_id
}

export const validateUserIsOwner = async (userId: string, groupId: string): Promise<boolean> => {
    const { user_to_group } = await gqlReq(`
    query {
        user_to_group(where: {
          user_id: {
            _eq: "${userId}"
          }, 
          group_id: {
            _eq: "${groupId}"
          }
        }) {
          owner
        }
      }
    `)

    return user_to_group?.[0]?.owner ?? false
}