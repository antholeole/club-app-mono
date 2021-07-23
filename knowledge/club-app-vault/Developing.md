# Developing

Make sure you look through [onboarding](./Onboarding.md) first.

## Getting started
Install [Presequites](./Presequites.md)

### Developing Full Stack
1. In root, `make i`
2. Make sure docker is up and run `make run` in root.
	- This will take a little. Feel free to move on to the next step as this is running.
3. run `cd fe && make generate && flutter run`.
	- This will generate all the flutter models, and then run the app.

More on developing and individual parts of the app:
- [Flutter App](Developing_Flutter.md)
- [Cloudflare Worker](./Cloudflare_Worker/Developing_Worker.md)

### Committing

commits must be in the following form:

```
<Action>(<Scope>): <Message>
```

Where action is one of:
- build
- chore
- ci
- docs
- feat
- fix
- perf
- refactor
- revert
- style
- test

depending on the change made and

Scope is one of:
- root
- flutter
- worker
- hasura
- knowledge
- website

depending on the area it is made.

and Message is a regular sentence, "fixed that". Mind casing.