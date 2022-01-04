import 'dart:typed_data';

import 'package:fe/data/models/reaction.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message.text({
    required User user,
    @CustomUuidConverter() required UuidType id,
    required DateTime createdAt,
    required String text,
    required DateTime updatedAt,
    @Default({}) Map<UuidType, Reaction> reactions,
  }) = _Text;

  const factory Message.image({
    required User user,
    @CustomUuidConverter() required UuidType id,
    required DateTime createdAt,
    required UuidType sourceId,
    Uint8List? imageData,
    required DateTime updatedAt,
    @Default({}) Map<UuidType, Reaction> reactions,
  }) = _Image;
}
