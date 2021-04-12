import { thunder } from '../../helpers/gql_connector'

export interface IUser {
    id: string,
    sub: string,
    name: string,
    email?: string
}

export const getUserById = async (id: string): Promise<Partial<IUser> | null> => {
    const { users_by_pk } = await thunder.query({
        users_by_pk: [{
            id
        }, {
            id: true,
        }]
    })

    return (users_by_pk ?? null)
}

export const getUserBySub = async (sub: string): Promise<IUser | null> => {
    const { users } = await thunder.query({
        users: [{
            where: {
                sub: {
                    _eq: sub,
                }
            }
        },
        {
            id: true,
            sub: true,
            name: true
        }
        ]
    })

    return (users[0] ?? null)
}

export const addUser = async (sub: string, name?: string, email?: string): Promise<IUser> => {
    const res = await thunder.mutation({
        insert_users_one: [{
            object: {
                sub,
                name,
                email
            }
        }, {
            id: true,
            sub: true,
            name: true,
            email: true
        }]
    })

    return { ...res.insert_users_one, email: res.insert_users_one.email ?? undefined }
}