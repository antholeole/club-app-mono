abstract class IsarException implements Exception {}

class DeleteNonexistantError extends IsarException {}

class OverrideNonexistantError extends IsarException {}
