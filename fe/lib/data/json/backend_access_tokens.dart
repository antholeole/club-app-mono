import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'backend_access_tokens.freezed.dart';
part 'backend_access_tokens.g.dart';

@freezed
class BackendAccessTokens with _$BackendAccessTokens {
  factory BackendAccessTokens(
      {required String accessToken,
      required String refreshToken,
      required String name,
      @CustomUuidConverter() required UuidType id}) = _BackendAccessTokens;

  factory BackendAccessTokens.fromJson(Map<String, dynamic> json) =>
      _$BackendAccessTokensFromJson(json);
}
