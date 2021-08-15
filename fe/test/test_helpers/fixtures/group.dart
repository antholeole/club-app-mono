import 'package:fe/data/models/group.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';

final Group mockGroupAdmin = Group(
    id: UuidType('c95a55d4-2d83-4461-84f2-f3e9150bedc2'),
    name: 'adminGroup',
    admin: true);
final Group mockGroupNotAdmin = Group(
    id: UuidType('77527a5b-111b-4c4d-81ab-afeaeee357ec'),
    name: 'notAdminGroup',
    admin: false);
