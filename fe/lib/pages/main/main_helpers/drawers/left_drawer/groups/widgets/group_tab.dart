import 'package:badges/badges.dart';
import 'package:fe/gql/fragments/group.data.gql.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'goup_settings.dart';

class GroupTab extends StatefulWidget {
  final GGroupData group;
  final Function() didUpdateGroups;

  GroupTab({required this.group, required this.didUpdateGroups});

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
        reverseDuration: FLIP_DURATION, vsync: this, duration: FLIP_DURATION);
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () =>
              context.read<MainPageActionsCubit>().selectGroup(widget.group.id),
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
                              .selectedGroupId ==
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
                        widget.group.group_name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ))),
              FlippableIcon(
                  icon: Icon(Icons.chevron_left, color: Colors.blue, size: 30),
                  onClick: (v) => _displaySettings(!v)),
            ],
          ),
        ),
        if (_tabOpen)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Tile(
                child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: GroupSettings(
                  groupId: widget.group.id,
                  didUpdateGroup: widget.didUpdateGroups),
            )),
          ),
      ],
    );
  }

  void _displaySettings(bool display) {
    if (display) {
      expandController.forward();
      setState(() {
        _tabOpen = display;
      });
    } else {
      expandController.reverse().then((value) {
        setState(() {
          _tabOpen = display;
        });
      });
    }
  }
}
