# Developing Flutter

## Developing

Hot reloading is your friend. `flutter run` by default allows hot reloading.

### Builds
#### Development
`flutter run` by default runs in development mode. This mode allows hot reloading and has a debugger to attach.

Flutter run may fail for the first `flutter run` with `OSStatus error -54.`.
Go into xcode, and then run `ios/Runner.xcworspace`. It should work after that
if running on the same simulator.

#### Physical Device
TODO!

#### Production
If you're trying to run the production build, do `flutter run -t lib/prod_main.dart --release`. This will be the release build.


## Testing
When adding a feature, make sure to add it to the Integration test and unit test the hell out of it.


## Lints
- Whenever possible, make fields private. This adds a little constructor boilerplate but it's worth it.
- Use const where possible. This increases performance for no effort. The linter will help you, but be sure to check if you can make constructors const. 
