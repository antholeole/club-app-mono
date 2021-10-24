import 'package:equatable/equatable.dart';

import '../../stdlib/helpers/uuid_type.dart';
import 'group.dart';

class Club extends Group implements Equatable {
  final bool admin;
  final String? joinToken;

  const Club(
      {required UuidType id,
      required String name,
      required this.admin,
      this.joinToken})
      : super(id: id, name: name);

  @override
  List<Object?> get props => [...super.props, admin, joinToken];
}
