export const r_default = async ({id, route}: RoutedWsMessage): Promise<any> => {
    console.log('default message', route, id)
    return { statusCode: 200 }
}