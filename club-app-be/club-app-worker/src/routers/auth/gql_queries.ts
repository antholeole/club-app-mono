import { gqlReq } from '../../helpers/gql_connector'

export interface IUser {
    id: string,
    sub: string,
    name: string,
    email?: string
}

export const getUserById = async (id: string): Promise<Partial<IUser> | null> => {
    const { data } = await gqlReq(`
    query {
        users_by_pk(id: "${id}") {
        
      }
    }
    `)

    return (data.users_by_pk ?? null)
}

export const getUserBySub = async (sub: string): Promise<IUser | null> => {
    const { users } = await gqlReq(`query {
      users(where: { sub:{_eq: "${sub}"} }) {
            id,
            sub,
            name
      }
    }
    `)

    return (users[0] ?? null)
}

export const addUser = async (sub: string, name: string, email?: string): Promise<IUser> => {
    const reqObj = email ? `
        {
            sub: "${sub}",
            email: "${email}",
            name: "${name}"
        }
    ` : `
        {
            sub: "${sub}",
            name: "${name}"
        }
    `

    
    const { insert_users_one } = await gqlReq(`
    mutation {
        insert_users_one(object: ${reqObj}) {
          email,
          name,
          id
        }
      }
    `)

    return { ...insert_users_one, email: insert_users_one.email ?? undefined }
}