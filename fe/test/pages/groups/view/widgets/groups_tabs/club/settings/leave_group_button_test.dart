import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/cubit/group_req_cubit.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/leave_group_button.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';
import 'package:fe/gql/remove_self_from_group.data.gql.dart';
import 'package:fe/gql/remove_self_from_group.var.gql.dart';
import '../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../test_helpers/mocks.dart';
import '../../../../../../../test_helpers/pump_app.dart';

void main() {
  final Club fakeClub =
      Club(id: UuidType.generate(), admin: false, name: 'club of clubs');
  final User fakeUser = User(name: 'ant', id: UuidType.generate());

  final MockMainCubit mockMainCubit = MockMainCubit.getMock();
  final MockGroupReqCubit mockGroupReqCubit = MockGroupReqCubit.getMock();
  final MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();

  Future<void> leaveGroup(WidgetTester tester) async {
    when(() => mockToasterCubit.add(any())).thenAnswer((invocation) {
      final toast = invocation.positionalArguments[0] as Toast;

      if (toast.action != null) {
        toast.action!.action();
      }
    });

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
  }

  Widget wrapWithDependencies({required Widget child}) {
    return Provider(
      create: (_) => fakeClub,
      child: MultiBlocProvider(providers: [
        BlocProvider<ToasterCubit>(
          create: (_) => mockToasterCubit,
        ),
        BlocProvider<UserCubit>(create: (_) => UserCubit(fakeUser)),
        BlocProvider<GroupReqCubit>(create: (_) => mockGroupReqCubit),
        BlocProvider<MainCubit>(create: (_) => mockMainCubit),
      ], child: child),
    );
  }

  setUpAll(() {
    registerFallbackValue(GRemoveSelfFromGroupReq((q) => q
      ..vars.groupId = UuidType.generate()
      ..vars.userId = UuidType.generate()));
  });

  setUp(() async {
    await registerAllMockServices();
  });

  testWidgets('should refresh main cubit and group req on req complete',
      (tester) async {
    when(() => mockMainCubit.initalizeMainPage()).thenAnswer((_) async => null);
    when(() => getIt<AuthGqlClient>()
            .mutateFromUi<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
          any(),
          any(),
          errorMessage: any(named: 'errorMessage'),
          successMessage: any(named: 'successMessage'),
          onComplete: any(named: 'onComplete'),
        )).thenAnswer((invoc) async {
      invoc.namedArguments[const Symbol('onComplete')]!('blah');
    });

    await tester.pumpApp(wrapWithDependencies(child: LeaveGroupButton()));
    await leaveGroup(tester);
    await tester.pumpAndSettle();

    verify(() => mockGroupReqCubit.refresh()).called(1);
    verify(() => mockMainCubit.initalizeMainPage()).called(1);
    verify(() => getIt<AuthGqlClient>()
        .mutateFromUi<GRemoveSelfFromGroupData, GRemoveSelfFromGroupVars>(
            any(that: isA<GRemoveSelfFromGroupReq>()), any(),
            errorMessage: any(named: 'errorMessage'),
            onComplete: any(named: 'onComplete'),
            successMessage: any(named: 'successMessage'))).called(1);
  });
}
