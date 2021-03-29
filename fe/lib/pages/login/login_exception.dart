class LoginException implements Exception {}

class UserDeniedException implements LoginException {}

class BackendLoginErrorException implements LoginException {}

class NotLoggedInException implements LoginException {}
