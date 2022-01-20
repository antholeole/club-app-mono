import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalFileStore {
  Future<String> _localPath(LocalStorageType localStorageType) async {
    Future<Directory> dir;
    switch (localStorageType.documentType) {
      case _DocumentType.Document:
        dir = getApplicationDocumentsDirectory();
        break;
      case _DocumentType.Support:
        dir = getApplicationSupportDirectory();
        break;
    }
    final directory = await dir;
    return directory.path;
  }

  Future<void> delete(LocalStorageType lst) async {
    final path = await _localPath(lst);
    final file = File('$path/${lst.fileName}.${lst.fileExtension}');

    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> clear() async {
    final List<Future<FileSystemEntity>> futures = [];

    for (final lst in LocalStorageType.values) {
      final path = await _localPath(lst);
      final file = File('$path/${lst.fileName}.${lst.fileExtension}');

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
      LocalStorageType localStorageType, String objEncoding) async {
    final file = await _buildFile(localStorageType);
    await file.writeAsString(objEncoding);
  }

  Future<File> _buildFile(LocalStorageType lst) async {
    final fileName =
        '${await _localPath(lst)}/${lst.fileName}.${lst.fileExtension}';
    return File(fileName);
  }
}

enum LocalStorageType { AccessTokens, LocalUser, Notifications }
enum _DocumentType {
  Document,
  Support,
  /*Temporary*/
}

extension FileName on LocalStorageType {
  String get fileName {
    switch (this) {
      case LocalStorageType.AccessTokens:
        return 'access_tokens';
      case LocalStorageType.LocalUser:
        return 'user';
      case LocalStorageType.Notifications:
        return 'notifications';
    }
  }

  _DocumentType get documentType {
    switch (this) {
      case LocalStorageType.AccessTokens:
        return _DocumentType.Support;
      case LocalStorageType.LocalUser:
        return _DocumentType.Document;
      case LocalStorageType.Notifications:
        return _DocumentType.Document;
    }
  }

  String get fileExtension {
    switch (this) {
      case LocalStorageType.AccessTokens:
      case LocalStorageType.Notifications:
        return 'json';
      case LocalStorageType.LocalUser:
        return 'txt';
    }
  }
}
