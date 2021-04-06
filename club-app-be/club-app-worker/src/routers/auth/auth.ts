import { ThrowableRouter, StatusError, json } from 'itty-router-extras'
import { readJsonBody } from '../../helpers/read_json_body'
import { discrimiateAccessToken, discriminateRefresh } from './discriminators'
import { generateAccessToken, hash, verifyHash, verifyIdTokenWithGoogle } from './helpers'
import { addUser, getUserBySub } from './gql_queries'
import cryptoRandomString from 'crypto-random-string'
import { scryptSync } from 'crypto'


export const authRouter = ThrowableRouter({
  base: '/api/auth'
})

authRouter.post('/refresh', async (req: Request) => {
  const body = discriminateRefresh(await readJsonBody(req))

  const hash = await PUBLIC_KEYS.get(body.userId)

  if (hash === null) {
    throw new StatusError(404, `user with id ${body.userId} not found`)
  }

  if (await verifyHash(body.refreshToken, hash)) {
    return new Response(generateAccessToken(body.userId))
  } else {
    throw new StatusError(402, `invalid refresh token ${body.refreshToken}`) //returns 402 to avoid loop
  }
})

authRouter.post('/', async (req: Request) => {
  const body = discrimiateAccessToken(await readJsonBody(req))

  let sub
  switch (body.from) {
    case 'Google':
      sub = 'google:' + (await verifyIdTokenWithGoogle(body.idToken))
  }

  let user = await getUserBySub(sub)

  if (user == null) {
    user = await addUser(sub, body.name, body.email)
  }


  const refreshUnhashed = cryptoRandomString({ length: 20 })
  REFRESH_TOKENS.put(user.id, await hash(refreshUnhashed))

  const aToken = generateAccessToken(user.id)
  return json({
    accessToken: aToken,
    refreshToken: refreshUnhashed,
    ...user,
  })
})
