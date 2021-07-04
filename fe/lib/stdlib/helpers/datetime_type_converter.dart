import 'package:built_value/serializer.dart';

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    assert(serialized is String,
        "Timestamptz expected 'String' but got ${serialized.runtimeType}");

    return DateTime.parse(serialized as String);
  }

  @override
  String serialize(
    Serializers serializers,
    DateTime datetime, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return datetime.toIso8601String();
  }

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => 'uuid';
}
