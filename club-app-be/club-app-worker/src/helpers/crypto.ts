const charset = 
    '123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()?'


export const cryptoRandomString = (len: number): string => {
    const length = len ?? 20
    const values = new Uint32Array(length)
    crypto.getRandomValues(values)
    let result = ''

    for (let i = 0; i < length; i++) {
        result += charset[values[i] % charset.length]
    }

    return result
}
