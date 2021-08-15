import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:meta/meta.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

import '../../../service_locator.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final LocalUserService _localUserService = getIt<LocalUserService>();

  LogOutCubit() : super(LogOutState.initial());

  void logOut() async {
    emit(LogOutState.loggingOut());

    await _localUserService.logOut();

    emit(LogOutState.success());
  }
}
