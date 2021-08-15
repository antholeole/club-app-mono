import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/flows/app_state.dart';
import 'package:fe/pages/chat/view/chat_page.dart';
import 'package:fe/pages/events/events_page.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/view/widgets/join_group_button.dart';
import 'package:fe/pages/scaffold/cubit/channels_bottom_sheet_cubit.dart';
import 'package:fe/pages/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/pages/scaffold/view/main_scaffold.dart';
import 'package:fe/providers/user_provider.dart';
import 'package:fe/services/clients/ws_client/ws_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_locator.dart';
import 'package:flow_builder/flow_builder.dart';

class MainPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  final User _user;

  MainPage({required User user}) : _user = user {
    getIt<WsClient>().initalize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          //main cubits
          BlocProvider(create: (_) => ScaffoldCubit()),
          BlocProvider(create: (_) => PageCubit()),
          BlocProvider(create: (_) => MainCubit()),
          BlocProvider(create: (_) => ChatBottomSheetCubit()),
        ],
        child: UserProvider(
          user: _user,
          child: Builder(
            builder: (_) => MainScaffold(
                child: BlocListener<PageCubit, PageState>(
              listener: (context, state) =>
                  _pageController.jumpToPage(state.index),
              child: BlocConsumer<MainCubit, MainState>(
                listener: (bcContext, state) => state.join(
                    (_) => null,
                    (mplf) =>
                        handleFailure(mplf.failure, bcContext, toast: false),
                    (_) => null,
                    (_) => null,
                    (_) => _logOut(context)),
                builder: (bcContext, state) => state.join(
                    (_) => _buildLoading(),
                    (_) => _buildErrorScreen(bcContext),
                    (_) => _buildGroupless(),
                    (mpwg) => _buildContent(bcContext, mpwg.group),
                    (_) => _buildErrorScreen(bcContext)),
              ),
            )),
          ),
        ));
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
              "Seems like you're not in any clubs... Maybe you should join one?",
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
              'Sorry, there seems to be an error. Retry?',
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
          .add(Toast(message: 'Logged Out.', type: ToastType.Warning));
    }

    context.flow<AppState>().update((_) => AppState.needLogIn());
  }
}
