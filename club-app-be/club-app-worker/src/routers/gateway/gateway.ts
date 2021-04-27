import { json } from 'itty-router-extras'
import { Router } from 'itty-router'

export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', () => {
    console.log('hi')
    return json({
        'hi': 'hi tehre kiddo'
    })
})