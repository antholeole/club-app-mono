import 'package:badges/badges.dart';
import 'package:fe/data/models/club.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/selected_tab_indicator.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'club_settings.dart';

class ClubTab extends StatelessWidget {
  const ClubTab();

  @override
  Widget build(BuildContext context) {
    final club = context.watch<Club>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(
            top: 12.0, bottom: 12.0, left: 4.0, right: 8.0),
        leading: Badge(
          showBadge: true,
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
                  selected:
                      context.watch<MainCubit>().state.groupId == club.id),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: GestureDetector(
                  onTap: () => _onTap(context, club),
                  child: const CircleAvatar(
                    minRadius: 24,
                    maxRadius: 24,
                    backgroundColor: Colors.grey,
                    foregroundImage:
                        AssetImage('assets/mock_icons/mock_club_icon.png'),
                  ),
                ),
              ),
            ],
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
        initiallyExpanded: false,
        children: [const GroupSettings()],
      ),
    );
  }

  void _onTap(BuildContext context, Club group) =>
      context.read<MainCubit>().setClub(group);
}
