import 'package:fe/services/local_data/local_file_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helpers/path_provider_setup.dart';

void main() {
  final pathProviderSetups = pathProviderSetup('local_file_store_test');

  setUpAll(() async {
    await pathProviderSetups[0]();
  });

  tearDownAll(() async {
    await pathProviderSetups[1]();
  });

  group('clear', () {
    test('should clear all local storage keys', () async {
      final localFileStore = LocalFileStore();

      await localFileStore.serialize(LocalStorageType.AccessTokens, 'asas');
      await localFileStore.clear();

      expect(await localFileStore.deserialize(LocalStorageType.AccessTokens),
          isNull);
    });
  });
}
