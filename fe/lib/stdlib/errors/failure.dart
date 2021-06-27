import 'package:fe/stdlib/errors/failure_status.dart';

class Failure {
  bool resolved;
  final String? message;
  final FailureStatus status;

  Failure({this.message, this.resolved = true, required this.status});
}
