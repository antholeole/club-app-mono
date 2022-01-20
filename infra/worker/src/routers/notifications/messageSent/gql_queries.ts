import { StatusError } from 'itty-router-extras'
import { gqlReq } from '../../../helpers/gql_connector'




export const determineSourceType = async (sourceId: string): Promise<'thread' | 'dm'> => {
  const { dms_aggregate, threads_aggregate } = await gqlReq(`
  query {
    dms_aggregate(where: {
      id: {
        _eq: "${sourceId}"
      }
    }) {
      aggregate {
        count
      }
    }
    threads_aggregate(where: {
      id: {
        _eq: "${sourceId}"
      }
    }) {
      aggregate {
        count
      }
    }
  }
  `)

  if (dms_aggregate?.aggregate?.count ?? 0 >= 1) {
    return 'dm'
  } else if (threads_aggregate?.aggregate?.count ?? 0 >= 1) {
    return 'thread'
  }

  throw new StatusError(400, 'invalid group id')
}


export const getUsersInDm = async (sourceId: string): Promise<string[]> => {
  const { user_to_dm } = await gqlReq(`
    query {
        user_to_dm(where: {
          dm_id: {
            _eq: "${sourceId}"
          }
        }) {
          user {
            id
          },
          dm {
            name
          }
        }
      }
    `)

  const userIds: Set<string> = new Set()

  user_to_dm.map((userToDm: { user: { id: string } }) => userIds.add(userToDm.user.id))


  return Array.from(userIds)
}

export const getUsersInThread = async (sourceId: string): Promise<string[]> => {
  const { user_to_thread } = await gqlReq(`
  query {
    user_to_thread(where: {
      thread_id: {
        _eq: "${sourceId}"
      }
    }) {
      user {
        id
      },
      thread {
        name,
        group {
          name
        }
      }
    }
  }
    `)

  const userIds: Set<string> = new Set()

  user_to_thread.map((userToThread: { user: { id: string } }) => userIds.add(userToThread.user.id))


  return Array.from(userIds)
}
