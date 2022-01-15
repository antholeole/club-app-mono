import { addAuthRouteEventListener } from '../../../helpers/event_listeners'
import { getSignedUploadUrl } from './handler'


addAuthRouteEventListener(getSignedUploadUrl)