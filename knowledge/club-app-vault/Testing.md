# Testing

## Unit Testing
Atleast 90% test coverage in frontend and backend at all times! Keeps the project easy to maintain.

## ACL Testing
Hasura has the concept of [ACL's,](https://hasura.io/blog/tagged/acl/) allowing only specific users to query specific data. This is our _only_ line of defense versus malicous actors, meaning we need to take this seriously.

There's a built up framework on testing the ACL's. Whenever a new table, etc. is created, add tests that essentially say that no one can do anything. As you need more permissions, play around with as much cases as possible. I'd rather we overtest everything and cover every vector than accidently leave one open, leaving the user exposed.

ex. test that a user CAN change his own name BUT not anyone elses.

## Integration Testing
Flutter will "Drive" through the whole app, testing every feature step by step on many devices. Whenever adding a new feature to the frontend, update your feature to be tested in the Integration test.