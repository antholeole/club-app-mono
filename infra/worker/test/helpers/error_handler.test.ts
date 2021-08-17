import { StatusError } from 'itty-router-extras'
import {  ValidationError, Failcode } from 'runtypes'
import { errorHandler } from '../../src/helpers/error_handler'


describe('test error handler', () => {
    test('should convert validation error to 400', () => {
            expect(errorHandler(new ValidationError({
                message: '',
                code: Failcode.CONSTRAINT_FAILED,
                success: false
            })).status).toEqual(400)
    })


    test('should convert status error error with input status type', () => {
        for (const statusCode of [400, 401, 500, 12930123, 510, 504, 402]) {
            expect(errorHandler(new StatusError(statusCode)).status).toEqual(statusCode)
        }
    })

    test('should rethrow unhandeled error type', () => {
        expect(() => errorHandler(new Error())).toThrow(Error())
    })
})