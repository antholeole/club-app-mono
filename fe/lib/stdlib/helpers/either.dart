class Either<F, S> {
  F? _first;
  S? _second;

  Either._({F? first, S? second})
      : _first = first,
        _second = second;

  factory Either.first(F val) => Either._(first: val);
  factory Either.second(S val) => Either._(second: val);

  T when<T>({required T Function(F) first, required T Function(S) second}) {
    if (_first != null) {
      return first(_first!);
    }

    return second(_second!);
  }
}

class EitherMap<T> {
  final Map<String, Either<T, EitherMap<T>>> _val;

  EitherMap(Map<String, Either<T, EitherMap<T>>> val) : _val = Map.from(val);

  Iterable<MapEntry<String, Either<T, EitherMap<T>>>> get entries =>
      _val.entries;

  bool containsKey(String key) => _val.containsKey(key);

  void add(String key, Either<T, EitherMap<T>> val) {
    _val[key] = val;
  }

  Either<T, EitherMap<T>>? get(String key) {
    return _val[key];
  }
}

class IncorrectEitherMapTypeTraversal implements Exception {
  final String _message;

  const IncorrectEitherMapTypeTraversal(String key, Type got, Type expected)
      : _message =
            'incorrect type during either map traversal; at key $key, expected $expected, but got $got';

  @override
  String toString() => 'IncorrectEitherMapTypeTraversal: $_message';
}
