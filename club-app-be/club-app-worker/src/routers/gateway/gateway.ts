import { ThrowableRouter, json } from 'itty-router-extras'

export const gatewayRouter = ThrowableRouter({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', () => {
    console.log('hi')
    return json({
        'hi': 'hi'
    })
})