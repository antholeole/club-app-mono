import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/channels_bottom_sheet/channels_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

part 'page_state.dart';

enum AppPage { Chat, Events }

class PageCubit extends Cubit<PageState> {
  Thread? currentThread;

  PageCubit() : super(PageState.chatPage());

  void switchTo(AppPage page) {
    switch (page) {
      case AppPage.Chat:
        emit(PageState.chatPage());
        return;
      case AppPage.Events:
        emit(PageState.eventPage());
        return;
    }
  }

  Future<void> bottomSheet(BuildContext context) async {
    final toThread =
        await ChannelsBottomSheet.show(context, selectedThread: currentThread);

    if (toThread != null) {
      emit(PageState.chatPage(toThread: toThread));
    }
  }
}
