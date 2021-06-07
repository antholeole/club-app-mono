export const setGlobalValue = (name: string, value: unknown): void => {
    const globalNameSpace = {}
    globalNameSpace[name] = value
    Object.assign(global, globalNameSpace)
}