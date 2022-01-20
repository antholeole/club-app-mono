import { addServerRequestEventListener } from '../../../helpers/event_listeners'
import { handleNewMessageSent } from './handler'

addServerRequestEventListener(handleNewMessageSent)