import { addAuthRouteEventListener } from '../../../helpers/event_listeners'
import { handleDeviceTokens } from './handler'

addAuthRouteEventListener(handleDeviceTokens)