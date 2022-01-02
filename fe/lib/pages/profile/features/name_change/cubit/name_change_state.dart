import 'package:fe/stdlib/errors/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'name_change_state.freezed.dart';

@freezed
class NameChangeState with _$NameChangeState {
  factory NameChangeState.notChanging() = _NotChanging;
  factory NameChangeState.changing() = _Changing;
  factory NameChangeState.failure(Failure failure) = _Failure;
}
