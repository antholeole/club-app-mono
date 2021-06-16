import 'package:built_collection/built_collection.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_group_join_token.req.gql.dart';
import 'package:fe/gql/query_users_in_group.data.gql.dart';
import 'package:fe/gql/query_users_in_group.req.gql.dart';
import 'package:fe/gql/query_users_in_group.var.gql.dart';
import 'package:fe/stdlib/theme/loadable_tile_button.dart';
import 'package:fe/stdlib/widgets/gql_operation.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:fe/stdlib/theme/tile_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../service_locator.dart';
import '../../../../../../../stdlib/theme/loader.dart';
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
  final Client _client = getIt<Client>();

  late Future<String?> _joinToken;

  bool _isLoadingLeaving = false;
  bool _amAdmin = false;

  @override
  void initState() {
    if (widget._group.admin) {
      _amAdmin = true;
      _joinToken = buildJoinTokenRequest();
    }

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
      ],
    );
  }

  List<Widget> _buildUsers() {
    return [
      TileHeader(text: 'Members'),
      GqlOperation(
          operationRequest: GQueryUsersInGroupReq(
            (b) => b
              ..fetchPolicy = FetchPolicy.NetworkOnly
              ..vars.groupId = widget._group.id,
          ),
          toastErrorPrefix: 'Error loading members',
          onResponse: (GQueryUsersInGroupData data) => Column(
                  children: data.user_to_group.map((user) {
                return _buildUserTile(user);
              }).toList())),
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
          builder: (fbContext, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return _buildJoinTokenTile(snapshot.data);
              case ConnectionState.none:
                return _buildJoinTokenTile(null);
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Loader(size: 12);
            }
          }),
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

  Future<String?> buildJoinTokenRequest() async {
    final req = GQueryGroupJoinTokenReq((q) => q
      ..vars.group_id = widget._group.id
      ..fetchPolicy = FetchPolicy.NetworkOnly);

    final resp = await _client.request(req).first;

    if (resp.data!.group_join_tokens.isEmpty) {
      return null;
    }

    return resp.data!.group_join_tokens.first.join_token;
  }

  void _updateToken(bool delete) {
    setState(() {
      _joinToken =
          _groupsService.updateGroupJoinToken(widget._group.id, delete: delete);
    });
    _joinToken.then((_) => widget._didUpdateGroup());
  }
}
