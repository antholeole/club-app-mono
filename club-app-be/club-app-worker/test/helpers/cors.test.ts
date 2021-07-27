import { cors } from '../../src/helpers/cors'

describe('cors util', () => {
    test('should return required cors headers', () => {
        const headers = cors().headers

        expect(headers.get('Access-Control-Allow-Origin')).toEqual('*')
        expect(headers.get('Access-Control-Allow-Methods')).toEqual('GET, POST, PUT')
        expect(headers.get('Access-Control-Max-Age')).toEqual('1728000')
    })
})