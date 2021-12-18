import { json, StatusError } from 'itty-router-extras'
import { IAuthActionInput } from '../../helpers/action_input'
import { getRoleIdsByJoinCodes, joinRoles } from './gql_queries'
import { IJoinCodeRequest } from './types'

export const joinRoleWithJoinCodes = async (req: IAuthActionInput<IJoinCodeRequest>): Promise<Response> => {
    if (!req.input.join_codes.length) {
        throw new StatusError(400, 'Please enter join codes.')
    }

    const roleIds = await getRoleIdsByJoinCodes(req.input.join_codes)

    if (roleIds.length !== req.input.join_codes.length) {
        throw new StatusError(404, 'not all join codes were valid; please try again.')
    }

    const rolesJoined = await joinRoles(roleIds, req.session_variables['x-hasura-user-id'])

    return json({
        'joined': rolesJoined

    })
}