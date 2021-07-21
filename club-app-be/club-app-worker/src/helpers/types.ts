import { String } from 'runtypes'

const uuidRegex = new RegExp(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)

export const Uuid = String.withBrand('Uuid').withConstraint(uuidRegex.test)