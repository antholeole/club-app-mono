import { StatusError } from 'itty-router-extras'

export class DiscriminatorError extends StatusError {
    constructor() {
        super(400, 'Malformed input')
    }
}