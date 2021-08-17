class MockRequest {
    private body: Record<string, unknown>

    async json(): Promise<Record<string, unknown>> {
        return this.body
    }

    constructor(body: Record<string, unknown>) {
        this.body = body
    }
}

export const mockRequest = (body: Record<string, unknown>): Request => {
    return new MockRequest(body) as unknown as Request
}
