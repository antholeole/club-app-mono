import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:meta/meta.dart';

import '../../../service_locator.dart';
import '../main_service.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final MainService _mainService = getIt<MainService>();

  MainPageBloc() : super(MainPageInitial());

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is SetGroupEvent) {
      yield MainPageWithGroup(group: event.group);
    } else if (event is ResetMainPageEvent) {
      yield MainPageLoading();
      try {
        final loadState = await _mainService.querySelfGroups();

        if (loadState!.user_to_group.isEmpty) {
          yield MainPageGroupless();
        } else {
          yield MainPageWithGroup(
              group: Group(
                  id: loadState.user_to_group[0].group.id,
                  name: loadState.user_to_group[0].group.group_name,
                  admin: loadState.user_to_group[0].admin));
        }
      } on Failure catch (f) {
        yield MainPageLoadFailure(failure: f);
      }
    }
  }
}
