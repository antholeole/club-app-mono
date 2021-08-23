import 'package:fe/stdlib/helpers/to_display_datetime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return PM after 12', () {
    expect(toDisplayDateTime(DateTime(2000, 1, 1, 14)), contains('PM'));
  });

  test('should return AM before 12', () {
    expect(toDisplayDateTime(DateTime(2000, 1, 1, 10)), contains('AM'));
  });

  test('should return month in text', () {
    expect(toDisplayDateTime(DateTime(2000, 1, 1, 10)), contains('January'));
    expect(toDisplayDateTime(DateTime(2000, 3, 1, 10)), contains('March'));
  });

  test('should pad minute and hour', () {
    final output = toDisplayDateTime(DateTime(2000, 1, 1, 8, 9));
    expect(output, contains('08'));
    expect(output, contains('09'));
  });
}
