declare module 'aws-lambda-ws-server'

declare interface WsMessage {
    id: string
}

declare interface RoutedWsMessage extends WsMessage {
    route: string
}