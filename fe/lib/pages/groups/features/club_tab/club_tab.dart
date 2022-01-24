import 'package:badges/badges.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/groups/features/club_tab/update_club_image/club_image.dart';
import 'package:fe/pages/groups/features/club_tab/update_club_image/cubit/club_image_change_cubit.dart';
import 'package:fe/pages/groups/features/club_tab/update_club_image/upate_club_image.dart';
import 'package:fe/pages/groups/features/widgets/selected_tab_indicator.dart';
import 'package:fe/services/local_data/notification_container.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:fe/stdlib/shared_widgets/notification_container_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'club_role_manager/club_role_manager.dart';
import 'club_users/club_users.dart';
import 'leave_club/leave_club_button.dart';

class ClubTab extends StatelessWidget {
  const ClubTab();

  @override
  Widget build(BuildContext context) {
    final club = context.watch<Club>();

    return BlocProvider.value(
      value: ClubImageChangeCubit(clubId: club.id),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(
              top: 12.0, bottom: 12.0, left: 4.0, right: 8.0),
          leading: NotificationContainerListener(
            path: GroupNotificationPath(groupId: club.id),
            builder: (notifs) => Badge(
              showBadge: notifs != null && notifs.isNotEmpty,
              badgeColor: Colors.red,
              position: BadgePosition.topEnd(top: -3, end: -3),
              badgeContent: Container(
                width: 5,
                height: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectedTabIndicator(
                      height: 72,
                      selected: context.watch<Group?>()?.id == club.id),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: GestureDetector(
                      onTap: () => _onTap(context, club),
                      child: const ClubImage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          collapsedIconColor: Colors.grey.shade500,
          title: GestureDetector(
            onTap: () => _onTap(context, club),
            child: AbsorbPointer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GestureDetector(
                  child: Text(club.name,
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          initiallyExpanded: true,
          children: [
            if (context.read<Club>().admin) ...[
              UpdateClubImage(),
              ClubRoleManager(),
            ],
            const ClubUsers(),
            if (!context.read<Club>().admin) LeaveClubButton(),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Club group) =>
      context.read<HydratedSetter<Group>>().set(group);
}
