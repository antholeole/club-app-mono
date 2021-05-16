Read the make file to see what can be done.

To boot from new:
1. Make sure that you have the backend running
2. `Make schema-pull`
3. `Make generate`
4. `flutter run`

to run in prod mode (connect to prod db and be) on mobile (Phyiscal Device, Simulator fails): `flutter run -t lib/prod_main.dart --release`

To run dependency validation, do `pub run dependency_validator`.
This is handled by CI

TODO; 
DESIGN: should we instead have DAO manage all GQL queries? easily evict, etc.
Chat screen -> fetch and display chats.
should save last screen to userprefs and be able to route accordingly