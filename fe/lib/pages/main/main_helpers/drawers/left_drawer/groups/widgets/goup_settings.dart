import 'package:fe/stdlib/database/db_manager.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../service_locator.dart';
import '../groups_service.dart';

class GroupSettings extends StatefulWidget {
  final Group _group;
  final void Function() _didUpdateGroup;

  const GroupSettings(
      {required Group group, required void Function() didUpdateGroup})
      : _group = group,
        _didUpdateGroup = didUpdateGroup;

  @override
  _GroupSettingsState createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final GroupsService _groupsService = getIt<GroupsService>();

  bool _isLoadingLeaving = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._buildUsers(),
        if (widget._group.isAdmin) ..._buildJoinToken(),
      ],
    );
  }

  List<Widget> _buildUsers() {
    return [
      TileHeader(text: 'Members'),
      FutureBuilder<Iterable<User>>(
          future: _groupsService.fetchUsersInGroup(widget._group.id),
          initialData: _groupsService.getCachedUsersInGroup(widget._group.id),
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
          }),
      LoadableTileButton(
        text: 'leave group',
        onClick: () => _groupsService.leaveGroup(
            widget._group,
            context,
            () => setState(() {
                  _isLoadingLeaving = true;
                }), () {
          setState(() {
            _isLoadingLeaving = false;
          });
          widget._didUpdateGroup();
        }),
        color: Colors.red,
        loading: _isLoadingLeaving,
      ),
    ];
  }

  Widget _buildUserTile(User user) {
    final initals = user.name.split(' ').map((e) {
      if (e.isNotEmpty) {
        return e[0];
      } else {
        return '';
      }
    }).join('');

    return Tile(
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            foregroundImage: user.profilePicture != null
                ? NetworkImage(user.profilePicture!)
                : null,
            child: user.profilePicture == null ? Text(initals) : null,
          ),
        ),
        Text(user.name)
      ]),
    );
  }

  List<Widget> _buildJoinToken() {
    return [
      TileHeader(
        text: 'Join Token',
      ),
      FutureBuilder<String?>(
          future: _groupsService.updateGroupJoinToken(widget._group.id),
          builder: (fbContext, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Loader();
              case ConnectionState.done:
                return Text("hi");
              case ConnectionState.none:
                return Text('error loading build token.');
            }
          })
    ];
  }
}
