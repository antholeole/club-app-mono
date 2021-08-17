import { Record, String, ValidationError } from 'runtypes'
import { simpleRoute } from '../../src/helpers/simple_route'
import { mockRequest } from '../fixtures/mock_request'

describe('simple route', () => {
    const Verifier = Record({
        hi: String
    })

    test('should forward input on verify', async () => {
        const reqBody = 'Im a valid req'

        const req = mockRequest({
            hi: reqBody
        })

        const mockFn = jest.fn().mockImplementation(() => undefined)

        await simpleRoute(req, Verifier, mockFn)

        expect(mockFn.mock.calls.length).toBe(1)
        expect(mockFn.mock.calls[0][0].hi).toEqual(reqBody)
    })

    test('should throw ValidationError on incorrect', async () => {
        const req = mockRequest({
            hi: undefined
        })

        const mockFn = jest.fn().mockImplementation(() => undefined)

        await expect(simpleRoute(req, Verifier, mockFn)).rejects.toThrow(ValidationError)
        expect(mockFn.mock.calls.length).toBe(0)
    })
})