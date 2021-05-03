to run in dev mode: `flutter run` (will ONLY work if `club-app-be` running locally)

to run in prod mode (connect to prod db and be) on mobile (Phyiscal Device, Simulator fails): `flutter run -t lib/prod_main.dart --release`

to schema pull: `get-graphql-schema --header x-hasura-admin-secret="ADMIN SECRET" https://club-app-db.herokuapp.com/v1/graphql > ./lib/schema.graphql`

to build generated files (GQL, serialized data): `flutter pub run build_runner build --delete-conflicting-outputs` add `--watch` to make it a background process.

If adding tables, you *must* make sure that when GroupRepository remove group is
called, all the related tables get cleaned up.

TODO; 
in main wrapper, we need to check if there is local groups and if not THEN
network groups. 