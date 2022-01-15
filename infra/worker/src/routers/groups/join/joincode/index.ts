import { addAuthRouteEventListener } from '../../../../helpers/event_listeners'
import { joinRoleWithJoinCodes } from './handler'

addAuthRouteEventListener(joinRoleWithJoinCodes)