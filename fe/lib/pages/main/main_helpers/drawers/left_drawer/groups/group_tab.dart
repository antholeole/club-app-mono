import 'package:badges/badges.dart';
import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupTab extends StatefulWidget {
  final Group group;

  GroupTab({required this.group});

  @override
  _GroupTabState createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1))),
      child: TextButton(
        onPressed: () =>
            context.read<MainPageActionsCubit>().selectGroup(widget.group),
        style: TextButton.styleFrom(backgroundColor: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 4,
                height: 40,
                color: context
                            .read<MainPageActionsCubit>()
                            .state
                            .selectedGroup
                            ?.id ==
                        widget.group.id
                    ? Colors.redAccent.shade100
                    : Colors.transparent,
              ),
            ),
            Badge(
              showBadge: true,
              badgeColor: Colors.red,
              position: BadgePosition.topEnd(top: -3, end: -3),
              badgeContent: Container(
                width: 5,
                height: 5,
              ),
              child: CircleAvatar(
                minRadius: 24,
                maxRadius: 24,
                backgroundColor: Colors.grey,
                foregroundImage:
                    AssetImage('assets/mock_icons/mock_club_icon.png'),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.group.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ))),
            FlippableIcon(
                icon: Icon(Icons.expand), onClick: (clicked) => print(clicked)),
          ],
        ),
      ),
    );
  }
}
