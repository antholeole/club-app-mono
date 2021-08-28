import { encodeJwt } from '../../src/helpers/create_jwt'
import jwt from 'jsonwebtoken'

jest.mock('jsonwebtoken')
jwt


const verify = jwt.verify as jest.MockedFunction<(token: string, secretOrPublicKey: jwt.Secret,  options?: jwt.VerifyOptions, ) => Record<string, unknown> | string>
const sign = jwt.sign as jest.MockedFunction<(token: string, secretOrPublicKey: jwt.Secret, options?: jwt.VerifyOptions | undefined) => string | Record<string, unknown> >

describe('jwt', () => {
    afterEach(() => {
        verify.mockReset() 
    })    

    describe('enconde', () => {
        test('should allow other options', () => {
            sign.mockReturnValueOnce('valid')

            const fakeAud = 'Fake aud'

            encodeJwt({'encode': 'me'}, {
                audience: fakeAud
            })

            expect(sign.mock.calls[0][2]?.audience).toEqual(fakeAud)
        })
    })
})