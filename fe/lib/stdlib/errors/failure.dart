import 'package:fe/stdlib/errors/failure_status.dart';

class Failure {
  String message;
  bool resolved;
  final FailureStatus status;

  Failure({required this.message, this.resolved = true, required this.status});
}
