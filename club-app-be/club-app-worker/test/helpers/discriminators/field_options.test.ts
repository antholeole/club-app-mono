import { expect } from 'chai'
import { ConstantFieldOption, EnumFieldOption, FieldOption, MockValues, UuidFieldOption } from '../../../src/helpers/discriminators/field_options'

describe('field options', () => {
    describe('base options', () => {
        it('should pass any primative', () => {
            for (const val of ['string', true, ['array'], 10]) {
                const fieldOption = new FieldOption(val)
                expect(fieldOption.validate(val)).to.be.true
            }
        })

        it('should pass if recieved null and is nullable', () => {
            const fieldOption = new FieldOption(MockValues.mockString, true)

            expect(fieldOption.validate(null)).to.be.true
        })

        it('should pass if recieved undefined and is nullable', () => {
            const fieldOption = new FieldOption(MockValues.mockString, true)

            expect(fieldOption.validate(undefined)).to.be.true
        })


        it('should pass empty array', () => {
            const fieldOption = new FieldOption([MockValues.mockString], true)

            expect(fieldOption.validate([])).to.be.true
        })

        it('should fail if wrong type', () => {
            const fieldOption = new FieldOption(MockValues.mockString)

            expect(fieldOption.validate(10)).to.be.false
        })

        it('should fail if passed in array', () => {
            const fieldOption = new FieldOption(MockValues.mockString)

            expect(fieldOption.validate(['hi'])).to.be.false
        })
    })

    describe('enum option', () => {
        const myEnumValues = <const>[
            'Blah',
            'Second'
        ]

        const enumValidator = new EnumFieldOption<typeof myEnumValues>(myEnumValues)

        it('should pass if value is in the enum', () => {
            expect(enumValidator.validate(myEnumValues[0])).to.be.true
        })

        it('should fail if value is not the enum', () => {
            expect(enumValidator.validate('not in')).to.be.false
        })

        it('should fail if value is not the enum', () => {
            expect(enumValidator.validate('not in')).to.be.false
        })
    })

    describe('uuid option', () => {
        const validUuid = 'f2de814c-b410-4f14-b871-3d05b3c43a6f'

        const enumValidator = new UuidFieldOption(MockValues.mockString)

        it('should pass if value is uuid', () => {
            expect(enumValidator.validate(validUuid)).to.be.true
        })

        it('should fail if value is not uuid', () => {
            expect(enumValidator.validate('not in')).to.be.false
        })
    })

    describe('constant option', () => {
        it('should pass any primative', () => {
            for (const val of ['string', true, ['array'], 10]) {
                const fieldOption = new ConstantFieldOption(val)
                expect(fieldOption.validate(val)).to.be.true
            }
        })

        it('should fail if wrong value', () => {
            const strFieldOption = new ConstantFieldOption('string!')
            expect(strFieldOption.validate('different string')).to.be.false

            const boolFieldOption = new ConstantFieldOption(false)
            expect(boolFieldOption.validate(true)).to.be.false

            const numFieldOption = new ConstantFieldOption(111)
            expect(numFieldOption.validate(11)).to.be.false
        })
    })
})