import { router } from '../../src/routers/index'

describe('handler returns response with request method', () => {
  test('should respond with CORS headers on OPTIONS request', async () => {
    const resp: Response = await router.handle(new Request('', {
      method: 'OPTIONS',
    }))

    expect(resp.headers.get('access-control-allow-origin')).toEqual('*')
    expect(resp.headers.get('access-control-allow-methods')).toEqual('GET, POST, PUT')
    expect(resp.headers.get('access-control-max-age')).toEqual('1728000')
  })

  test('should respond with 404 on any /api/* request', async () => {
    await expect(router.handle(new Request('/api/NOT_A_ROUTE', {
      method: 'GET'
    })) as Promise<Response>).toThrowStatusError(404)
  })

  test('should respond with pong on /ping', async () => {
    const resp: Response = await router.handle(new Request('/api/ping', {
      method: 'GET',
    }))

    expect(await resp.text()).toEqual('pong')
  })
})

