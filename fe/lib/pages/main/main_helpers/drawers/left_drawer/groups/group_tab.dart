import 'package:badges/badges.dart';
import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/user.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/pages/main/main_helpers/drawers/left_drawer/groups/groups_service.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/theme/button_group.dart';
import 'package:fe/stdlib/theme/flippable_icon.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupTab extends StatefulWidget {
  final Group group;

  GroupTab({required this.group});

  @override
  _GroupTabState createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab>
    with SingleTickerProviderStateMixin {
  GroupsService _groupsService = getIt<GroupsService>();

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
    return Tile(
        child: Column(
      children: [
        TextButton(
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
                  icon: Icon(Icons.chevron_left, color: Colors.blue, size: 30),
                  onClick: (v) => _displaySettings(!v)),
            ],
          ),
        ),
        if (_tabOpen) _buildSettings(),
      ],
    ));
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

  Widget _buildSettings() {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TileHeader(text: 'Members'),
            FutureBuilder<List<User>>(
                future: _groupsService.fetchUsersInGroup(widget.group.id),
                initialData:
                    _groupsService.getCachedUsersInGroup(widget.group.id),
                builder: (fbContext, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    case ConnectionState.done:
                      return Column(
                          children: snapshot.data!.map((user) {
                        return _buildUserTile(user);
                      }).toList());
                    case ConnectionState.none:
                      return Text('sorry, error');
                  }
                })
          ],
        ));
  }

  Widget _buildUserTile(User user) {
    print('building 1');
    return Tile(child: Text(user.name));
  }
}
