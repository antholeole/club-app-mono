import { addAuthRouteEventListener } from '../../../helpers/event_listeners'
import { getSignedDownloadUrl } from './handler'

addAuthRouteEventListener(getSignedDownloadUrl)