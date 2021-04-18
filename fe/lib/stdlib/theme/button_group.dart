import 'package:fe/stdlib/theme/loader.dart';
import 'package:flutter/material.dart';

class ButtonData {
  final void Function() onClick;
  final String text;
  final Color color;
  final bool loading;

  const ButtonData(
      {required this.text,
      this.color = Colors.grey,
      required this.onClick,
      this.loading = false});
}

class ButtonGroup extends StatelessWidget {
  final String? _name;
  final List<ButtonData> _buttons;

  const ButtonGroup({String? name, required List<ButtonData> buttons})
      : _name = name,
        _buttons = buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_buildHeader(), ..._buildButtons()],
    );
  }

  List<Widget> _buildButtons() {
    return _buttons
        .map((e) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade200, width: 1))),
              child: TextButton(
                onPressed: e.loading ? () {} : e.onClick,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: e.loading
                      ? Loader(size: 12)
                      : Text(
                          e.text,
                          style: TextStyle(color: e.color),
                        ),
                ),
              ),
            ))
        .toList();
  }

  Widget _buildHeader() {
    if (_name != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
        child: Container(
          width: double.infinity,
          child: Text(
            _name!.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'IBM Plex Mono', color: Colors.grey.shade700),
          ),
        ),
      );
    } else {
      return Container(
        height: 20,
      );
    }
  }
}
