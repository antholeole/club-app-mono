import 'package:fe/pages/chat/chat_page.dart';
import 'package:fe/pages/events/events_page.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_cubit.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPager extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  MainPager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PageCubit, PageState>(
      listener: (context, state) => _pageController.jumpToPage(state.index),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [const ChatPage(), const EventsPage()],
      ),
    );
  }
}
