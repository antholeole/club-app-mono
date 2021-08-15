import 'package:fe/data/models/user.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/local_data/local_user_service.dart';
import 'package:flutter/widgets.dart';

class _UserProvider extends InheritedWidget {
  final UserProviderState data;

  const _UserProvider({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class UserProvider extends StatefulWidget {
  final Widget child;
  final User user;

  const UserProvider({
    required this.child,
    required this.user,
  });

  static UserProviderState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_UserProvider>()
            as _UserProvider)
        .data;
  }

  @override
  UserProviderState createState() => UserProviderState(
        user,
      );
}

class UserProviderState extends State<UserProvider> {
  final _localUserService = getIt<LocalUserService>();

  User user;

  UserProviderState(this.user);

  Future<void> notifyUpdate() async {
    final newUser = await _localUserService.getLoggedInUser();
    setState(() {
      user = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _UserProvider(
      data: this,
      child: widget.child,
    );
  }
}
