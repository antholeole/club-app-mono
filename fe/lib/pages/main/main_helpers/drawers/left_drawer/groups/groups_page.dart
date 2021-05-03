import 'package:badges/badges.dart';
import 'package:fe/data_classes/isar/group.dart';
import 'package:fe/data_classes/isar/group_repository.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  final _groupRepository = getIt<GroupRepository>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder<List<Group>>(
        future: _fetchGroups(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Loader();
            case ConnectionState.done:
              return _buildGroups(snapshot.data ?? [], ctx);
            default:
              return _buildError();
          }
        },
      ),
    );
  }

  Future<List<Group>> _fetchGroups() async {
    return _groupRepository.findAll();
  }

  Widget _buildError() {
    return Text("sorry, couldn't load your groups.");
  }

  Widget _buildGroups(List<Group> groups, BuildContext context) {
    final List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Your Clubs',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
      ListView(
        shrinkWrap: true,
        children:
            groups.map((v) => _buildGroupTab(v, true, true, context)).toList(),
      )
    ];

    if (groups.isEmpty) {
      widgets.add(Expanded(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'You have no clubs. Go ahead and join some!',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ))));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }

  Widget _buildGroupTab(
      Group group, bool active, bool notification, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1))),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(backgroundColor: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 4,
                height: 40,
                color: active ? Colors.redAccent.shade100 : Colors.white,
              ),
            ),
            Badge(
              showBadge: notification,
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
                      group.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ))),
          ],
        ),
      ),
    );
  }
}
