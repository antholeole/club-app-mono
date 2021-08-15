import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/cubit/thread_cubit.dart';
import 'package:fe/pages/scaffold/view/widgets/channels_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

part 'page_state.dart';

enum AppPage { Chat, Events }

class PageCubit extends Cubit<PageState> {
  ThreadCubit? _threadCubit;

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
    final toThread = await ChannelsBottomSheet.show(context,
        selectedThread: _threadCubit?.state.thread);

    if (toThread != null) {
      emit(PageState.chatPage(toThread: toThread));
    }
  }

  void addThreadCubit(ThreadCubit cubit) {
    _threadCubit = cubit;
  }

  void removeThreadCubit() {
    _threadCubit = null;
  }
}
