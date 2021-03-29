import ws from 'aws-lambda-ws-server'
import { connect, disconnect } from './conn_dconn'
import { r_default } from './default'

//NOTE: RUNS ON PORT 5000
//to debug install wscat :)
// these are simply MOCKS and whenever adding a route you MUST add it into terraform.
// NO logic should be handled in these bodies, simply use them as a dev server to pipe through to the cfw functions.

export const handler = ws(
  ws.handler({
    connect,
    disconnect,
    default: r_default
    /*
    async message ({ message, id, context }: WsMessageBearer) {
      const { postToConnection } = context
      console.log('message', message, id)
      await postToConnection({ message: 'echo' }, id)
      return { statusCode: 200 }
    }
    */
  })
)