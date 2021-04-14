import 'package:fe/pages/main/main_helpers/drawers/left_drawer/profile_page.dart';
import 'package:fe/stdlib/theme/option_pill.dart';
import 'package:flutter/material.dart';

//Need to include a two tab swiper... One to see stuff dependent on view,
//i.e. pins in chat, two to change clubs. NOTE: Change clubs only for now!
//pins and other options in v2
class ClubDrawer extends StatefulWidget {
  final List<Widget> _pages = [
    Container(color: Colors.red),
    ProfilePage(),
    Container(color: Colors.green)
  ];

  @override
  _ClubDrawerState createState() => _ClubDrawerState();
}

class _ClubDrawerState extends State<ClubDrawer> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (newPage) => setState(() {
                  _currentPage = newPage;
                }),
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
