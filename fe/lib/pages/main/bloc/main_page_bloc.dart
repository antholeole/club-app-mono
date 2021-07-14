import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_group_preview.data.gql.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:flutter/cupertino.dart';

import '../../../service_locator.dart';
import '../main_service.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final MainService _mainService = getIt<MainService>();

  MainPageBloc({GQuerySelfGroupsPreviewData? data})
      : super(const MainPageInitial()) {
    if (data != null) {
      add(ManualAddDataEvent(data: data));
    } else {
      add(ResetMainPageEvent());
    }
  }

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is ManualAddDataEvent) {
      yield _determineStateFromData(event.data);
    } else if (event is SetGroupEvent) {
      yield MainPageWithGroup(group: event.group);
    } else if (event is ResetMainPageEvent) {
      yield const MainPageLoading();
      try {
        final loadState = await _mainService.querySelfGroups();
        yield _determineStateFromData(loadState);
      } on Failure catch (f) {
        yield MainPageLoadFailure(failure: f);
      }
    }
  }

  MainPageState _determineStateFromData(GQuerySelfGroupsPreviewData data) {
    if (data.user_to_group.isEmpty) {
      return const MainPageGroupless();
    } else {
      final group = Group(
          id: data.user_to_group[0].group.id,
          name: data.user_to_group[0].group.group_name,
          admin: data.user_to_group[0].admin);

      return MainPageWithGroup(group: group);
    }
  }
}
