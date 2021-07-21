enum FailureStatus {
  //catastrohic
  NotLoggedIn,
  RefreshFail,

  //no connection
  NoConn,
  ServersDown,

  //log this
  InternalServerError,

  //specific reason (client)
  RegexFail,

  //miscs
  HttpMisc,
  GQLMisc,
  Unknown,
}

extension FailureMessage on FailureStatus {
  String get message {
    switch (this) {
      case FailureStatus.GQLMisc:
        return 'Unknown GQL Error';
      case FailureStatus.RefreshFail:
        return 'Failure refreshing tokens';
      case FailureStatus.NotLoggedIn:
        return 'Failure finding logged in data';
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

  bool get fatal {
    switch (this) {
      case FailureStatus.NotLoggedIn:
      case FailureStatus.RefreshFail:
        return true;
      default:
        return false;
    }
  }
}
