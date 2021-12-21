import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CheckboxDropdown<T extends Equatable> extends StatelessWidget {
  final List<T> _checkableItems;
  final void Function(List<T>) _onSubmitted;
  final String Function(T) _elementRepr;

  const CheckboxDropdown(
      {Key? key,
      required List<T> checkableItems,
      required String Function(T) elementRepr,
      required void Function(List<T>) onSubmitted})
      : _checkableItems = checkableItems,
        _onSubmitted = onSubmitted,
        _elementRepr = elementRepr,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStateful) {
      final Set<T> checked = {};

      return PopupMenuButton<Iterable<T>>(
        onCanceled: () {
          _onSubmitted(checked.toList());
          checked.clear();
        },
        itemBuilder: (_) => _checkableItems
            .map((e) => PopupMenuItem<List<T>>(
                  onTap: () {},
                  padding: EdgeInsets.zero,
                  value: [],
                  child: StatefulBuilder(
                    builder: (_context, _setState) => CheckboxListTile(
                      value: checked.contains(e),
                      onChanged: (value) => _setState(() => checked.contains(e)
                          ? checked.remove(e)
                          : checked.add(e)),
                      title: Text(
                        _elementRepr(e),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ))
            .toList(),
        icon: const Icon(Icons.add, color: Colors.grey),
      );
    });
  }
}
