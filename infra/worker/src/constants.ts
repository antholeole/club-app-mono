export const GOOGLE_PEM_SRC = 'https://www.googleapis.com/oauth2/v1/certs'
export const R_TOKEN_PUBLIC_KEY_KEY = 'refresh_token_kv_key'
export const GOOGLE_VALID_AUDS = ['962929179530-dhdrlhef0davumm1aegfhnjhrkkcdd4s.apps.googleusercontent.com']
export const GOOGLE_CERTS = 'google_auth_pem'
export const GOOGLE_VALID_ISSUER = ['accounts.google.com', 'https://accounts.google.com']
export const DEBUG = ENVIRONMENT === 'dev'
export const DEFAULT_USERNAME = 'Club App User'


export const VALID_CONTENT_TYPES = [
    'image/gif',
    'image/jpeg',
    'image/png'
]
export const MAX_FILE_SIZE = 5_242_880
export const B2_ENDPOINT = ENVIRONMENT !== 'dev' ?
    'http://localhost:9876' : 'https://s3.us-west-000.backblazeb2.com'
