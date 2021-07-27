import { readJsonBody } from '../../src/helpers/read_json_body'

describe('read json body', () => {
    const json = JSON.stringify({
        hi: 'hi'
    })

    test('should return body as json', async () => {
        const res = await readJsonBody(new Response(json))

        expect(res.hi).toEqual('hi')
    })

    test('should throw error if invalid json', async () => {
        await expect(async () => await readJsonBody(
            new Response('not a json'))
        ).toThrowStatusError(400)
    })
})