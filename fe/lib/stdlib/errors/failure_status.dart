enum FailureStatus {
  GQLMisc,
  GQLRefresh,
  NoConn,
  ServersDown,
  InternalServerError,
  HttpMisc,
  RegexFail,
  Unknown
}

extension FailureStatusMessage on FailureStatus {
  String get message {
    switch (this) {
      case FailureStatus.GQLMisc:
        return 'Unknown GQL Error';
      case FailureStatus.GQLRefresh:
        return 'Failure refreshing tokens';
      case FailureStatus.NoConn:
        return 'Unable to connect to the internet. Please check your connection.';
      case FailureStatus.ServersDown:
        return 'Sorry, unable to connect to our servers. Please try again soon.';
      case FailureStatus.InternalServerError:
        return "Sorry, we had an internal server error. We're working on it!";
      case FailureStatus.HttpMisc:
        return 'Unknown HTTP error';
      case FailureStatus.RegexFail:
        return 'Input validation failed';
      case FailureStatus.Unknown:
        return 'Sorry, unknown error.';
    }
  }
}
