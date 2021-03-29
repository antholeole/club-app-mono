import { Router } from 'itty-router'
import { response } from 'cfw-easy-utils'


export const gatewayRouter = Router({
  base: '/gateway'
})

gatewayRouter.post('/connect', () => {
    console.log('hi')
    return response.json({
        'hi': 'hi'
    })
})