import { isUUID } from '../uuid_validator'

export class MockValues {
    static readonly mockString = 'h'
    static readonly mockBool = true
    static readonly mockNumber = 1
}

export class FieldOption<T> {
    protected readonly nullable: boolean
    protected readonly mockVal: T

    constructor(mockVal: T, nullable = false,) {
        this.nullable = nullable
        this.mockVal = mockVal
    }

    validate(input: unknown): boolean {
        if (Array.isArray(this.mockVal) && Array.isArray(input)) {
            if (input.length > 0) {
                return typeof this.mockVal[0] === typeof input[0]
            } else {
                return true
            }
        }

        if (this.nullable && input === undefined || input === null) {
            return true
        }

        if (typeof this.mockVal === typeof input) {
            return true
        }

        return false
    }
}

export class EnumFieldOption<T extends readonly string[]> extends FieldOption<T[number]> {
    readonly validValues: string[]

    constructor(validValues: readonly string[], nullable = false) {
        super(MockValues.mockString, nullable)
        this.validValues = [...validValues]
    }

    validate(input: unknown): boolean {
        if (!super.validate(input)) {
            return false
        }

        return this.validValues.includes(input as string)
    }
}

export class UuidFieldOption extends FieldOption<string> {
    constructor(mockVal: string, nullable = false,) {
        super(mockVal, nullable)
    }

    validate(input: unknown): boolean {
        if (!super.validate(input)) {
            return false
        }

        return isUUID(input as string)
    }
}

export class ConstantFieldOption<T> extends FieldOption<T> {
    constructor(mockVal: T) {
        super(mockVal)
    }

    validate(input: unknown): boolean {
        if (!super.validate(input)) {
            return false
        }

        return this.mockVal === input
    }
}