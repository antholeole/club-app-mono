import 'package:fe/data/models/dm.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/stdlib/theme/tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../selected_tab_indicator.dart';

class DmTab extends StatelessWidget {
  const DmTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dm = context.read<Dm>();

    return GestureDetector(
      onTap: () => _onTap(context, dm),
      child: Tile(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SelectedTabIndicator(
                  height: 36,
                  selected: context.watch<MainCubit>().state.groupId == dm.id),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(dm.name),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Dm dm) =>
      context.read<MainCubit>().setDm(dm);
}
