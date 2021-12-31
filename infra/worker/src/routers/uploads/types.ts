export interface IInsertImageRequest {
    sourceId: string,
    uploadType: 'GroupAvatar' | 'UserAvatar' | 'Message',
    fileSize: number,
    contentType: string
}