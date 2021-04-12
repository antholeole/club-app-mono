import { ThrowableRouter, StatusError, json } from 'itty-router-extras'
import { readJsonBody } from '../../helpers/read_json_body'
import { discrimiateAccessToken, discriminateRefresh } from './discriminators'
import { generateAccessToken, verifyIdTokenWithGoogle } from './helpers'
import { addUser, getUserBySub } from './gql_queries'
import { cryptoRandomString } from '../../helpers/crypto'
import { getDecryptedKV, putEncryptedKV } from 'encrypt-workers-kv'
import { R_TOKEN_PUBLIC_KEY_KEY } from '../../constants'

export const authRouter = ThrowableRouter({
  base: '/api/auth'
})

authRouter.post('/refresh', async (req: Request) => {
  const body = discriminateRefresh(await readJsonBody(req))

  const decryptedHash = await getDecryptedKV(PUBLIC_KEYS, R_TOKEN_PUBLIC_KEY_KEY, SECRET)

  if (decryptedHash === null) {
    throw new StatusError(404, `user with id ${body.userId} not found`)
  }

  if (new TextDecoder().decode(decryptedHash) === body.refreshToken) {
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

  const refreshUnhashed = cryptoRandomString(20)

  await putEncryptedKV(PUBLIC_KEYS, R_TOKEN_PUBLIC_KEY_KEY, refreshUnhashed, SECRET)

  const aToken = generateAccessToken(user.id)
  return json({
    accessToken: aToken,
    refreshToken: refreshUnhashed,
    ...user,
  })
})
