import ws from 'aws-lambda-ws-server'
import { axiosReq } from './axios_req'

//NOTE: RUNS ON PORT 5000
//to debug use postman
// these are simply MOCKS and whenever adding a route you MUST add it into terraform.
// NO logic should be handled in these bodies, simply use them as a dev server to pipe through to the cfw functions.

export const handler = ws(
  ws.handler({
    connect: (m: WsConnectMessage) => axiosReq('connect', m),
    disconnect: (m: WsConnectMessage) => axiosReq('disconnect', m),
    default: (m: WsConnectMessage) => axiosReq('message', m),
  })
)