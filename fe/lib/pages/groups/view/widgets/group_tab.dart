import 'package:badges/badges.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/cubit/update_groups_cubit.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_settings.dart';

class GroupTab extends StatefulWidget {
  final GroupsPageGroup group;

  const GroupTab({required this.group});

  @override
  _GroupTabState createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab>
    with SingleTickerProviderStateMixin {
  bool _tabOpen = false;

  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    _prepareAnimations();
    super.initState();
  }

  void _prepareAnimations() {
    expandController = AnimationController(
        reverseDuration: FlippableIcon.FLIP_DURATION,
        vsync: this,
        duration: FlippableIcon.FLIP_DURATION);
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        Group? selectedGroup = state.group;

        return Column(
          children: [
            TextButton(
              onPressed: () =>
                  context.read<MainCubit>().setGroup(widget.group.group),
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 4,
                      height: 40,
                      color: selectedGroup != null &&
                              selectedGroup.id == widget.group.group.id
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
                    child: const CircleAvatar(
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
                            widget.group.group.name,
                            style: Theme.of(context).textTheme.bodyText2,
                          ))),
                  FlippableIcon(
                    icon: const Icon(Icons.chevron_left,
                        color: Colors.blue, size: 30),
                    onClick: () {
                      setState(() {
                        _tabOpen = !_tabOpen;
                      });
                      _displaySettings();
                    },
                    flipped: _tabOpen,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Tile(
                  child: SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: animation,
                child: GroupSettings(group: widget.group),
              )),
            ),
          ],
        );
      },
    );
  }

  void _displaySettings() {
    if (_tabOpen) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }
}
