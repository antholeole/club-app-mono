import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/groups_page.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/profile/view/profile_page.dart';
import 'package:fe/pages/scaffold/view/widgets/drawers/left_drawer/club_drawer.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';

import '../../../../../../test_helpers/fixtures/mocks.dart';
import '../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../test_helpers/pump_app.dart';
import '../../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final fakeUser = User(name: 'asasd', id: UuidType.generate());
  final mockMainCubit = MockMainCubit.getMock();

  Widget wrapWithDependencies(Widget child) {
    return MultiBlocProvider(providers: [
      BlocProvider<MainCubit>(
        create: (_) => mockMainCubit,
      )
    ], child: BlocProvider(create: (_) => UserCubit(fakeUser), child: child));
  }

  setUp(() {
    registerAllMockServices();
  });

  testWidgets('should display the correct page', (tester) async {
    stubGqlResponse<GQuerySelfGroupsData, GQuerySelfGroupsVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GQuerySelfGroupsData.fromJson({})!);

    await tester.pumpApp(wrapWithDependencies(ClubDrawer()));
    expect(find.byType(GroupsPage), findsOneWidget);
    await tester.drag(find.byType(GroupsPage), const Offset(-100, 0));
    await tester.pump();

    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
