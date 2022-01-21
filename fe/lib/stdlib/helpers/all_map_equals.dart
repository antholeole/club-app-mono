bool allMapEquals<T>(Map<dynamic, dynamic> map, T equals) {
  for (final value in map.values) {
    if (value is T && value != equals) {
      return false;
    }

    if (value is Map && !allMapEquals(value, equals)) {
      return false;
    }
  }

  return true;
}
