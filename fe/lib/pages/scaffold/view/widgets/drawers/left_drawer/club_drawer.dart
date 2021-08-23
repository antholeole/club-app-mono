import 'package:fe/pages/profile/view/profile_page.dart';
import 'package:fe/stdlib/theme/option_pill.dart';
import 'package:flutter/material.dart';

import '../../../../../groups/view/groups_page.dart';

class ClubDrawer extends StatefulWidget {
  final List<Widget> _pages = [
    const GroupsPage(),
    ProfilePage(),
  ];

  @override
  _ClubDrawerState createState() => _ClubDrawerState();
}

class _ClubDrawerState extends State<ClubDrawer> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.toInt() ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.grey.shade50,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                //onPageChanged: (newPage) => setState(() {
                //  _currentPage = newPage;
                //}),
                children: widget._pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OptionPill(
                  total: widget._pages.length, current: _currentPage),
            )
          ],
        ),
      ),
    ));
  }
}
