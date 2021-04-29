/* eslint-disable jsx-a11y/label-has-associated-control */
import EmailStyles from './email.module.scss'

export const Email = () => (
  <form className={EmailStyles.email}>
    <label htmlFor="email">
      Want to be the first to know when Club App releases on Android and iOS?
    </label>
    <div className={EmailStyles.input}>
      <input id="email" name="email" type="email" placeholder="Email Address" />
      <button type="submit">Submit</button>
    </div>
  </form>
)
