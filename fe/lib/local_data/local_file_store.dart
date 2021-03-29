import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum LocalStorageType { LocalUser }

extension FileName on LocalStorageType {
  String get fileName {
    return ['local_user'][index];
  }
}

//serde singleton like objects.
class LocalFileStore {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> serialize(
      LocalStorageType localStorageType, Map<String, dynamic> jsonObj) async {
    final fileName = '${await _localPath}/${localStorageType.fileName}.json';
    final file = File(fileName);
    await file.writeAsString(json.encode(jsonObj));
  }

  Future<String?> deserialize(LocalStorageType localStorageType) async {
    final fileName = '${await _localPath}/${localStorageType.fileName}.json';
    final file = File(fileName);

    if (await file.exists()) return await file.readAsString();
    return null;
  }
}
