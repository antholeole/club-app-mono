export class MockKvs {
    values: Map<string, string> = new Map()

    async get(key: string): Promise<string> {
        return this.values.get(key) as string
    }

    async put(key: string, value: string): Promise<void> {
        this.values.set(key, value)
    }

    async delete(key: string): Promise<void> {
        this.values.delete(key)
    }

    clear(): void {
        this.values.clear()
    }
}


