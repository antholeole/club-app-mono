import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/chat/view/chat_page.dart';
import 'package:fe/pages/events/events_page.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/pages/main/view/widgets/group_joiner.dart';
import 'package:fe/pages/main/view/widgets/join_group_button.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/pages/scaffold/view/main_scaffold.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handler.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_locator.dart';
import 'package:flow_builder/flow_builder.dart';

class MainPage extends StatelessWidget {
  final User _user;

  const MainPage({required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScaffoldCubit()),
        BlocProvider(create: (_) => PageCubit()),
        BlocProvider(create: (_) => MainCubit()),
        BlocProvider(create: (_) => ChatBottomSheetCubit()),
        BlocProvider(create: (_) => UserCubit(_user)),
      ],
      child: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  static const String RETRY_COPY = 'Sorry, there seems to be an error. Retry?';
  static const String GROUPLESS_COPY =
      "Seems like you're not in any clubs... Maybe you should join one?";
  static const String LOGOUT_COPY = 'Logged Out.';

  final _handler = getIt<Handler>();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GroupJoinDisplay(
      child: MainScaffold(
          child: BlocListener<PageCubit, PageState>(
        listener: (context, state) => _pageController.jumpToPage(state.index),
        child: BlocConsumer<MainCubit, MainState>(
          listener: (bcContext, state) {
            state.join(
                (_) => null,
                (mplf) => _handler.handleFailure(mplf.failure, bcContext,
                    toast: false),
                (_) => null,
                (_) => null,
                (mplo) => _logOut(context, withError: mplo.withError),
                (_) => null);
          },
          builder: (bcContext, state) => state.join(
              (_) => _buildLoading(),
              (_) => _buildErrorScreen(bcContext),
              (_) => _buildGroupless(),
              (mpwg) => _buildContent(bcContext, mpwg.club),
              (_) => _buildErrorScreen(bcContext),
              (mpwdm) => _buildContent(bcContext, mpwdm.dm)),
        ),
      )),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Loader(),
    );
  }

  Widget _buildContent(BuildContext context, Group group) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [ChatPage(group: group), const EventsPage()],
    );
  }

  Widget _buildGroupless() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              MainView.GROUPLESS_COPY,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        JoinGroupButton(),
      ],
    ));
  }

  Widget _buildErrorScreen(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 250,
            child: Text(
              MainView.RETRY_COPY,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        PillButton(
          text: 'retry',
          onClick: () => context.read<MainCubit>().initalizeMainPage(),
          icon: Icons.refresh,
        ),
      ],
    ));
  }

  void _logOut(BuildContext context, {String? withError}) {
    if (withError != null) {
      context.read<ToasterCubit>().add(Toast(
          message: "Sorry, you've been logged out due to an error: $withError",
          type: ToastType.Error));
    } else {
      context
          .read<ToasterCubit>()
          .add(Toast(message: MainView.LOGOUT_COPY, type: ToastType.Warning));
    }

    context.flow<AppState>().update((_) => AppState.needLogIn());
  }
}
