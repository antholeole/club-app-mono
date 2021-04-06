import { expect } from 'chai'
import { router } from '../../src/routers/index'

describe('handler returns response with request method', () => {

  it('should respond with CORS headers on OPTIONS request', async () => {
    const resp: Response = await router.handle(new Request('', {
      method: 'OPTIONS',
    }))

    expect(resp.headers).to.include(new Map([
      ['access-control-allow-origin', '*'],
      ['access-control-allow-methods', 'GET, POST, PUT'],
      ['access-control-max-age', '1728000'],
    ]
    ))
  })

  it('should respond with 404 on any /api/* request', async () => {
    const resp: Response = await router.handle(new Request('/api/NOT_A_ROUTE', {
      method: 'GET'
    }))

    expect(resp.status).to.equal(404)
  })

  it('should respond with pong on /ping', async () => {
    const resp: Response = await router.handle(new Request('/ping', {
      method: 'GET',
    }))

    expect(await resp.text()).to.equal('pong')
  })
})

