import { ValidationError } from 'runtypes'
import { Uuid } from '../../src/helpers/types'

describe('types', () => {
    describe('uuid', () => {
        test('should not throw on valid', () => {
            expect(() => Uuid.check('not uuid')).toThrow(ValidationError)
        })
        test('should throw on invalid', () => {
            Uuid.check('55e6a082-19dd-4fee-9d6a-cf13f3d55bc5')
        })
    })
})