import { addAuthRouteEventListener } from '../../../helpers/event_listeners'
import { createOrGetSingletonDm } from './handler'

addAuthRouteEventListener(createOrGetSingletonDm)