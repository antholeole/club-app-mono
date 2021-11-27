import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/groups/view/widgets/settings/leave_group_button.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:fe/gql/remove_self_from_group.data.gql.dart';
import 'package:fe/gql/remove_self_from_group.var.gql.dart';

import '../../../../../test_helpers/mocks.dart';
import '../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../test_helpers/pump_app.dart';
import '../../../../../test_helpers/stub_gql_response.dart';

void main() {
  final Club fakeClub =
      Club(id: UuidType.generate(), admin: false, name: 'club of clubs');
  final User fakeUser = User(name: 'ant', id: UuidType.generate());

  final MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();
  final MockMainCubit mockMainCubit = MockMainCubit.getMock();
  final MockGroupReqCubit mockGroupReqCubit = MockGroupReqCubit.getMock();

  Widget wrapWithDependencies({required Widget child}) {
    return Provider(
      create: (_) => fakeClub,
      child: MultiBlocProvider(providers: [
        BlocProvider<UserCubit>(create: (_) => UserCubit(fakeUser)),
        BlocProvider<ToasterCubit>(create: (_) => mockToasterCubit),
        BlocProvider<GroupReqCubit>(create: (_) => mockGroupReqCubit),
        BlocProvider<MainCubit>(create: (_) => mockMainCubit),
      ], child: child),
    );
  }

  setUp(() async {
    await registerAllMockServices();
  });

  testWidgets('should update contexts on group leave', (tester) async {
    when(() => mockToasterCubit.add(any())).thenAnswer((invocation) {
      (invocation.positionalArguments.first as Toast).action?.action();
      return null;
    });
    when(() => mockMainCubit.initalizeMainPage()).thenAnswer((_) async => null);

    stubGqlResponse<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
        getIt<AuthGqlClient>(),
        data: (_) => GRemoveSelfFromGroupData.fromJson({
              'delete_user_to_group': {'affected_rows': 1}
            })!);

    await tester.pumpApp(wrapWithDependencies(child: LeaveGroupButton()));
    await tester.tap(find.byType(LoadableTileButton));

    verify(() => mockGroupReqCubit.refresh()).called(1);
    verify(() => mockMainCubit.initalizeMainPage()).called(1);
  });

  testWidgets('should update contexts on group leave', (tester) async {
    when(() => mockToasterCubit.add(any())).thenAnswer((invocation) {
      (invocation.positionalArguments.first as Toast).action?.action();
      return null;
    });
    when(() => mockMainCubit.initalizeMainPage()).thenAnswer((_) async => null);

    stubGqlResponse<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
        getIt<AuthGqlClient>(),
        error: (_) => Failure(status: FailureStatus.GQLMisc));

    await tester.pumpApp(wrapWithDependencies(child: LeaveGroupButton()));
    await tester.tap(find.byType(LoadableTileButton));

    verifyNever(() => mockGroupReqCubit.refresh());
    verifyNever(() => mockMainCubit.initalizeMainPage());
    verify(() => getIt<Handler>().handleFailure(any(), any())).called(1);
  });
}
