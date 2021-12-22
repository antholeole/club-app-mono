export interface IInsertImageRequest {
    imageData: {
        sourceId: string,
        uploadType: 'GroupAvatar' | 'UserAvatar' | 'Message'
    }

}