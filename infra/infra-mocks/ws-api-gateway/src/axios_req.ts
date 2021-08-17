import axios, { AxiosError } from "axios"

export const axiosReq = async (to: string, msg: any): Promise<{ statusCode: number, body?: string }> => {
    let data: string
    let statusCode: number


    console.log(to)
    try {
        const resp = await axios.post(`http://localhost:8787/api/gateway/${to}/`, msg)

        data = resp.data
        statusCode = resp.status

    } catch (err) {
        const e = err as AxiosError

        data = e.response?.data
        statusCode = e.response?.status ?? 999
    }

    return { statusCode, body: data }
}