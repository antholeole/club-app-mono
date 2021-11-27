import 'package:fe/services/local_data/image_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const ImageConfiguration());
    registerFallbackValue(ImageStreamListener((_, __) {}));
  });

  test('should stream image', () async {
    final handler = ImageHandler();
    final fakeImageProvider = FakeImageProvider();
    final fakeImageStream = FakeImageStream();

    when(() => fakeImageProvider.resolve(any())).thenReturn(fakeImageStream);

    when(() => fakeImageStream.addListener(any())).thenAnswer((invocation) {
      final streamListener =
          (invocation.positionalArguments[0] as ImageStreamListener);

      streamListener.onImage(FakeImageInfo(), true);
    });

    await handler.preCache(fakeImageProvider);

    verify(() => fakeImageProvider.resolve(any())).called(1);
  });

  test('should throw error on stream image failed', () async {
    final handler = ImageHandler();
    final fakeImageProvider = FakeImageProvider();
    final fakeImageStream = FakeImageStream();
    final e = Exception();

    when(() => fakeImageProvider.resolve(any()))
        .thenAnswer((invocation) => fakeImageStream);

    when(() => fakeImageStream.addListener(any())).thenAnswer((invocation) {
      final streamListener =
          (invocation.positionalArguments[0] as ImageStreamListener);

      streamListener.onError!(e, StackTrace.empty);
    });

    expect(() async => await handler.preCache(fakeImageProvider),
        throwsA(isA<Exception>()));
  });
}
