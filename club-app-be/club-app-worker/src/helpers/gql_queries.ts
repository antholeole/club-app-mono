import { thunder } from './gql_connector'

export const setUserOnline = async (userId: string, wsId: string): Promise<void> => {
    await thunder.mutation({
        update_users: [
            {
                where: {
                    id: {
                        _eq: userId
                    }
                },
                _set: {
                    socket_id: wsId
                }
            },
            {

            }
        ]
    })
}

export const setUserOffline = async (userId: string): Promise<void> => {
    await thunder.mutation({
        update_users: [
            {
                where: {
                    id: {
                        _eq: userId
                    }
                },
                _set: {
                    socket_id: undefined
                }
            },
            {

            }
        ]
    })
}