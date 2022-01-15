import { addServerRequestEventListener } from '../../../helpers/event_listeners'
import { registerRoute } from './handler'

addServerRequestEventListener(registerRoute)