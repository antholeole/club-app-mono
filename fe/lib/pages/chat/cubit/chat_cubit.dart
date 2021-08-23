import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/gql_req_or_throw_failure.dart';
import 'package:ferry/ferry.dart';
import 'package:meta/meta.dart';
import 'package:fe/gql/query_messages_in_thread.req.gql.dart';
import 'package:fe/gql/query_messages_in_thread.data.gql.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import '../../../service_locator.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final _gqlClient = getIt<Client>();

  ChatCubit() : super(ChatState.inital());

  Future<void> getChats(Thread thread, DateTime before) async {
    GQueryMessagesInThreadData resp;

    try {
      resp = await gqlReqOrThrowFailure(
          GQueryMessagesInThreadReq((q) => q
            ..vars.before = before
            ..vars.threadId = thread.id),
          _gqlClient);
    } on Failure catch (f) {
      emit(ChatState.failure(f));
      return;
    }

    final chats = resp.messages
        .map((message) => Message(
            isImage: message.is_image,
            updatedAt: message.updated_at,
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
