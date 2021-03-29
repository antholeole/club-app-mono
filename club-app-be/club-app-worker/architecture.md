# Serverless framework 

## Architecture

### User flow 

1. See popup: JOIN or CREATE a club
2. If joining, enter CLUB CODE and join the club!
3. If create, give admin auth and create a club

### Key Features

- Group chat (w/ whole club)
- Channels (Users can setup channels and add other users)
- Message emotes (Can "react" to messages with emotes)
- Events (Admins can create "Events" that people can say if they are coming to or not)
- DM's

### "Want to have"
- Analytics with AWS pinpoint
- Forms - Users can create a form

### Architecture Details
- When a user logs in, he gets a websocket to AWS API Gateway and his id is put in a RedisDB (set)
- One worker is setup for "Notification" Which either -> Sends notification in app or iOS / Android notification
- When any action happens, we forward it to the notification service.
- A user's "Groups" Is stored in their JWT. NO USER -> GROUP TABLE
- ALL IMAGES stored in Backblaze b2


Services:
- Auth
- Chat 
- Notification (Only service that cares who's online)
- DBA
- FE (Landing, TOS, etc)

### Tables
NOTE:
- All userID fields = auth0 sub.
- DM's are considered "Groups", just with "IsDM = true"
- Materialized Views will be used for "stat" queries, like # of users in group, Event Attendance breakdown

Format:
- TABLENAME;
columnName,

* after columnname == required.

Group;
Id*, IsDM*, 

- User_to_Group;
Id*, userID*, GroupID*,

- Messages;
Id*, MessageContent*, SentTime*, GroupID*,

- MessagesEmotes;
Id*, MessageId*, Emote*, UserEmote*, 

- MessagesSeen;
Id*, MessageId*, UserID*,

- Events;
Id*, GroupID*, EventName*, DateTime, DateTimeCreated*, Description, 

- EventAttendance;
Id*, GroupID*, EventId*, UserId*



### pricing

Total monthly bill at low scale:
- Cloudflare workers - mostly free
- Heroku for Hasura + postgres: Free for a while!
- API gateway: Mostly free (Pennies)
- Backblaze -> will start cheap :/

## Other notes
- For now, no redis for who is online. Just:

on Connect: 
db.recepeint.apiGatewayId = connectToApiGateway

on Message:
message.recepients.forEach((recepeient) => {
    try {
        sendMessageToReceipient
    } else {
        db.recepient.apiGatewayId = null
        sendNotificationToRecepient
    }
})