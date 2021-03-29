import axios from "axios"

export const connect = async ({ id }: WsMessage): Promise<any> => {
    await axios.post("http://localhost:8787/gateway/connect/", {
        id: id
    })
    return { statusCode: 200 }
}

export const disconnect = async ({ id }: WsMessage): Promise<any> => {
    console.log('disconnect %s', id)
    return { statusCode: 200 }
}