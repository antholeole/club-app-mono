import 'package:fe/data/models/message.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/features/chat_display/cubit/chat_cubit.dart';
import 'package:fe/pages/chat/features/chat_display/cubit/chat_state.dart';
import 'package:fe/pages/chat/features/message_overlay/message_overlay_display.dart';
import 'package:fe/pages/chat/features/send/cubit/send_cubit.dart';
import 'package:fe/pages/chat/features/send/cubit/send_state.dart';
import 'package:fe/pages/chat/features/send/widgets/sending_message.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';
import 'widgets/chat_page_message_display.dart';

class Chats extends StatefulWidget {
  @visibleForTesting
  static const String ERROR_COPY = 'There was an error while fetching chats.';

  @visibleForTesting
  static const String NO_MESSAGES_COPY = 'No messages yet.';

  const Chats({Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _handler = getIt<Handler>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: BlocConsumer<SendCubit, List<SendState>>(
        listener: (_, unsents) => unsents
            .where((sendState) =>
                sendState.map(sending: (_) => false, failure: (_) => true))
            .forEach((element) => context.read<ToasterCubit>().add(Toast(
                message: element.when(
                    sending: (_) => throw Exception('unreachable state'),
                    failure: (_, f, __) => f.message),
                type: ToastType.Error))),
        builder: (_, unsents) => BlocConsumer<ChatCubit, ChatState>(
          listener: (_, chatState) => chatState.maybeWhen(
            orElse: () => null,
            failure: (failure) => _handler.handleFailure(failure, context),
          ),
          builder: (_, state) => state.when(
              withMessages: (fm, hasMaxed) =>
                  _buildChats(fm, hasMaxed, unsents),
              failure: (failure) => _buildError(failure),
              loading: () => _buildLoading()),
        ),
      ),
    );
  }

  Widget _buildChats(
      Map<UuidType, Message> messages, bool hasMaxed, List<SendState> unsents) {
    int itemCount;

    if (messages.isEmpty && unsents.isEmpty) {
      return _buildNoChats(context.read<Thread>());
    }

    if (hasMaxed) {
      itemCount = messages.length;
    } else {
      itemCount = messages.length + 1;
    }

    itemCount += unsents.length;

    final List<Message> messagesOrdered = messages.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return MessageOverlayDisplay(
      child: ListView.builder(
          reverse: true,
          addAutomaticKeepAlives: true,
          controller: _scrollController,
          itemCount: itemCount,
          itemBuilder: (context, i) {
            if (i < unsents.length) {
              return SendingMessageDisplay(
                  sendState: unsents[unsents.length - 1 - i]);
            }

            if (i >= messages.length + unsents.length) {
              context.read<ChatCubit>().fetchMessages();
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Loader(),
              );
            }

            final message = messagesOrdered[i - unsents.length];

            return ChatPageMessageDisplay(
                message: message,
                sentBySelf:
                    message.user.id == context.read<UserCubit>().user.id);
          }),
    );
  }

  Widget _buildError(Failure failure) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              Chats.ERROR_COPY,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        PillButton(
          text: 'retry',
          onClick: () => context.read<ChatCubit>().initalize(),
          icon: Icons.refresh,
        ),
      ],
    ));
  }

  Widget _buildNoChats(Thread thread) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Chats.NO_MESSAGES_COPY,
            if (!thread.isViewOnly) 'Send one to start the conversation!'
          ]
              .map((e) => Text(e, style: Theme.of(context).textTheme.caption))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: Loader());
  }
}
