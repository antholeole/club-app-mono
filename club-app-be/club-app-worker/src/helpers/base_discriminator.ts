/*
export class MockValues {
    static readonly mockString = 'h'
    static readonly mockBool = true
    static readonly mockNumber = 1
}

export class FieldOption<T> {
    mockVal: T

    constructor(mockVal: T) {
        this.mockVal = mockVal
    }


    validate(input: unknown): boolean {
        if (Array.isArray(input)) {
            if (input.length === 0) {
                return true
            } else if (typeof input[0] === typeof this.mockVal) {
                return true
            }
            return false
        }
        return typeof this.mockVal === typeof input
    }
}

export class UndefinedableFieldOption<T> extends FieldOption<T> {
    validate(input: T): boolean {
        return typeof this.mockVal === typeof input || typeof input === 'undefined' || input === null
    }

}

export class EnumFieldOption<T extends readonly string[]> extends FieldOption<T[number]> {
    validate(input: string): boolean {
        return this.validValues.includes(input)
    }
    readonly validValues: string[]

    constructor(validValues: readonly string[]) {
        super(MockValues.mockString)

        this.validValues = [...validValues]
    }
}


type IJsonArray = Array<string | number | boolean | Date | IValidPostBody | IJsonArray>



export interface IValidPostBody {
    [x: string]: string | number | boolean | Date | IValidPostBody | IJsonArray
}

export type IOptionsForFields<T extends IValidPostBody> = {
    [key in keyof T]-?: T[key] extends IValidPostBody ? IOptionsForFields<T[key]> : FieldOption<T[key]>
}




export const baseDiscriminator = <T extends IValidPostBody>(
    options: IOptionsForFields<T>, input: Record<string, unknown>
): boolean => {
    const validKeys = Object.keys(options)
    const inputKeys = new Set(Object.keys(input))

    for (const validKey of validKeys) {
        const optionsOfKey = options[validKey]

        if (!inputKeys.delete(validKey)) {
            return false
        }

        if (optionsOfKey instanceof FieldOption) {
            if (optionsOfKey.validate(input[validKey])) {
                continue
            } else {
                return false
            }
        }


        if (!baseDiscriminator(
            // whatever typescript magic is required here, I am not smart enough to figure it out.
            // I know that this type is a IOptionsForFields, because it can either be that or a 
            // fieldOption. This means that this is correct correct. I can't seem to tell the 
            // typechecker that though.
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            options[validKey] as any,
            input[validKey] as Record<string, unknown>
        )) {
            return false
        }
    }

    return true
}*/