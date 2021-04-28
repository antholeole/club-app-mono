import { Calendar } from '@styled-icons/ionicons-outline/Calendar'
import { ChatbubbleEllipses } from '@styled-icons/ionicons-outline/ChatbubbleEllipses'
import CardStyles from './cards.module.scss'

interface CardProps {
  header: string,
  body: string,
  icon: JSX.Element
}

export const Cards = () => {
  const Card = ({ header, body, icon }: CardProps): JSX.Element => (
    <div className={CardStyles.card}>
      <div className={CardStyles.icon}>
        {icon}
      </div>
      <div className={CardStyles.copy}>
        <h3>{header}</h3>
        <p>
          {body}
        </p>
      </div>
    </div>
  )

  return (
    <div className={CardStyles.trifold}>
      <Card
        header="Schedule Events"
        body="Schedule Reoccuring or one-time events. Then, RSVP & send reminders by email or notification."
        icon={<Calendar />}
      />
      <Card
        header="Keep Constant Communication"
        body="Create chatrooms with as many people as you need."
        icon={<ChatbubbleEllipses />}
      />
    </div>
  )
}
