import 'package:fe/pages/scaffold/main_scaffold.dart';
import 'package:fe/services/fn_providers/group_joiner.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class GrouplessMain extends StatelessWidget {
  static const String GROUPLESS_COPY =
      "Seems like you're not in any clubs... Maybe you should join one?";

  const GrouplessMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              width: 250,
              child: Text(
                GROUPLESS_COPY,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          PillButton(
              text: 'Join Club',
              icon: Icons.add,
              onClick: context.read<GroupJoiner>().showPrompt),
        ],
      )),
    );
  }
}
