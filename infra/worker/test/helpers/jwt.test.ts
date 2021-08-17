import { decodeJwt, encodeJwt } from '../../src/helpers/jwt'
import jwt from 'jsonwebtoken'

jest.mock('jsonwebtoken')
jwt


const verify = jwt.verify as jest.MockedFunction<(token: string, secretOrPublicKey: jwt.Secret,  options?: jwt.VerifyOptions, ) => Record<string, unknown> | string>
const sign = jwt.sign as jest.MockedFunction<(token: string, secretOrPublicKey: jwt.Secret, options?: jwt.VerifyOptions | undefined) => string | Record<string, unknown> >

describe('jwt', () => {
    afterEach(() => {
        verify.mockReset() 
    })    

    describe('decode', () => {
        test('should throw 401 if not in Bearer format', () => {
            expect(() => decodeJwt('Not Bearer TOKEN')).toThrowStatusError(401)
        })

        test('should throw 401 if jwt unauthorized', () => {
            verify.mockImplementationOnce(() => {
                throw Error('error')
        })

            expect(() => decodeJwt('Bearer TOKEN')).toThrowStatusError(401)
        })

        test('should NOT ignoreExpired by default', () => {
            verify.mockReturnValueOnce('valid')

            decodeJwt('Bearer bear')

            expect(verify.mock.calls[0][2]?.ignoreExpiration).toBe(false)
        })
        
        test('should NOT throw if ignoreExpired is true and expired', () => {
            verify.mockReturnValueOnce('valid')

            decodeJwt('Bearer bear', true)

            expect(verify.mock.calls[0][2]?.ignoreExpiration).toBe(true)
        })
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