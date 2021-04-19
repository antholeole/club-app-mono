import styles from './hover_card.module.scss'

interface IHoverCardProps {
  blah?: string
}

export const HoverCard = (props: IHoverCardProps): JSX.Element => (
  <div className={styles.card}>
    <h4 className={styles.card__header}>Events</h4>
    <div className={styles.card__icon}>
      🗓️
    </div>
    <p>
      easily and quickly schedule events.
      <br />
      ✅ Reoccuring
      <br />
      ✅ At a location
      <br />
      ✅ Automatic Reminders
    </p>
  </div>
)
