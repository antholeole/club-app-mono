import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:built_value/serializer.dart';

class UuidType {
  late String _uuid;

  UuidType(String uuid) {
    assert(_assertUuidIsValid(uuid));
    _uuid = uuid;
  }

  String get uuid => _uuid;

  static bool _assertUuidIsValid(String uuid) {
    try {
      Uuid.parse(uuid);
      return true;
    } on FormatException catch (_) {
      return false;
    }
  }

  @override
  bool operator ==(covariant UuidType other) => other.uuid == uuid;
}

class CustomUuidConverter implements JsonConverter<UuidType, String> {
  const CustomUuidConverter();

  @override
  UuidType fromJson(String json) {
    return UuidType(json);
  }

  @override
  String toJson(UuidType json) => json.uuid;
}

class UuidTypeSerializer implements PrimitiveSerializer<UuidType> {
  @override
  UuidType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    assert(serialized is String,
        "UuidTypeSerializer expected 'String' but got ${serialized.runtimeType}");
    return UuidType(serialized as String);
  }

  @override
  Object serialize(
    Serializers serializers,
    UuidType uuidType, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      uuidType.uuid;

  @override
  Iterable<Type> get types => [UuidType];

  @override
  String get wireName => 'uuid';
}
