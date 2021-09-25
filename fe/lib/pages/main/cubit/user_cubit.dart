import 'package:bloc/bloc.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import '../../../service_locator.dart';

class UserCubit extends Cubit<User> {
  final _localUserService = getIt<LocalUserService>();

  UserCubit(User initalUser) : super(initalUser);

  Future<void> notifyUpdate() async {
    emit(await _localUserService.getLoggedInUser());
  }

  User get user => state;
}
