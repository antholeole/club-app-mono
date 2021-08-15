part of 'log_out_cubit.dart';

@immutable
class LogOutState
    extends Union4Impl<LogOutInital, LoggingOut, LoggedOut, LogOutFailure> {
  static const unions =
      Quartet<LogOutInital, LoggingOut, LoggedOut, LogOutFailure>();

  LogOutState._(
      Union4<LogOutInital, LoggingOut, LoggedOut, LogOutFailure> union)
      : super(union);

  factory LogOutState.initial() => LogOutState._(unions.first(LogOutInital()));

  factory LogOutState.loggingOut() =>
      LogOutState._(unions.second(LoggingOut()));

  factory LogOutState.success() => LogOutState._(unions.third(LoggedOut()));

  factory LogOutState.failure(Failure failure) =>
      LogOutState._(unions.fourth(LogOutFailure(failure: failure)));
}

class LogOutInital extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggingOut extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedOut extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogOutFailure extends Equatable {
  final Failure failure;

  const LogOutFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
