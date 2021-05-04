import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalFileStore {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> clear() async {
    final List<Future<FileSystemEntity>> futures = [];

    final path = (await getApplicationDocumentsDirectory()).path;

    for (final lst in LocalStorageType.values) {
      final file = File('$path/${lst.fileName}.json');

      futures.add(file.exists().then((doesExist) {
        if (doesExist) {
          return file.delete();
        }
        return file;
      }));
    }

    await Future.wait(futures);
  }

  Future<String?> deserialize(LocalStorageType localStorageType) async {
    final file = await _buildFile(localStorageType);
    if (await file.exists()) return await file.readAsString();
    return null;
  }

  Future<void> serialize(
      LocalStorageType localStorageType, Map<String, dynamic> jsonObj) async {
    final file = await _buildFile(localStorageType);
    await file.writeAsString(json.encode(jsonObj));
  }

  Future<File> _buildFile(LocalStorageType lst) async {
    final fileName = '${await _localPath}/${lst.fileName}.json';
    return File(fileName);
  }
}

enum LocalStorageType { LocalUser }

//serde singleton like objects.
extension FileName on LocalStorageType {
  String get fileName {
    return ['local_user'][index];
  }
}
