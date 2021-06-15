
import { expect } from 'chai'
import { discriminate, IOptionsForFields } from '../../../src/helpers/discriminators/base_discriminator'
import { EnumFieldOption, FieldOption, MockValues } from '../../../src/helpers/discriminators/field_options'
import { DiscriminatorError } from '../../../src/helpers/discriminator_error'


describe('base descriminator', () => {
    const myEnumValues = <const>[
        'Blah',
        'Second'
    ]

    interface MyObject {
        strField: string
        numField: number
        nullable?: boolean
        enum: typeof myEnumValues[number]
        boolField: boolean
        list: string[]
        emptyList: string[]
        nested: {
            test: boolean
        }
    }

    const myObject: MyObject = {
        strField: 'hi',
        numField: 15,
        nullable: undefined,
        enum: 'Blah',
        boolField: true,
        list: ['hi', 'hi'],
        emptyList: [],
        nested: {
            test: false
        }
    }

    const myObjectWrapped: IOptionsForFields<MyObject> = {
        strField: new FieldOption(MockValues.mockString),
        numField: new FieldOption(MockValues.mockNumber),
        nullable: new FieldOption(MockValues.mockBool, true),
        boolField: new FieldOption(MockValues.mockBool),
        enum: new EnumFieldOption<typeof myEnumValues>(myEnumValues),
        list: new FieldOption([MockValues.mockString]),
        emptyList: new FieldOption([MockValues.mockString]),
        nested: {
            test: new FieldOption(MockValues.mockBool)
        }
    }

    it('should return true if correct', () => {
        const a = discriminate(myObjectWrapped, myObject as unknown as Record<string, unknown>)
        expect(a).be.any
    })

    it('should return false if extra field', () => {
        const myObjectWithExtraField: MyObject & { extra: string } = {
            ...myObject,
            extra: 'I am extra'
        }

        try {
            discriminate(myObjectWrapped, myObjectWithExtraField as unknown as Record<string, unknown>)
        } catch (e) {
            expect(e).to.be.instanceOf(DiscriminatorError)
        }
    })


    it('should return false if missing field', () => {
        const myObjectCopy: MyObject = {
            ...myObject
        }

        delete myObjectCopy.enum

        const myObjectWithoutField: Omit<MyObject, 'enum'> = {
            ...myObject
        }

        try {
            discriminate(myObjectWrapped, myObjectWithoutField as unknown as Record<string, unknown>)
        } catch (e) {
            expect(e).to.be.instanceOf(DiscriminatorError)
        }
    })
})

