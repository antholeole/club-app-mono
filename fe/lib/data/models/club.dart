import 'package:equatable/equatable.dart';

import '../../stdlib/helpers/uuid_type.dart';
import 'group.dart';

class Club extends Group implements Equatable {
  final bool admin;

  const Club({required UuidType id, required String name, required this.admin})
      : super(id: id, name: name);

  @override
  List<Object?> get props => [...super.props, admin];
}
