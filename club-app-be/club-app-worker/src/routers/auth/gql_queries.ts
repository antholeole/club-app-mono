import { refresh_tokens_constraint, refresh_tokens_update_column } from '../../generated/zeus'
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

    return res.insert_users_one
}

export const upsertRefreshToken = async (user_id: string, refresh_token: string): Promise<string> => {
    const res = await thunder.mutation({
        insert_refresh_tokens_one: [{
            object: {
                user_id,
                refresh_token: refresh_token
            },
            on_conflict: {
                constraint: refresh_tokens_constraint.refresh_tokens_user_id_key,
                update_columns: [
                    refresh_tokens_update_column.refresh_token
                ],
            }
        },
        {
            refresh_token: true,
        }],
    })

    return res.insert_refresh_tokens_one.refresh_token
}

export const checkRefreshTokenEquality = async (user_id: string, refresh_token: string): Promise<boolean> => {
    const { refresh_tokens: res } = await thunder.query({
        refresh_tokens: [{
            where: {
                refresh_token: {
                    _eq: refresh_token
                },
                user_id: {
                    _eq: user_id
                }
            } 
        }, {
            user_id: true
        }]
    })

    return (res.length === 1)
} 