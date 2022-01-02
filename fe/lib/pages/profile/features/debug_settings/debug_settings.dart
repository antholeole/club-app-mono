import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/local_data/token_manager.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../service_locator.dart';

class DebugSettings extends StatelessWidget {
  final _sharedPrefrences = getIt<SharedPreferences>();
  final _handler = getIt<Handler>();
  final _tokenManager = getIt<TokenManager>();

  DebugSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(name: 'debug', buttons: [
      ListTile(
        title: const Text('throw'),
        onTap: () => _handler.reportUnknown(Exception('hi')).then((value) =>
            context
                .read<ToasterCubit>()
                .add(Toast(message: 'se2nd', type: ToastType.Error))),
      ),
      ListTile(
          title: const Text('selfid'),
          onTap: () => print(context.read<UserCubit>().user.id)),
      ListTile(
          title: const Text('a-token'),
          onTap: () => _tokenManager.read().then((t) => print('Bearer $t'))),
      ListTile(
          title: const Text('clear shared pref'),
          onTap: () => _sharedPrefrences.clear().then((value) => context
              .read<ToasterCubit>()
              .add(Toast(
                  message: 'shared pref cleared', type: ToastType.Success))))
    ]);
  }
}
