import 'package:fe/stdlib/errors/failure_status.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';
part 'failure.g.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  @Implements(Exception)
  const factory Failure(
      {String? customMessage, required FailureStatus status}) = _Failure;

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  String get message => customMessage ?? status.message;
}
