/*
import { expect } from 'chai'
import { baseDiscriminator, UndefinedableFieldOption, IOptionsForFields, IValidPostBody, MockValues, FieldOption, EnumFieldOption } from '../../src/helpers/base_discriminator'


describe('base descriminator', () => {
    const myEnumValues = <const>[
        'Blah',
        'Second'
    ]

    interface IObject extends IValidPostBody {
        strField: string
        numField: number
        boolField: boolean
        nullable?: boolean
        enum: typeof myEnumValues[number]
        list: string[]
        nested: {
            test: boolean
        }
    }

    const validObject: IOptionsForFields<IObject> = {
        strField: new FieldOption(MockValues.mockString),
        numField: new FieldOption(MockValues.mockNumber),
        nullable: new UndefinedableFieldOption(MockValues.mockBool),
        boolField: new FieldOption(MockValues.mockBool),
        enum: new EnumFieldOption<typeof myEnumValues>(myEnumValues),
        list: new FieldOption([MockValues.mockString]),
        nested: {
            test: new FieldOption<boolean>(MockValues.mockBool)
        }
    }

    const partial = {}

    it('should return false if incorrect', () => {
        const invalid: Partial<IObject> = {
            strField: 'blah',
            boolField: false,
            //missing num
            nested: {
                test: false
            }
        }

        expect(baseDiscriminator(validObject, partial, invalid)).to.be.false
    })

    it('should return true if correct', () => {
        const valid: IObject = {
            strField: 'blah',
            boolField: false,
            numField: 123,
            nested: {
                test: false
            }
        }

        expect(baseDiscriminator(validObject, partial, valid)).to.be.true
    })

    it('should return false if types different', () => {
        const invalid = {
            strField: false, //not a str
            boolField: false,
            numField: 123,
            nested: {
                test: false
            }
        }

        expect(baseDiscriminator(validObject, partial, invalid)).to.be.false
    })

    it('should return true if field missing but undefineable', () => {
        const valid = {
            strField: 'hi',
            boolField: false,
            numField: undefined,
            nested: {
                test: true
            }
        }

        const partialMatcher = {
            numField: true
        }

        expect(baseDiscriminator(validObject, partialMatcher, valid)).to.be.true
    })

    it('should return false if field missing but not undefineable', () => {
        const valid = {
            strField: 'hi',
            boolField: false,
            numField: undefined,
            nested: {
                test: true
            }
        }

        const partialMatcher = {
            numField: false
        }

        expect(baseDiscriminator(validObject, partialMatcher, valid)).to.be.false
    })
})

*/