import axios from "axios"

export const r_default = async (msg: RoutedWsMessage): Promise<any> => {
    await axios.post("http://localhost:8787/api/gateway/message/", msg)
    return { statusCode: 200 }
}