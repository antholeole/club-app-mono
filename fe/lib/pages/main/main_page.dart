import 'package:fe/data/models/group.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/pages/chat/chat_page.dart';
import 'package:fe/pages/chat/cubit/bottom_sheet_open_cubit.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/events/events_page.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/pages/main/providers/user_provider.dart';
import 'package:fe/pages/splash/spash_helpers/spash_page.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/shared_widgets/join_group_button.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service_locator.dart';
import 'bloc/main_page_bloc.dart';
import 'main_helpers/scaffold/cubit/page_cubit.dart';
import 'main_helpers/scaffold/cubit/scaffold_cubit.dart';
import 'main_helpers/scaffold/main_scaffold.dart';
import 'main_helpers/ws/ws_provider.dart';

class MainPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);
  final MainService _mainService = getIt<MainService>();

  @override
  Widget build(BuildContext context) {
    return WsProvider(
        wsClient: WsClient(),
        child: MultiBlocProvider(
            providers: [
              //chat cubits
              BlocProvider(create: (_) => ChatCubit()),
              BlocProvider(create: (_) => ChatBottomSheetCubit()),

              //main cubits
              BlocProvider(create: (_) => ScaffoldCubit()),
              BlocProvider(create: (_) => PageCubit()),
              BlocProvider(create: (_) => MainPageBloc())
            ],
            child: FutureBuilder<User>(
                future: _mainService.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SplashPage();
                  }
                  return UserProvider(
                    user: snapshot.data!,
                    child: Builder(
                      builder: (_) => MainScaffold(
                          child: BlocListener<PageCubit, PageState>(
                        listener: (context, state) =>
                            _pageController.jumpToPage(state.currentPage),
                        child: BlocBuilder<MainPageBloc, MainPageState>(
                            builder: (bcContext, state) {
                          if (state is MainPageLoading ||
                              state is MainPageInitial) {
                            return _buildLoading();
                          } else if (state is MainPageLoadFailure) {
                            handleFailure(state.failure, bcContext,
                                toast: false);
                            return _buildErrorScreen(bcContext);
                          } else if (state is MainPageGroupless) {
                            return _buildGroupless();
                          } else if (state is MainPageWithGroup) {
                            return _buildContent(state.group, bcContext);
                          } else {
                            throw 'unreachable state';
                          }
                        }),
                      )),
                    ),
                  );
                })));
  }

  Widget _buildLoading() {
    return const Center(
      child: Loader(),
    );
  }

  Widget _buildContent(Group group, BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [ChatPage(group: group), EventsPage(group: group)],
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
          onClick: () => context.read<MainPageBloc>().add(ResetMainPageEvent()),
          icon: Icons.refresh,
        ),
      ],
    ));
  }
}
