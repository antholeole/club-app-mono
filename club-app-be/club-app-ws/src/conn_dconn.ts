import axios from "axios"

export const connect = async (msg: WsConnectMessage): Promise<any> => {
    await axios.post("http://localhost:8787/api/gateway/connect/", msg)
    return { statusCode: 200 }
}

export const disconnect = async (msg: WsConnectMessage): Promise<any> => {
    await axios.post("http://localhost:8787/api/gateway/disconnect/", msg)
    return { statusCode: 200 }
}
