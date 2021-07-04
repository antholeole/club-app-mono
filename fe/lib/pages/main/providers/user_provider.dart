import 'package:fe/data/models/user.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends InheritedWidget {
  final User user;

  const UserProvider({
    required Widget child,
    required this.user,
  }) : super(child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  @override
  bool updateShouldNotify(UserProvider old) => false;
}
