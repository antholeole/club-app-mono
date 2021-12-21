import 'package:fe/data/models/role.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/settings/users/role_list.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/shared_widgets/role_manager/addable_roles_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../../../../test_helpers/get_it_helpers.dart';
import '../../../../../../../../test_helpers/pump_app.dart';

void main() {
  final fakeUser = User(id: UuidType.generate(), name: 'bob');
  final fakeRole = Role(id: UuidType.generate(), name: 'pego');

  setUp(() {
    registerAllMockServices();
  });

  Widget wrapWithDependencies({required Widget child}) {
    return child;
  }

  testWidgets('should show addable roles on addable roles', (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child:
            RoleList(hasRoles: [], addableRoles: [fakeRole], user: fakeUser)));

    expect(find.byType(AddableRoleDropdown), findsOneWidget);
  });

  testWidgets('should not show addable roles on null addable roles',
      (tester) async {
    await tester.pumpApp(wrapWithDependencies(
        child: RoleList(hasRoles: [], addableRoles: null, user: fakeUser)));

    expect(find.byType(AddableRoleDropdown), findsNothing);
  });
}
