import { gqlReq } from '../../../helpers/gql_connector'


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