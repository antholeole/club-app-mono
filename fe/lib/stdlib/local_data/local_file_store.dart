import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum LocalStorageType { LocalUser, GroupIds }

extension FileName on LocalStorageType {
  String get fileName {
    return ['local_user', 'groups'][index];
  }
}

//serde singleton like objects.
class LocalFileStore {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> clear() async {
    final List<Future<FileSystemEntity>> futures = [];

    for (final lst in LocalStorageType.values) {
      final file = await _buildFile(lst);
      futures.add(file.delete());
    }

    await Future.wait(futures);
  }

  Future<File> _buildFile(LocalStorageType lst) async {
    final fileName = '${await _localPath}/${lst.fileName}.json';
    return File(fileName);
  }

  Future<void> serialize(
      LocalStorageType localStorageType, Map<String, dynamic> jsonObj) async {
    final file = await _buildFile(localStorageType);
    await file.writeAsString(json.encode(jsonObj));
  }

  Future<String?> deserialize(LocalStorageType localStorageType) async {
    final file = await _buildFile(localStorageType);
    if (await file.exists()) return await file.readAsString();
    return null;
  }
}
