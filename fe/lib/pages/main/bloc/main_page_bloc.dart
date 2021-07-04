import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          final group = Group(
              id: loadState.user_to_group[0].group.id,
              name: loadState.user_to_group[0].group.group_name,
              admin: loadState.user_to_group[0].admin);

          yield MainPageWithGroup(group: group);
        }
      } on Failure catch (f) {
        yield MainPageLoadFailure(failure: f);
      }
    }
  }
}
