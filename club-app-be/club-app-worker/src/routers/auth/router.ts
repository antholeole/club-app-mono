import { readJsonBody } from '../../helpers/read_json_body'
import { Router } from 'itty-router'
import { IAccessTokenRequest, validProviders, IRefresh } from './types'
import { refreshRoute, registerRoute } from './handlers'
import { discriminate } from '../../helpers/discriminators/base_discriminator'
import { EnumFieldOption, FieldOption, MockValues } from '../../helpers/discriminators/field_options'


export const authRouter = Router({
  base: '/api/auth'
})

authRouter.post('/', async (req: Request) => {
  const body = discriminate<IAccessTokenRequest>({
    from: new EnumFieldOption<typeof validProviders>(validProviders),
    idToken: new FieldOption(MockValues.mockString)
  }, await readJsonBody(req))

  return await registerRoute(body)
})

authRouter.post('/refresh', async (req: Request) => {
  const body = discriminate<IRefresh>({
    refreshToken: new FieldOption(MockValues.mockString),
    userId: new FieldOption(MockValues.mockString)
  }, await readJsonBody(req))

  return await refreshRoute(body)
})
