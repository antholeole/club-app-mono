make:
	echo "Please use 'flutter run'"

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

clean:
	find . -maxdepth 20 -type f \( -name "*.ast.gql.dart" -o -name "**.req.gql.dart" -o -name "*.data.gql.dart" -name "*.var.gql.dart" -o -name "*.gql.g.dart" -o -name "*.g.dart" -o -name "*.gql.dart" -o -name "*.mocks.dart" \) -delete && flutter clean && flutter pub get && flutter pub run build_runner clean

schema-pull:
	get-graphql-schema --header x-hasura-admin-secret="aodrkofkioermwieojrowiemfosdmfiosdmfisdmfiosdmfiosmaoisaosidmoi" http://localhost:8080/v1/graphql > ./lib/schema.graphql

t:
	flutter test --coverage
	
	
t-clean:
	lcov --remove coverage/lcov.info \
	'lib/data/*' \
	'lib/gql/*' \
	'lib/gql/*' \
	'lib/schema.graphql' \
	'lib/**/*_state.dart' \
	'lib/**/*_event.dart' \
	'lib/*.gql.g.dart' \
	'lib/*.gql.dart' \
	'lib/config.dart' \
	'lib/service_locator.dart' \
	'lib/services/clients/gql_client/cache.dart' \
	'lib/stdlib/helpers/uuid_type.dart' \
	'**/data_carriers/*' \
	'lib/stdlib/errors/failure_status.dart' \
	'lib/stdlib/helpers/datetime_type_converter.dart' \
	-o coverage/out_cov.info

view-cov: 
	genhtml coverage/out_cov.info --output=coverage/html && open coverage/html/index.html