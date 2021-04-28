import Image from 'next/image'
import {
  createRef, RefObject, useEffect, useState,
} from 'react'
import { multiclass } from '../../../utils/class'
import { useInterval } from '../../../utils/use_interval'
import SplashStyles from './splash.module.scss'

// eslint-disable-next-line no-shadow
enum LetterState {
  Out = 1,
  In,
  Behind,
  None
}

interface ILetter {
  ref: RefObject<HTMLSpanElement>,
  state: LetterState
}
interface IWord {
  word: string,
  ref: RefObject<HTMLSpanElement>,
  visible: boolean,
  letters: ILetter[]
}

const spacing = 340 // how long to wait before dropping in the new word
const letterTime = 80 // how long each letter waits for the last
const rotationSpeed = 10000 // how long a word is shown before rotating

// the words to put in the rotation
const words = [
  'Work Team.',
  'School Club.',
  'Sports Team.',
  'Extracurricular.',
]

export const Splash = (): JSX.Element => {
  const [currWordIndex, setCurrWordIndex] = useState(0)
  const [wordRefs, setWordRefs] = useState<IWord[]>(
    Array(words.length).fill(undefined).map((_, i) => ({
      word: words[i],
      ref: createRef<HTMLSpanElement>(),
      visible: false,
      letters: Array(words[i].length).fill(undefined).map(() => ({
        state: LetterState.None,
        ref: createRef<HTMLSpanElement>(),
      })),
    })),
  )

  const updateWordRef = (index: number, word: Partial<IWord>) => {
    setWordRefs((oldWordRefs) => [
      ...oldWordRefs.slice(0, index),
      {
        ...oldWordRefs[index],
        ...word,
      },
      ...oldWordRefs.slice(index + 1),
    ])
  }

  const updateLetterRef = (wordIndex: number, letterIndex: number, letter: Partial<ILetter>) => {
    setWordRefs((oldWordRefs) => [
      ...oldWordRefs.slice(0, wordIndex),
      {
        ...oldWordRefs[wordIndex],
        letters: [
          ...oldWordRefs[wordIndex].letters.slice(0, letterIndex),
          {
            ...oldWordRefs[wordIndex].letters[letterIndex],
            ...letter,
          },
          ...oldWordRefs[wordIndex].letters.slice(letterIndex + 1),
        ],
      },
      ...oldWordRefs.slice(wordIndex + 1),
    ])
  }

  const animateLetterOut = (wordIndex: number, letterIndex: number) => {
    setTimeout(() => {
      updateLetterRef(wordIndex, letterIndex, {
        state: LetterState.Out,
      })
    }, letterIndex * letterTime)
  }

  const animateLetterIn = (wordIndex: number, letterIndex: number) => {
    setTimeout(() => {
      updateLetterRef(wordIndex, letterIndex, {
        state: LetterState.In,
      })
    }, spacing + (letterIndex * letterTime))
  }

  const determineLetterClass = (state: LetterState, letter: string): string => {
    const classes = ['letter']

    if (letter === ' ') {
      classes.push('space')
    }

    switch (state) {
      case LetterState.Behind:
        classes.push('behind')
        break
      case LetterState.In:
        classes.push('in')
        break
      case LetterState.Out:
        classes.push('out')
        break
      default:
        break
    }

    return multiclass(SplashStyles, ...classes)
  }

  const changeWord = () => {
    const currWord = wordRefs[currWordIndex]
    const nextWordIndex = currWordIndex === words.length - 1 ? 0 : currWordIndex + 1
    const nextWord = wordRefs[nextWordIndex]

    currWord.letters.forEach((_, letterIndex) => animateLetterOut(currWordIndex, letterIndex))

    updateWordRef(nextWordIndex, { visible: true })
    nextWord.letters.forEach((_, letterIndex) => {
      updateLetterRef(nextWordIndex, letterIndex, {
        state: LetterState.Behind,
      })

      animateLetterIn(nextWordIndex, letterIndex)
    })

    setCurrWordIndex((currWordIndex === words.length - 1) ? 0 : currWordIndex + 1)
  }

  // set the interval too
  useEffect(changeWord, [])
  useInterval(changeWord, rotationSpeed)

  return (
    <section className={SplashStyles.splash}>
      <div className={SplashStyles.copy}>
        <p>
          The Best Way to Manage a
        </p>
        <h1>
          {wordRefs.map((word, wordIndex) => (
            <span
              key={word.word}
              className={SplashStyles.word}
              style={{ opacity: word.visible ? 1 : 0 }}
            >
              {word.letters.map((letter, letterIndex) => (
                <span
                // optimized: letter indicies never changes
                // eslint-disable-next-line react/no-array-index-key
                  key={`${word.word}-${letterIndex}`}
                  className={
                    determineLetterClass(letter.state, wordRefs[wordIndex].word[letterIndex])
                    }
                >
                  {wordRefs[wordIndex].word[letterIndex]}
                </span>
              ))}
            </span>
          ))}
        </h1>
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
