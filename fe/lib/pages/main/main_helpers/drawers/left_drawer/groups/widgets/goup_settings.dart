import 'package:fe/gql/remote/query_users_in_group.data.gql.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../config.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../stdlib/helpers/uuid_type.dart';
import '../groups_service.dart';

class GroupSettings extends StatefulWidget {
  final UuidType _groupId;
  final void Function() _didUpdateGroup;

  const GroupSettings(
      {required UuidType groupId, required void Function() didUpdateGroup})
      : _groupId = groupId,
        _didUpdateGroup = didUpdateGroup;

  @override
  _GroupSettingsState createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final GroupsService _groupsService = getIt<GroupsService>();

  late Future<String?> _joinToken;

  bool _isLoadingLeaving = false;
  bool _amAdmin = false;

  @override
  void initState() {
    _groupsService.isAdmin(widget._groupId).then((value) {
      setState(() {
        _amAdmin = true;
      });
      _joinToken = _groupsService.fetchGroupJoinToken(widget._groupId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._buildUsers(),
        if (_amAdmin) ..._buildJoinToken(),
        LoadableTileButton(
          text: 'leave group',
          onClick: () => _groupsService.leaveGroup(
              widget._groupId,
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
      ],
    );
  }

  List<Widget> _buildUsers() {
    return [
      TileHeader(text: 'Members'),
      FutureBuilder<GQueryUsersInGroupData>(
          future: _groupsService.fetchUsersInGroup(widget._groupId),
          initialData: _groupsService.getCachedUsersInGroup(widget._groupId),
          builder: (fbContext, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.done:
                return Column(
                    children: snapshot.data!.user_to_group.map((user) {
                  return _buildUserTile(user);
                }).toList());
              case ConnectionState.none:
                return Text('sorry, error');
            }
          }),
    ];
  }

  Widget _buildUserTile(GQueryUsersInGroupData_user_to_group user) {
    final initals = user.user.name.split(' ').map((e) {
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
            foregroundImage: user.user.profile_picture != null
                ? NetworkImage(user.user.profile_picture!)
                : null,
            child: user.user.profile_picture == null ? Text(initals) : null,
          ),
        ),
        Text(user.user.name)
      ]),
    );
  }

  List<Widget> _buildJoinToken() {
    return [
      TileHeader(
        text: 'Join Token',
      ),
      FutureBuilder<String?>(
          future: _joinToken,
          initialData: _groupsService.getCachedJoinToken(widget._groupId),
          builder: (fbContext, snapshot) {
            if (snapshot.hasError) {
              if (getIt<Config>().debug) {
                throw snapshot.error!;
              }

              return _buildJoinTokenTile(snapshot.error.toString());
            }

            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Loader(
                  size: 12,
                );
              case ConnectionState.done:
                return _buildJoinTokenTile(snapshot.data);
              case ConnectionState.none:
                return _buildJoinTokenTile(null);
            }
          })
    ];
  }

  Widget _buildJoinTokenTile(String? joinToken) {
    return Tile(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(joinToken ?? 'No Join Token.'),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _updateToken(false),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.blue.shade300,
                  ),
                ),
                GestureDetector(
                  onTap: () => _updateToken(true),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.shade300,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _updateToken(bool delete) {
    setState(() {
      _joinToken =
          _groupsService.updateGroupJoinToken(widget._groupId, delete: delete);
    });
    _joinToken.then((_) => widget._didUpdateGroup());
  }
}
