import { gqlReq } from '../../helpers/gql_connector'

export const getRoleIdsByJoinCodes = async (joinCodes: string[]): Promise<string[]> => {
  const { roles } = await gqlReq(`
    query {
        roles(where: {
        join_token: {
          token: {
            _in: [${joinCodes.map((joinCode) => '"' + joinCode + '"').join(',')}]
          }
        }
      }) {
        id
      }
    }
    `)

  return roles.map((role: { id: string }) => role.id)
}

export const joinRoles = async (roleIds: string[], userId: string): Promise<string[]> => {
  const res = await gqlReq<{
    insert_user_to_role: {
      returning: {
        role: {
          name: string
        }
      }[]
    }
  }>(`
  mutation {
    insert_user_to_role(objects: [
      ${roleIds.map((v) => '{ user_id: "' + userId + '", role_id: "' + v + '" }').join(',')}
    ]) {
        returning {
          role {
            name
          }
        }
      }
    }
  `)

  return res.insert_user_to_role.returning.map((ret) => ret.role.name)
}