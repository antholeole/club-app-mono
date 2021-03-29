import { Router } from 'itty-router'
import { Gql } from '../../generated/zeus'
import { readJsonBody } from '../../helpers/read_json_body'
import { response } from 'cfw-easy-utils'
import { discrimiateAccessToken, discriminateRefresh } from './discriminators'
import { generateAccessToken, verifyIdTokenWithGoogle } from './helpers'
import { addUser, checkRefreshTokenEquality, getUserById, getUserBySub, upsertRefreshToken } from './gql_queries'
import cryptoRandomString from 'crypto-random-string'
import { GlobalError } from '../../helpers/global_error'


export const authRouter = Router({
  base: '/auth'
})

authRouter.post('/refresh', async (req: Request) => {
  const body = discriminateRefresh(await readJsonBody(req))

  if (await checkRefreshTokenEquality(body.userId, body.refreshToken)) {
    return new Response(generateAccessToken(body.userId))
  } else {
    throw new GlobalError(`invalid refresh token ${body.refreshToken}`, 402) //returns 402 to avoid loop
  }
})

authRouter.post('/', async (req: Request) => {
  const body = discrimiateAccessToken(await readJsonBody(req))

  let sub
  switch (body.from) {
    case 'Google':
      sub = await verifyIdTokenWithGoogle(body.idToken)
  }

  let user = await getUserBySub('google:' + sub)

  if (user == null) {
    user = await addUser('google:' + sub, body.name, body.email)
  }

  const refreshToken = await upsertRefreshToken(user.id, cryptoRandomString({ length: 20 }))

  const aToken = generateAccessToken(user.id)
  return response.json({
    accessToken: aToken,
    refreshToken: refreshToken,
    ...user,
  })
})
