import utils from '../../../styles/utils.module.scss'
import { HoverCard } from '../hover_card/hover_card'
import styles from './splash.module.scss'

export const Splash = (): JSX.Element => (
  <>
    <div className={styles.mast} />
    <div className={styles.splash}>
      <div className={styles.splash__copy}>
        <h1>Club App.</h1>
        <p className={styles.lead}>
          The premier way to manage a club, group, or sports team.
        </p>
        <div className={styles.splash__copy__cards}>
          <HoverCard />
          <HoverCard />
          <HoverCard />
        </div>
      </div>
    </div>
  </>
)
