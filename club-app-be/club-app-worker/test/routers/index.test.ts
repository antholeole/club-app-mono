import { router } from '../../src/routers/index'
import { StatusError } from 'itty-router-extras'
import makeServiceWorkerEnv from 'service-worker-mock'

describe('handler returns response with request method', () => {
  beforeEach(() => {
    Object.assign(global, makeServiceWorkerEnv())
    jest.resetModules()
  })

  test('should respond with CORS headers on OPTIONS request', async () => {
    const resp: Response = await router.handle(new Request('', {
      method: 'OPTIONS',
    }))

    expect(resp.headers.get('access-control-allow-origin')).toEqual('*')
    expect(resp.headers.get('access-control-allow-methods')).toEqual('GET, POST, PUT')
    expect(resp.headers.get('access-control-max-age')).toEqual('1728000')
  })

  test('should respond with 404 on any /api/* request', async () => {
    try {
      await router.handle(new Request('/api/NOT_A_ROUTE', {
        method: 'GET'
      }))
    } catch (e) {
      expect(e).toBeInstanceOf(StatusError)
      expect(e).toHaveProperty('status', 404)
    }
  })

  test('should respond with pong on /ping', async () => {
    const resp: Response = await router.handle(new Request('/api/ping', {
      method: 'GET',
    }))

    expect(await resp.text()).toEqual('pong')
  })
})

