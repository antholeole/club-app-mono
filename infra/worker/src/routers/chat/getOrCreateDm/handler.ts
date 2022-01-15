import { json } from 'itty-router-extras'
import { IAuthActionInput } from '../../../helpers/event_listeners'
import { createDm, getExistingDm } from './gql_queries'

export interface ICreateOrGetSingletonDmRequest {
    with_user_id: string
}

export interface IDmResponse {
    id: string
    name: string
}

export const createOrGetSingletonDm = async (req: IAuthActionInput<ICreateOrGetSingletonDmRequest>): Promise<Response> => {
    let respJson: IDmResponse

    const userIds: [string, string] = [req.input.with_user_id, req.session_variables['x-hasura-user-id']]

    const existing = await getExistingDm(userIds)

    if (existing) {
        respJson = existing
    } else {
        respJson = await createDm(userIds)
    }

    return json(respJson as unknown as Record<string, unknown>)
}