make:
	echo "Please use 'flutter run'"

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

clean:
	find . -maxdepth 20 -type f \( -name "*.ast.gql.dart" -o -name "**.req.gql.dart" -o -name "*.data.gql.dart" -name "*.var.gql.dart" -o -name "*.gql.g.dart" -o -name "*.g.dart" -o -name "*.gql.dart" \) -delete && flutter clean && flutter pub get && flutter pub run build_runner clean

schema-pull:
	get-graphql-schema --header x-hasura-admin-secret="*hV@?*xh0)aL,@1+Tza>Kj[zC(5akn" http://localhost:8080/v1/graphql > ./lib/schema.graphql

t:
	flutter test --coverage && genhtml coverage/lcov.info -o coverage/html -q