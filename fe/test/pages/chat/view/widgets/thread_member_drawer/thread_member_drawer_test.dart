import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/dm.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/view/widgets/thread_members_drawer/chat_right_drawer.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_users_in_thread.req.gql.dart';
import 'package:fe/gql/query_users_in_thread.data.gql.dart';
import 'package:fe/gql/query_users_in_dm.req.gql.dart';
import 'package:fe/gql/query_users_in_dm.data.gql.dart';

import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeThread = Thread(name: 'blah name', id: UuidType.generate());
  final fakeGroup =
      Club(name: 'fake group', id: UuidType.generate(), admin: false);
  final fakeDm = Dm(name: 'fake dm', id: UuidType.generate(), users: []);

  final fakeUsers = [
    User(name: 'name', id: UuidType.generate()),
    User(name: 'nameblah', id: UuidType.generate())
  ];

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return child;
  }

  testWidgets('should display no users copy on no users', (tester) async {
    stubGqlResponse(getIt<AuthGqlClient>(),
        requestMatcher: isA<GQueryUsersInThreadReq>(),
        data: (_) => GQueryUsersInThreadData.fromJson({'user_to_thread': []})!);

    await tester.pumpApp(wrapWithDependencies(
        child: ChatRightDrawer(thread: fakeThread, group: fakeGroup)));
    await tester.pump();

    expect(find.text(ChatRightDrawer.NO_USERS_COPY), findsOneWidget);
  });

  group('on group', () {
    testWidgets('should render all users', (tester) async {
      stubGqlResponse(getIt<AuthGqlClient>(),
          requestMatcher: isA<GQueryUsersInThreadReq>(),
          data: (_) => GQueryUsersInThreadData.fromJson({
                'user_to_thread':
                    fakeUsers.map((e) => {'user': e.toJson()}).toList()
              })!);

      await tester.pumpApp(wrapWithDependencies(
          child: ChatRightDrawer(thread: fakeThread, group: fakeGroup)));
      await tester.pump();

      fakeUsers.forEach((user) => expect(find.text(user.name), findsOneWidget));
    });
  });

  group('on dm', () {
    testWidgets('should render all users', (tester) async {
      stubGqlResponse(getIt<AuthGqlClient>(),
          requestMatcher: isA<GQueryUsersInDmReq>(),
          data: (_) => GQueryUsersInDmData.fromJson({
                'user_to_dm':
                    fakeUsers.map((e) => {'user': e.toJson()}).toList()
              })!);

      await tester.pumpApp(wrapWithDependencies(
          child: ChatRightDrawer(thread: fakeThread, group: fakeDm)));
      await tester.pump();

      fakeUsers.forEach((user) => expect(find.text(user.name), findsOneWidget));
    });
  });
}
