export const setGlobalValue = (name: string, value: unknown): void => {
    const globalNameSpace: Record<string, unknown> = {}
    globalNameSpace[name] = value
    Object.assign(global, globalNameSpace)
}