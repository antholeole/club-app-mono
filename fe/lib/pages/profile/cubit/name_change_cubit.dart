import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/services/clients/gql_client/gql_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';
import 'package:fe/gql/update_self_name.req.gql.dart';
import 'package:fe/service_locator.dart';

part 'name_change_state.dart';

class NameChangeCubit extends Cubit<NameChangeState> {
  static const String REGEX_FAIL_COPY =
      'Please make sure new name does not contain any special characters and is 3 or more letters.';

  final _gqlClient = getIt<GqlClient>();
  final _localUserService = getIt<LocalUserService>();

  NameChangeCubit() : super(NameChangeState.notChanging());

  static final _nameChangeRegex = RegExp(
    r'^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,\n\[\]]{3,}$',
    caseSensitive: false,
    multiLine: false,
  );

  Future<void> changeName(String newName, VoidCallback onComplete) async {
    emit(NameChangeState.changing());

    final userId = await _localUserService.getLoggedInUserId();

    if (!_nameChangeRegex.hasMatch(newName)) {
      emit(NameChangeState.failure(const Failure(
          message: NameChangeCubit.REGEX_FAIL_COPY,
          status: FailureStatus.RegexFail)));
      return;
    }

    try {
      await _gqlClient.request(GUpdateSelfNameReq((b) => b
        ..vars.id = userId
        ..vars.name = newName));
    } on Failure catch (f) {
      emit(NameChangeState.failure(f));
      return;
    }

    await _localUserService.saveChanges(User(name: newName, id: userId));

    emit(NameChangeState.notChanging());
    onComplete();
  }
}
