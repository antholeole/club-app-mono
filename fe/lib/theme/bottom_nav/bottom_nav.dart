import 'package:auto_route/auto_route.dart';
import 'package:fe/helper_widgets/router.gr.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final List<IconData> _icons;
  final void Function(int) _onClickTab;

  const BottomNav(
      {required List<IconData> icons, required void Function(int) onClickTab})
      : _onClickTab = onClickTab,
        _icons = icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.5, top: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildTabs(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    final tabs = <Widget>[];

    final currentTab = AutoRouter.of(context)
            .innerRouterOf<TabsRouter>(MainWrapperRoute.name)
            ?.activeIndex ??
        0;

    _icons.asMap().forEach((i, element) {
      tabs.add(_buildTab(element, i, context, active: currentTab == i));
    });

    return tabs;
  }

  Widget _buildTab(IconData icon, int index, BuildContext context,
      {bool active = false}) {
    return GestureDetector(
      onTap: () => _onClickTab(index),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
