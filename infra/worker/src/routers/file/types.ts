export interface IInsertImageRequest {
    sourceId: string,
    uploadType: 'GroupAvatar' | 'UserAvatar' | 'Message',
    fileSize: number,
    contentType: string
}

export interface IGetSignedDownloadRequest {
    sourceId: string,
    uploadType: 'GroupAvatar' | 'UserAvatar' | 'Message'
}