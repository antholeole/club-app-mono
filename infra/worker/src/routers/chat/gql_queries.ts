import { gqlReq } from '../../helpers/gql_connector'
import { IDmResponse } from './types'

export const getExistingDm = async (userIds: [string, string]): Promise<IDmResponse | void> => {
  const { single_dms } = await gqlReq(`
    query {
        single_dms(where: {
        _and: [
          {
            users: {
              user: {
                    id: {
                      _eq: "${userIds[0]}" 
                    }
              }
            }
          },
          {
            users: {
              user: {
                id: {
                  _eq: "${userIds[1]}"
                }
              }
            }
          }
        ]
      }) {
        id,
        name
      }
    }
      `)

  return (single_dms[0] ?? null)
}

export const createDm = async (userIds: [string, string]): Promise<IDmResponse> => {
  const { insert_threads_one } = await gqlReq(`
  mutation {
    insert_threads_one(object: {
      is_dm: true
    }) {
      id,
      name
    }
  }
  `)

  await gqlReq(`
  mutation {
    insert_user_to_thread(objects: [
      {
        thread_id: "${insert_threads_one.id}",
        user_id: "${userIds[0]}"
      },
      {
        thread_id: "${insert_threads_one.id}",
        user_id: "${userIds[1]}"
      },
    ]) {
      returning {
        thread {
          id,
          name
        }
      }
    }
  }
  `)

  return insert_threads_one
}