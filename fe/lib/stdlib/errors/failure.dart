import 'package:equatable/equatable.dart';
import 'package:fe/stdlib/errors/failure_status.dart';
import 'package:flutter/foundation.dart';

@immutable
class Failure extends Equatable {
  final String? message;
  final FailureStatus status;

  const Failure({this.message, required this.status});

  @override
  List<Object?> get props => [status, message];
}
