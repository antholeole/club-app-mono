
export const messageTypes = <const>[
    'message'
]

export interface IWsMessageShape {
    id: string,
    event: {
        multiValueHeaders: {
            authorization: string[]
        }
    }
}

export interface IWsMessage extends IWsMessageShape {
    message: {
        type: typeof messageTypes[number]
    }
}

export type IWsConnectMessage = IWsMessageShape


export interface IWsMessageMessage extends IWsMessage {
    message: {
        type: typeof messageTypes[number]
        message: string
        toId: string
    }
}
