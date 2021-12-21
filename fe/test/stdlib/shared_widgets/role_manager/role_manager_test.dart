import 'package:fe/data/models/role.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/addable_roles_dropdown.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/role_manager.dart';
import 'package:fe/stdlib/shared_widgets/toasting_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/mocks.dart';
import '../../../test_helpers/pump_app.dart';

void main() {
  MockToasterCubit mockToasterCubit = MockToasterCubit.getMock();
  final fakeRoles = [
    Role(id: UuidType.generate(), name: 'name1'),
    Role(id: UuidType.generate(), name: 'name2'),
    Role(id: UuidType.generate(), name: 'name3'),
    Role(id: UuidType.generate(), name: 'name4'),
  ];

  setUpAll(() {
    registerAllMockServices();

    mockToasterCubit = MockToasterCubit.getMock();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return Provider<ToasterCubit>(
        create: (_) => mockToasterCubit, child: child);
  }

  testWidgets('should not display add roles if initalAddableRoles null',
      (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: RoleManager(
      initalRoles: [fakeRoles[0]],
      header: const Text('hi'),
    )));

    expect(find.byType(AddableRoleDropdown), findsNothing);
    expect(find.byType(ToastingDismissable), findsNothing);
  });

  testWidgets('should display add roles if roleManagerData not null',
      (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: RoleManager(
      initalRoles: [],
      header: const Text('hi'),
      roleManagerData: RoleManagerData(
          initalAddableRoles: [fakeRoles[0]],
          removeRolePromptText: (_) => 'blah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {},
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => 'ab',
          addRoles: (_) async {},
          successfullyAddedRolesText: (_) => 'a'),
    )));

    expect(find.byType(AddableRoleDropdown), findsOneWidget);
  });

  group('remove role', () {
    Future<void> removeRole(WidgetTester tester) async {
      when(() => mockToasterCubit.add(any())).thenAnswer((invoc) {
        final promptToast = invoc.positionalArguments[0] as Toast;

        promptToast.action?.action();
      });

      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
      await tester.drag(find.text(fakeRoles[0].name), const Offset(-500, 0));
      await tester.pumpAndSettle();
    }

    testWidgets('should call role manager remove role', (tester) async {
      final caller = MockCaller();
      final data = RoleManagerData(
          initalAddableRoles: [],
          removeRolePromptText: (_) => 'blah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async => caller.call(),
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => 'ab',
          addRoles: (_) async {},
          successfullyAddedRolesText: (_) => 'a');

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [fakeRoles[0]],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      await removeRole(tester);

      verify(() => caller.call()).called(1);
    });

    testWidgets('should handle failure on remove failed', (tester) async {
      final failure = Failure(status: FailureStatus.GQLMisc);
      const failPrefix = 'FAIL PREFIX';

      final data = RoleManagerData(
          initalAddableRoles: [],
          removeRolePromptText: (_) => 'bah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {
            throw failure;
          },
          failedToRemoveRoleText: (_) => failPrefix,
          failedToAddRolesText: () => 'ab',
          addRoles: (_) async {},
          successfullyAddedRolesText: (_) => 'a');

      when(() => getIt<Handler>().handleFailure(failure, any(),
              withPrefix: any(named: 'withPrefix', that: equals(failPrefix))))
          .thenAnswer((_) async => {});

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [fakeRoles[0]],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      await removeRole(tester);

      verify(() => getIt<Handler>().handleFailure(failure, any(),
              withPrefix: any(named: 'withPrefix', that: equals(failPrefix))))
          .called(1);
    });

    testWidgets('should appear on adding list', (tester) async {
      final data = RoleManagerData(
          initalAddableRoles: [],
          removeRolePromptText: (_) => 'bah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {},
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => 'ab',
          addRoles: (_) async {},
          successfullyAddedRolesText: (_) => 'a');

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [fakeRoles[0]],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      expect(find.byIcon(Icons.check), findsOneWidget,
          reason: 'should have all roles applied');

      await removeRole(tester);

      expect(find.byIcon(Icons.check), findsNothing,
          reason:
              'should NOT have roles applied (just removed role now applyable)');
    });
  });

  group('add role', () {
    Future<void> addRole(WidgetTester tester, Role role) async {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(
          of: find.byType(CheckboxListTile), matching: find.text(role.name)));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();
    }

    testWidgets('should call add role function', (tester) async {
      final caller = MockCaller();

      final data = RoleManagerData(
          initalAddableRoles: [fakeRoles[0]],
          removeRolePromptText: (_) => 'bah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {},
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => 'ab',
          addRoles: (_) async {
            caller.call();
          },
          successfullyAddedRolesText: (_) => 'a');

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      await addRole(tester, fakeRoles[0]);

      verify(() => caller.call()).called(1);
    });

    testWidgets('should handle failure on failure', (tester) async {
      final failure = Failure(status: FailureStatus.GQLMisc);
      const failPrefix = 'FAIL PREFIX';

      final data = RoleManagerData(
          initalAddableRoles: [fakeRoles[0]],
          removeRolePromptText: (_) => 'bah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {},
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => failPrefix,
          addRoles: (_) async {
            throw failure;
          },
          successfullyAddedRolesText: (_) => 'a');

      when(() => getIt<Handler>().handleFailure(failure, any(),
              withPrefix: any(named: 'withPrefix', that: equals(failPrefix))))
          .thenAnswer((_) async => {});

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      await addRole(tester, fakeRoles[0]);

      verify(() => getIt<Handler>().handleFailure(failure, any(),
              withPrefix: any(named: 'withPrefix', that: equals(failPrefix))))
          .called(1);
    });

    testWidgets(
        'should remove role from addable roles and add role to added roles',
        (tester) async {
      final data = RoleManagerData(
          initalAddableRoles: [fakeRoles[0]],
          removeRolePromptText: (_) => 'bah',
          successfullyRemovedRoleText: (_) => 'blah',
          removeRole: (_) async {},
          failedToRemoveRoleText: (_) => 'blah',
          failedToAddRolesText: () => 'a',
          addRoles: (_) async {},
          successfullyAddedRolesText: (_) => 'a');

      await tester.pumpApp(wrapWithDependencies(
          child: RoleManager(
        initalRoles: [],
        header: const Text('hi'),
        roleManagerData: data,
      )));

      expect(find.byIcon(Icons.check), findsNothing,
          reason: 'should NOT have roles applied');

      await addRole(tester, fakeRoles[0]);

      expect(find.byIcon(Icons.check), findsOneWidget,
          reason: 'role should be applied and thus no more applyable roles');
    });
  });
}
