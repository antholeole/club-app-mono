import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/shared_widgets/join_group_button.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';
import 'bloc/main_page_bloc.dart';
import 'cubit/main_page_actions_cubit.dart';
import 'main_helpers/ws_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainService _mainService = getIt<MainService>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainPageActionsCubit, MainPageActionsState>(
      listener: (blContext, state) {
        if (state is Logout) {
          _logout(state.withError, blContext);
        }
      },
      child: BlocConsumer<MainPageBloc, MainPageState>(
          listener: (bcContext, state) {
        if (state is MainPageWithGroup) {
          bcContext.read<MainPageActionsCubit>().selectGroup(state.group);
        }
      }, builder: (bcContext, state) {
        if (state is MainPageLoading || state is MainPageInitial) {
          return Center(
            child: Loader(),
          );
        } else if (state is MainPageLoadFailure) {
          handleFailure(state.failure, bcContext);
          return _buildErrorScreen();
        } else if (state is MainPageGroupless) {
          return _buildGroupless(state.wsClient);
        } else if (state is MainPageWithGroup) {
          return _buildContent(state.wsClient);
        } else {
          throw 'unreachable state';
        }
      }),
    );
  }

  Widget _buildContent(WsClient wsClient) {
    return WsProvider(
      wsClient: wsClient,
      child: AutoTabsRouter(
        routes: [
          ChatRoute(),
          EventsRoute(),
        ],
      ),
    );
  }

  Widget _buildGroupless(WsClient wsClient) {
    return WsProvider(
      wsClient: wsClient,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
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
      )),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
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

  Future<void> _logout(bool withError, BuildContext context) async {
    await _mainService.logOut();
    AutoRouter.of(context).popUntilRouteWithName(Main.name);
    await AutoRouter.of(context).popAndPush(LoginRoute());

    if (withError) {
      Toaster.of(context)
          .errorToast("Sorry, you've been logged out due to an error.");
    } else {
      Toaster.of(context).warningToast('Logged Out.');
    }
  }
}
