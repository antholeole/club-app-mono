import 'dart:convert';
import 'dart:io';

import 'package:fake_async/fake_async.dart';
import 'package:fe/data/ws_message/connect_message.dart';
import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/data/ws_message/ping_message.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/io.dart';

import '../../test_helpers/get_it_helpers.dart';

void main() {
  fakeAsync((async) {
    const token = 'IM A TOKEN FEAR ME';

    setUp(() async {
      await registerAllMockServices();
    });

    group('no server', () {
      group('initalize', () {
        test('should emit connectionState.error on socketException', () async {
          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => 'token');

          final client = WsClient();
          final multipleConnectionFuture = expectLater(
            client.connectionState,
            emitsInOrder([
              WsConnectionState.Connecting,
              WsConnectionState.Error,
            ]),
          );

          await client.initalize();

          await multipleConnectionFuture;
        });
      });
    });

    group('with valid server', () {
      late HttpServer server;

      IOWebSocketChannel? channel;

      HttpHeaders? headers;

      tearDown(() async {
        if (channel != null) {
          await channel!.sink.close();
          channel = null;
        }

        await server.close();
      });

      setUp(() async {
        server = await HttpServer.bind('localhost', 8175);
        server.listen((req) async {
          headers = req.headers;
          final socket = await WebSocketTransformer.upgrade(req);
          channel = IOWebSocketChannel(socket);
        });
      });

      group('initalize', () {
        test('should use token manager token on successful read', () async {
          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => token);

          final client = WsClient();
          await client.initalize();
          await expectLater(channel!.sink, isNotNull);

          expect(headers!['Authorization']!.first, contains(token));
        });

        test('should use refreshed token on unsuccessful read', () async {
          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => null);
          when(() => getIt<TokenManager>().refresh())
              .thenAnswer((_) async => token);

          final client = WsClient();
          await client.initalize();
          await expectLater(channel!.sink, isNotNull);

          expect(headers!['Authorization']!.first, contains(token));
        });

        group('on failed refresh', () {
          const refreshFail = Failure(status: FailureStatus.RefreshFail);

          setUp(() {
            when(() => getIt<TokenManager>().read())
                .thenAnswer((_) async => null);
            when(() => getIt<TokenManager>().refresh()).thenThrow(refreshFail);
          });

          test('should emit failure', () async {
            final client = WsClient();

            final failureFuture =
                expectLater(client.failureStream, emits(refreshFail));

            await client.initalize();

            await failureFuture;
          });

          test('should emit connection failed', () async {
            final client = WsClient();

            final connectionStateFuture = expectLater(
                client.connectionState,
                emitsInOrder(
                  [WsConnectionState.Connecting, WsConnectionState.Error],
                ));

            await client.initalize();

            await connectionStateFuture;
          });

          test('should schedule refresh', () async {
            final client = WsClient();

            final multipleConnectionFuture = expectLater(
                client.connectionState,
                emitsInOrder([
                  WsConnectionState.Connecting,
                  WsConnectionState.Error,
                  WsConnectionState.Connecting,
                ]),
                reason: 'should have tried connecting multiple times');

            await client.initalize();

            async.elapse(const Duration(seconds: 2) +
                WsClient.DEFAULT_SCHEDULED_RECONNECT_WAIT);

            await multipleConnectionFuture;
          });
        });

        test('should emit connectionState.connected on successful connection',
            () async {
          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => 'token');

          final client = WsClient();
          final multipleConnectionFuture = expectLater(
            client.connectionState,
            emitsInOrder([
              WsConnectionState.Connecting,
              WsConnectionState.Connected,
            ]),
          );

          await client.initalize();

          await multipleConnectionFuture;
        });
      });

      group('message output', () {
        late WsClient client;

        setUpAll(() async {
          await registerAllMockServices();

          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => 'token');

          client = WsClient();
        });

        setUp(() async {
          await client.initalize();
        });

        test('should emit connected on connected and ping message', () async {
          final messages = [
            const WsPingMessage().toJson(),
            const WsConnectMessage().toJson()
          ];

          for (final message in messages) {
            final connectMessageMatcher = expectLater(
                client.connectionState, emits(WsConnectionState.Connected));

            channel!.sink.add(json.encode(message));

            await connectMessageMatcher;
          }
        });

        test('should emit inputted message on message', () async {
          final messages = [
            WsMessageMessage(message: 'hi', toId: UuidType.generate())
          ];

          for (final message in messages) {
            final messageMessageMatcher =
                expectLater(client.messageStream, emits(message));

            channel!.sink.add(json.encode(message.toJson()));

            await messageMessageMatcher;
          }
        });
      });

      /*
      not smart enough i guess
      test('valid initalize should cancel reconnect', () async {
        final tokens = [null, 'token'];

        when(() => getIt<TokenManager>().read())
            .thenAnswer((_) async => tokens.removeAt(0));
        when(() => getIt<TokenManager>().refresh())
            .thenThrow(const Failure(status: FailureStatus.RefreshFail));

        final wsClient = WsClient();

        final firstConnectionStatuses = expectLater(
            wsClient.connectionState,
            emitsInOrder([
              WsConnectionState.Connecting,
              WsConnectionState.Error,
              WsConnectionState.Connecting
            ]));

        await wsClient.initalize();
        await wsClient.initalize();

        await firstConnectionStatuses;

        final afterValidConnectionEmpty =
            expectLater(wsClient.connectionState, emits([]));

        async.elapse(const Duration(seconds: 2) +
            WsClient.DEFAULT_SCHEDULED_RECONNECT_WAIT);

        await afterValidConnectionEmpty;
      });

      test('should retry on connection close', () async {
        when(() => getIt<TokenManager>().read())
            .thenAnswer((_) async => 'token');

        final wsClient = WsClient();

        final connectionStreamMatcher = expectLater(
            wsClient.connectionState,
            emitsInOrder([
              WsConnectionState.Connecting,
              WsConnectionState.Connected,
              WsConnectionState.Connecting,
            ]));

        await wsClient.initalize();
        await sink!.close();

        await connectionStreamMatcher;
      });
      */

      group('close', () {
        test('should close sink', () async {
          when(() => getIt<TokenManager>().read())
              .thenAnswer((_) async => 'token');

          final wsClient = WsClient();
          await wsClient.initalize();

          final shouldClose = expectLater(channel!.stream, emitsDone);

          await wsClient.close();

          await shouldClose;
        });
      });
    });
  });
}
