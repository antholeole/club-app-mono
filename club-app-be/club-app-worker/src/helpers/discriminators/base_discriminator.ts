import { DiscriminatorError } from '../discriminator_error'
import { FieldOption } from './field_options'

type IJsonArray = Array<string | number | boolean | Date | IValidPostBody | IJsonArray>

export interface IValidPostBody {
    [key: string]: string | number | boolean | Date | IValidPostBody | IJsonArray
}

export type IOptionsForFields<T> = {
    [key in keyof T]-?: T[key] extends IValidPostBody ? IOptionsForFields<T[key]> : FieldOption<T[key]>
}

export const discriminate = <T>(
    options: IOptionsForFields<T>, input: Record<string, unknown>
): T => {
    const validKeys = Object.keys(options)
    const inputKeys = new Set(Object.keys(input))
    for (const validKey of validKeys) {
        const optionsOfKey = options[validKey as keyof typeof options]
        if (!inputKeys.delete(validKey)) {
            throw new DiscriminatorError()
        }
        if (optionsOfKey instanceof FieldOption) {
            if (optionsOfKey.validate(input[validKey])) {
                continue
            } else {
                throw new DiscriminatorError()
            }
        }
        if (!discriminate(
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            (options as any)[validKey],
            input[validKey] as Record<string, unknown>
        )) {
            throw new DiscriminatorError()
        }
    }
    return input as T
}