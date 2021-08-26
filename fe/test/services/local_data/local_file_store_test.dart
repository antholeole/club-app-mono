import 'package:fe/services/local_data/local_file_store.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider');

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '.';
    });
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
