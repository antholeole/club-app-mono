import {
  MutableRefObject, useEffect, useRef, useState,
} from 'react'
import { multiclass } from '../../../utils/class'
import NavStyles from './navbar.module.scss'

export const Navbar = (): JSX.Element => {
  const [topSnapped, setTopSnapped] = useState(true)
  const [height, setHeight] = useState<null | number>(null)
  const navbarRef: MutableRefObject<HTMLElement | null> = useRef(null)

  const handleScroll = () => {
    if (window.pageYOffset === 0) {
      setTopSnapped(true)
    } else if (topSnapped) {
      setTopSnapped(false)
    }
  }

  useEffect(() => {
    window.addEventListener('scroll', handleScroll)
    return () => window.removeEventListener('scroll', handleScroll)
  })

  useEffect(() => {
    if (navbarRef.current?.clientHeight) {
      setHeight(navbarRef.current?.clientHeight ?? null)
    }
  }, [navbarRef.current])

  return (
    <>
      <nav className={multiclass(NavStyles, 'navbar', topSnapped ? 'snapped' : 'float')} ref={navbarRef}>
        <h3 className={NavStyles.logo}>
          Club App
        </h3>
      </nav>
      { !topSnapped && <div style={{ height: height ?? 0 }} />}
    </>
  )
}
