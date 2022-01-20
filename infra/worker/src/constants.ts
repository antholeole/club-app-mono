import { json } from 'itty-router-extras'

export const GOOGLE_PEM_SRC = 'https://www.googleapis.com/oauth2/v2/certs'
export const R_TOKEN_PUBLIC_KEY_KEY = 'refresh_token_kv_key'
export const GOOGLE_VALID_AUDS = ['962929179530-dhdrlhef0davumm1aegfhnjhrkkcdd4s.apps.googleusercontent.com', '962929179530-mgguojv56mn166nae1ds6lffor25ruqu.apps.googleusercontent.com']
export const GOOGLE_CERTS = 'google_auth_pem'
export const GOOGLE_VALID_ISSUER = ['accounts.google.com', 'https://accounts.google.com']
export const DEBUG = ENVIRONMENT === 'dev'
export const DEFAULT_USERNAME = 'Club App User'

export const FIREBASE_FCM_ENDPOINT = 'https://fcm.googleapis.com/fcm/send'

export const VALID_CONTENT_TYPES = [
    'image/gif',
    'image/jpeg',
    'image/png'
]
export const MAX_FILE_SIZE = 5_242_880
export const BUCKET_NAME = ENVIRONMENT === 'dev' ? 'dev-club-app' : 'club-app'
export const B2_ENDPOINT = ENVIRONMENT === 'dev' ?
    'http://s3:9876' : 'https://s3.us-west-000.backblazeb2.com'

//is a fn so that in the miniflare environment, we can reuse responses
export const STANDARD_SUCCESS_JSON = (): Response => json({
    'success': true
})