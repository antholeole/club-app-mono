import { Router } from 'itty-router'
import { discriminate } from '../../helpers/discriminators/base_discriminator'
import { EnumFieldOption, FieldOption, MockValues } from '../../helpers/discriminators/field_options'
import { readJsonBody } from '../../helpers/read_json_body'
import { IWsMessage, IWsMessageShape, messageTypes, toMessageTypes } from './discriminators'
import { connectRoute, disconnectRoute, messageRoute } from './handlers'

export const gatewayRouter = Router({
  base: '/api/gateway'
})

gatewayRouter.post('/connect', async (req: Request) => {
  const message = discriminate<IWsMessageShape>({
    event: {
      multiValueHeaders: {
        authorization: new FieldOption([MockValues.mockString])
      }
    },
    id: new FieldOption(MockValues.mockString)
  }, await readJsonBody(req))

  return connectRoute(message)
})

gatewayRouter.post('/disconnect', async (req: Request) => {
  const message = discriminate<IWsMessageShape>({
    event: {
      multiValueHeaders: {
        authorization: new FieldOption([MockValues.mockString])
      }
    },
    id: new FieldOption(MockValues.mockString)
  }, await readJsonBody(req))

  return disconnectRoute(message)
})

gatewayRouter.post('/message', async (req: Request) => {
  const message = discriminate<IWsMessage>({
    event: {
      multiValueHeaders: {
        authorization: new FieldOption([MockValues.mockString])
      }
    },
    id: new FieldOption(MockValues.mockString),
    message: {
      type: new EnumFieldOption<typeof messageTypes>(messageTypes)
    }
  }, await readJsonBody(req))

  return messageRoute(message)
})
