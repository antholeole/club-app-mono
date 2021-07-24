declare namespace jest {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  interface Matchers<R, T> {
    toThrowStatusError: T extends Promise<Response>
    ? (status: number) => Promise<CustomMatcherResult>
    : 'Expected contents of "expect" to be "Promise<Response>"'
  }
}