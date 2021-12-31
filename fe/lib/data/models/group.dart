import 'package:fe/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../stdlib/helpers/uuid_type.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  Group._();

  factory Group.dm(
      {String? dmName,
      @CustomUuidConverter() required UuidType id,
      required List<User> users}) = Dm;

  factory Group.club(
      {required String name,
      @CustomUuidConverter() required UuidType id,
      required bool admin}) = Club;

  String get name => map(
      dm: (dm) => dm.dmName ?? dm.users.map((e) => e.name).join(' '),
      club: (club) => club.name);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
