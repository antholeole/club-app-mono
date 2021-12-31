import 'package:bloc/bloc.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/chat/view/widgets/channels_bottom_sheet/channels_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  Thread? currentThread;

  PageCubit() : super(const PageState.chat());

  void switchTo(PageState page) {
    emit(page);
  }

  Future<void> bottomSheet(BuildContext context) async {
    final toThread =
        await ChannelsBottomSheet.show(context, selectedThread: currentThread);

    if (toThread != null) {
      emit(PageState.chat(toThread));
    }
  }
}
