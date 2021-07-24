declare namespace jest {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  interface Matchers<R> {
    toThrowStatusError(status: number): Promise<CustomMatcherResult>;
  }
}