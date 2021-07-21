import { Literal, Union, Record } from 'runtypes'

const SendableMessages = Union(Literal('Connected'))

export const Sendable = Record({
    type: SendableMessages,
})