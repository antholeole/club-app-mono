import 'package:bloc/bloc.dart';

import '../../../stdlib/helpers/uuid_type.dart';

part 'main_page_actions_state.dart';

class MainPageActionsCubit extends Cubit<MainPageActionsState> {
  MainPageActionsCubit() : super(MainPageActionsInitial());

  void logout({bool withError = false}) => emit(Logout(withError: withError));

  void selectGroup(UuidType groupId) =>
      emit(SelectGroup(selectedGroupId: groupId));

  void resetPage() => emit(ResetPage());
}
