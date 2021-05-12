import 'dart:io';
import 'package:fe/config.dart';
import 'package:fe/data_classes/models/bridge_tables/user_to_group.dart';
import 'package:fe/data_classes/models/group/group_dao.dart';
import 'package:fe/data_classes/models/group/group_table.dart';
import 'package:fe/data_classes/models/user/user_dao.dart';
import 'package:fe/data_classes/models/user/user_table.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../service_locator.dart';

part 'db_manager.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file, logStatements: getIt<Config>().debug);
  });
}

@UseMoor(tables: [Groups, Users, UserToGroup], daos: [GroupsDao, UsersDao])
class DatabaseManager extends _$DatabaseManager {
  DatabaseManager() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          debugPrint('Opening db with v${details.versionNow}');
        },
      );
}
