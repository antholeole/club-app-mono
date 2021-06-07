import { expect } from 'chai'
import { router } from '../../src/routers/index'
import { StatusError } from 'itty-router-extras'


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
    try {
      await router.handle(new Request('/api/NOT_A_ROUTE', {
        method: 'GET'
      }))
    } catch (e) {
      expect(e).to.be.instanceOf(StatusError)
      expect(e).to.have.property('status', 404)
    }
  })

  it('should respond with pong on /ping', async () => {
    const resp: Response = await router.handle(new Request('/api/ping', {
      method: 'GET',
    }))

    expect(await resp.text()).to.equal('pong')
  })
})

