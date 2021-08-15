import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/stdlib/errors/gq_req_or_throw_failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/update_self_name.req.gql.dart';
import 'package:fe/service_locator.dart';
import 'package:ferry/ferry.dart';

part 'name_change_state.dart';

class NameChangeCubit extends Cubit<NameChangeState> {
  final _gqlClient = getIt<Client>();
  final _localUserService = getIt<LocalUserService>();

  NameChangeCubit() : super(NameChangeState.notChanging());

  static final _nameChangeRegex = RegExp(
    r'^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\n]{3,}$',
    caseSensitive: false,
    multiLine: false,
  );

  Future<void> changeName(String newName, void Function() onComplete) async {
    final userId = await _localUserService.getLoggedInUserId();

    if (!_nameChangeRegex.hasMatch(newName)) {
      emit(NameChangeState.failure(const Failure(
          message:
              'Please make sure new name does not contain any special characters and is 3 or more letters.',
          status: FailureStatus.RegexFail)));
      return;
    }

    emit(NameChangeState.changing());

    try {
      await gqlReqOrThrowFailure(
          GUpdateSelfNameReq((b) => b
            ..vars.id = userId
            ..vars.name = newName),
          _gqlClient);
    } on Failure catch (f) {
      emit(NameChangeState.failure(f));
      return;
    }

    await _localUserService.saveChanges(User(name: newName, id: userId));

    emit(NameChangeState.notChanging());
    onComplete();
  }
}
