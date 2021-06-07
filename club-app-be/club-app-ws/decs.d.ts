declare module 'aws-lambda-ws-server'

declare interface WsMessage {
    id: string
}

declare interface WsConnectMessage extends WsMessage {
    event: {
        multiValueHeaders: {
            authorization: any[]
        }
    }
}

declare interface RoutedWsMessage extends WsMessage {
    route: string
}