import { DEBUG } from '../constants'

export const debugPrint = (toPrint: string): void => {
    if (DEBUG) {
        console.log(toPrint)
    }
}