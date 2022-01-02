import 'package:fe/data/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ScaffoldTitle extends StatelessWidget {
  final Widget? _titleBarWidget;

  const ScaffoldTitle({Key? key, Widget? titleBarWidget})
      : _titleBarWidget = titleBarWidget,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Group? group = context.watch<Group?>();

    if (group == null) {
      return Text('No group selected',
          style: Theme.of(context).textTheme.caption);
    } else {
      return group.map(
          dm: (dm) => _titleBarWidget!,
          club: (club) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_titleBarWidget != null) _titleBarWidget!,
                  Text(
                    club.name,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ));
    }
  }
}
