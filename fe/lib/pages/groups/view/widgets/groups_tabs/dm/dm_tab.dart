import 'package:fe/data/models/group.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
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
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SelectedTabIndicator(
                  height: 36, selected: context.watch<Group?>()?.id == dm.id),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  dm.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Dm dm) =>
      context.read<HydratedSetter<Group>>().set(dm);
}
