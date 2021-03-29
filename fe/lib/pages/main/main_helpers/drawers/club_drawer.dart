import 'package:fe/theme/option_pill.dart';
import 'package:flutter/material.dart';

//Need to include a two tab swiper... One to see stuff dependent on view,
//i.e. pins in chat, two to change clubs. NOTE: Change clubs only for now!
//pins and other options in v2
class ClubDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Theme.of(context).primaryColor,
      child: GestureDetector(
        onHorizontalDragEnd: _swiped,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'hi',
                  style: TextStyle(color: Colors.grey, fontSize: 30),
                ),
              ),
              OptionPill(total: 3, current: 0)
            ],
          ),
        ),
      ),
    ));
  }

  void _swiped(DragEndDetails details) {
    if ((details.primaryVelocity ?? 0) > 0) {
      print('right');
    } else {
      print('left');
    }
  }
}
