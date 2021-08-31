import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:meta/meta.dart';
import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:fe/gql/insert_message.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import '../../../service_locator.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final _gqlClient = getIt<AuthGqlClient>();
  final _localUserService = getIt<LocalUserService>();

  ChatCubit() : super(ChatState.inital());

  Future<void> sendMessage(UuidType threadId, String message) async {
    final selfId = await _localUserService.getLoggedInUserId();

    await _gqlClient.request(GInsertMessageReq((q) => q
      ..vars.message = message
      ..vars.selfId = selfId
      ..vars.threadId = threadId));
  }

  Future<void> getChats(Thread thread, DateTime before) async {
    GQueryMessagesInThreadData resp;

    try {
      resp = await _gqlClient.request(GQueryMessagesInThreadReq((q) => q
        ..vars.before = before
        ..vars.threadId = thread.id));
    } on Failure catch (f) {
      emit(ChatState.failure(f));
      return;
    }

    final chats = resp.messages
        .map((message) => Message(
            isImage: message.is_image,
            updatedAt: message.updated_at ?? message.created_at,
            id: message.id,
            user: User(
                name: message.user.name,
                profilePictureUrl: message.user.profile_picture,
                id: message.user.id),
            message: message.message,
            createdAt: message.created_at))
        .toList();

    if (chats.isNotEmpty) {
      emit(ChatState.fetchedMessages(chats, chats.last.createdAt));
    } else {
      emit(ChatState.fetchedMessages([], null));
    }
  }
}
