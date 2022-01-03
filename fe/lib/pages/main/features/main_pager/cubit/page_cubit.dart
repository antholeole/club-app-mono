import 'package:bloc/bloc.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/thread.dart';
import 'package:fe/pages/scaffold/features/threads_bottom_sheet/threads_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  Thread? currentThread;
  final Club _club;

  PageCubit({required Club club})
      : _club = club,
        super(const PageState.chat());

  void switchTo(PageState page) {
    emit(page);
  }

  Future<void> bottomSheet(BuildContext context) async {
    final toThread = await ThreadsBottomSheet.show(context,
        selectedThread: currentThread, club: _club);

    if (toThread != null) {
      emit(PageState.chat(toThread));
    }
  }
}
