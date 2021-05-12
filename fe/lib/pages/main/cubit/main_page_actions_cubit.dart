import 'package:bloc/bloc.dart';
import 'package:fe/stdlib/database/db_manager.dart';

part 'main_page_actions_state.dart';

class MainPageActionsCubit extends Cubit<MainPageActionsState> {
  MainPageActionsCubit() : super(MainPageActionsInitial());

  void logout({bool withError = false}) => emit(Logout(withError: withError));

  void selectGroup(Group group) => emit(SelectGroup(selectedGroup: group));
}
