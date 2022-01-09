export interface IHandleDeviceToken {
    deviceToken: string,
    handleType: 'Add' | 'Remove'
}

export interface IMessage {
    message_type: 'TEXT' | 'IMAGE',
    source_id: string,
    body: string,
}