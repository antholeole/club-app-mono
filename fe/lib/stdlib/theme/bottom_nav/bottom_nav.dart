import 'package:fe/pages/main/main_helpers/scaffold/cubit/page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final List<IconData> _icons;
  final void Function(int, bool) _onClickTab;

  const BottomNav(
      {required List<IconData> icons,
      required void Function(int, bool) onClickTab})
      : _onClickTab = onClickTab,
        _icons = icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.5, top: 7.5),
          child: BlocBuilder<PageCubit, PageState>(
            builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildTabs(context, state.currentPage),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context, int currentTab) {
    final tabs = <Widget>[];

    _icons.asMap().forEach((i, element) {
      tabs.add(_buildTab(element, i, context, active: currentTab == i));
    });

    return tabs;
  }

  Widget _buildTab(IconData icon, int index, BuildContext context,
      {bool active = false}) {
    return GestureDetector(
      onTap: () => _onClickTab(index, false),
      onLongPress: () => _onClickTab(index, true),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(
              icon,
              size: 40,
              color: active ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
          Container(
            width: 35,
            height: 4,
            decoration: BoxDecoration(
                color: active
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
