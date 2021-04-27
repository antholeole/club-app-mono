import Image from 'next/image'
import { group } from 'node:console'
import { useEffect, useState } from 'react'
import { useInterval } from '../../../utils/use_interval'
import SplashStyles from './splash.module.scss'


enum TextState {
  Deleting,
  Typing,
  Showing
}

export const Splash = (): JSX.Element => {
  const [currText, setCurrText] = useState(0)
  const [currLetter, setCurrLetter] = useState(0)
  const [textState, setTextState] = useState(TextState.Typing)
  const [currShowTick, setCurrShowTick] = useState(0)

  const groups = ['Work Team.', 'School Club.', 'Sports Team.', 'Extracurricular.']

  const showTicks = 70

  const progressType = () => {
    if (textState === TextState.Showing) {
      if (currShowTick > showTicks) {
        setCurrShowTick(0)
        setTextState(TextState.Deleting)
      } else {
        setCurrShowTick(currShowTick + 1)
      }
    } else if (textState === TextState.Typing) {
      if (currLetter > groups[currText].length) {
        setTextState(TextState.Showing)
      } else {
        setCurrLetter(currLetter + 1)
      }
    } else if (textState === TextState.Deleting) {
      if (currLetter <= 0) {
        if (currText + 1 >= groups.length) {
          setCurrText(0)
        } else {
          setCurrText(currText + 1)
        }
        setTextState(TextState.Typing)
      } else {
        setCurrLetter(currLetter - 1)
      }
    }
  }

  useInterval(progressType, 40)

  return (
    <section className={SplashStyles.splash}>
      <div className={SplashStyles.copy}>
        <p>
          The Best Way to Manage a
        </p>
        <h1>{groups[currText].substr(0, currLetter)}</h1>
      </div>
      <div className={SplashStyles.image}>
        <Image
          className={SplashStyles.phone}
          alt="Phone with Club App load screen"
          src="/phone.png"
          width={500}
          height={500}
        />
      </div>
    </section>
  )
}
