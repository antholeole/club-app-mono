abstract class DbException implements Exception {}

class DeleteNonexistantError extends DbException {}

class OverrideNonexistantError extends DbException {}

class BadRelationshipInsertError extends DbException {}
