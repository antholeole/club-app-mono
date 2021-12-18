import * as groupsGqlQueries from '../../../src/routers/groups/gql_queries'
import { joinRoleWithJoinCodes } from '../../../src/routers/groups/handlers'

describe('chat routes', () => {
    const userId = 'asdasd'
    const joinCode = 'asdasdasadasdasd'

    test('should throw status error on no join codes', async () => {
        await expect(
            async () => await joinRoleWithJoinCodes({
                session_variables: {
                    'x-hasura-user-id': userId
                },
                action: 'asdas',
                input: {
                    join_codes: []
                }
            })
        ).toThrowStatusError(400, 'Please enter join codes.')
    })
    test('should throw status error on not found join codes', async () => {
        jest.spyOn(groupsGqlQueries, 'getRoleIdsByJoinCodes')
            .mockReturnValue(Promise.resolve([]))


        await expect(
            async () => await joinRoleWithJoinCodes({
                session_variables: {
                    'x-hasura-user-id': userId
                },
                action: 'asdas',
                input: {
                    join_codes: [joinCode]
                }
            })
        ).toThrowStatusError(404, 'not all join codes were valid; please try again.')
    })

    test('should return role names on joined', async () => {
        const groupName = 'Sports'
        const groupId = 'k;jkljkljkljlkj'

        const getRoleIdByJoinCodeSpy = jest.spyOn(groupsGqlQueries, 'getRoleIdsByJoinCodes')
            .mockReturnValue(Promise.resolve([groupId]))

        const joinRolesSpy = jest.spyOn(groupsGqlQueries, 'joinRoles')
            .mockReturnValue(Promise.resolve([groupName]))

        const resp = await joinRoleWithJoinCodes({
            session_variables: {
                'x-hasura-user-id': userId
            },
            action: 'asdas',
            input: {
                join_codes: [joinCode]
            }
        })

        expect(getRoleIdByJoinCodeSpy.mock.calls[0][0]).toEqual([joinCode])
        expect(joinRolesSpy.mock.calls[0][0]).toEqual([groupId])
        expect(await resp.json()).toMatchObject({
            joined: [groupName]
        })

    })

})