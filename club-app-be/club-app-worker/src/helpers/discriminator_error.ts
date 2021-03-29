import { GlobalError } from './global_error'

export class DiscriminatorError extends GlobalError {
    constructor() {
        super('Malformed input', 400)
    }
}