import 'package:fe/pages/profile/features/name_change/widgets/name_change_dialog.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';

class NameChangeButton extends StatelessWidget {
  static const CHANGE_NAME_COPY = 'Change Name';

  final bool _loading;

  const NameChangeButton({Key? key, required bool loading})
      : _loading = loading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showModalBottomSheet(
          builder: (context) => NameChangeDialog(), context: context),
      title: _loading
          ? const Loader(
              size: 12,
            )
          : const Text(CHANGE_NAME_COPY),
    );
  }
}
