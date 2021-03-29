import 'package:fe/helpers/uuid_type.dart';

UuidType fromGraphQLUuidToDartUuidType(String uuid) => UuidType(uuid);
String fromDartUuidTypeToGraphQLUuid(UuidType uuid) => uuid.uuid;
