import 'package:fe/data/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsTab<T extends Group> extends StatelessWidget {
  final List<T> _groups;
  final String _noElementsText;
  final String _header;
  final VoidCallback? _onAdd;
  final Widget Function() _buildTab;

  const GroupsTab(
      {Key? key,
      required List<T> groups,
      VoidCallback? onAdd,
      required String noElementsText,
      required String header,
      required Widget Function() buildTab})
      : _groups = groups,
        _noElementsText = noElementsText,
        _onAdd = onAdd,
        _header = header,
        _buildTab = buildTab,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _header,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          if (_onAdd != null)
            GestureDetector(
              onTap: _onAdd!,
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            )
        ],
      ),
      children: _groups.isNotEmpty
          ? _groups
              .map(
                (v) => Provider<T>(
                  create: (_) => v,
                  child: _buildTab(),
                ),
              )
              .toList()
          : [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _noElementsText,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ))
            ],
    );
  }
}
