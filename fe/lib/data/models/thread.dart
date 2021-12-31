import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread.freezed.dart';
part 'thread.g.dart';

@freezed
class Thread with _$Thread {
  factory Thread(
      {required String name,
      @CustomUuidConverter() required UuidType id,
      @Default(false) bool isViewOnly}) = _Thread;

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
}
