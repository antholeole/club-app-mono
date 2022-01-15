import { addServerRequestEventListener } from '../../../helpers/event_listeners'
import { refreshRoute } from './handler'

addServerRequestEventListener(refreshRoute)