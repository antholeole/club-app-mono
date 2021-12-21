import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/club_drawer/thread_users.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_users_in_thread.req.gql.dart';
import 'package:fe/gql/query_users_in_thread.data.gql.dart';

import 'package:provider/provider.dart';

import '../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../test_helpers/pump_app.dart';
import '../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeThread = Thread(name: 'blah name', id: UuidType.generate());

  final fakeUsers = [
    User(name: 'name', id: UuidType.generate()),
    User(name: 'nameblah', id: UuidType.generate())
  ];

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return MultiProvider(providers: [
      Provider.value(value: fakeThread),
      BlocProvider(
          create: (_) =>
              UserCubit(User(id: UuidType.generate(), name: 'asdasd')))
    ], child: child);
  }

  group('on group', () {
    testWidgets('should render all users', (tester) async {
      stubGqlResponse(getIt<AuthGqlClient>(),
          requestMatcher: isA<GQueryUsersInThreadReq>(),
          data: (_) => GQueryUsersInThreadData.fromJson({
                'user_to_thread':
                    fakeUsers.map((e) => {'user': e.toJson()}).toList()
              })!);

      await tester.pumpApp(wrapWithDependencies(child: const ThreadUsers()));
      await tester.pump();
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      fakeUsers.forEach((user) => expect(find.text(user.name), findsOneWidget));
    });
  });
}
