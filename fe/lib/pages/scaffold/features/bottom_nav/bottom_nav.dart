import 'package:fe/pages/main/features/main_pager/cubit/page_state.dart';
import 'package:fe/pages/main/features/main_pager/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/features/bottom_nav/widgets/bottom_nav_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  static const CHAT_TAB_ICON = Icons.chat_bubble_outline;
  static const EVENT_TAB_ICON = Icons.event;

  const BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.5, top: 7.5),
          child: BlocBuilder<PageCubit, PageState>(builder: (context, state) {
            final selected = state.index;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavTab(
                  icon: CHAT_TAB_ICON,
                  active: selected == 0,
                  onClick: () {
                    if (selected == 0) {
                      context.read<PageCubit>().bottomSheet(context);
                    } else {
                      context
                          .read<PageCubit>()
                          .switchTo(const PageState.chat());
                    }
                  },
                  onHeld: () => context.read<PageCubit>().bottomSheet(context),
                ),
                BottomNavTab(
                  icon: EVENT_TAB_ICON,
                  active: selected == 1,
                  onClick: () => context
                      .read<PageCubit>()
                      .switchTo(const PageState.events()),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
