export const GOOGLE_PEM_SRC = 'https://www.googleapis.com/oauth2/v1/certs'
export const R_TOKEN_PUBLIC_KEY_KEY = 'refresh_token_kv_key'
export const GOOGLE_VALID_AUDS = ['962929179530-dhdrlhef0davumm1aegfhnjhrkkcdd4s.apps.googleusercontent.com']
export const GOOGLE_CERTS = 'google_auth_pem'
export const GOOGLE_VALID_ISSUER = ['accounts.google.com', 'https://accounts.google.com']
export const WS_API_GATEWAY = ENVIRONMENT === 'dev' ? 'localhost:5000' : 'NOT YET IMPLIMENTED'
export const HASURA_ENDPOINT = ENVIRONMENT === 'dev' ? 'http://localhost:8080/v1/graphql' : 'http://localhost:8080/v1/graphql'
export const DEBUG = ENVIRONMENT === 'dev'
export const DOMAIN = 'getclub.app'


export const NO_V_GET_DECRYPTED_KV = 'Is less than 1'

export const KV_CONCAT_STRING = ':!#$)@$:'