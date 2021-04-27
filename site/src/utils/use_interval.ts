import { useRef, useEffect, MutableRefObject } from 'react'

export const useInterval = (callback: () => void, delay: number) => {
  const savedCallback: MutableRefObject<(() => void) | undefined> = useRef()

  useEffect(() => {
    savedCallback.current = callback
  }, [callback])

  useEffect(() => {
    const id = setInterval(() => {
      if (savedCallback.current) savedCallback.current()
    }, delay)
    return () => clearInterval(id)
  }, [delay])
}
