import 'package:auto_route/auto_route.dart';
import 'package:fe/data/models/group.dart';
import 'package:fe/pages/main/main_service.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/shared_widgets/join_group_button.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service_locator.dart';
import 'bloc/main_page_bloc.dart';
import 'main_helpers/ws_provider.dart';

class MainPage extends StatelessWidget {
  final MainService _mainService = getIt<MainService>();

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WsClient>(
        future: _mainService.getWsClient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoading();
          }

          if (snapshot.hasError) {
            final error = snapshot.error;

            if (error is Failure) {
              handleFailure(error, context);
            } else {
              debugPrint('unhandled error: $error');
              throw error!;
            }
          }

          return BlocBuilder<MainPageBloc, MainPageState>(
              builder: (bcContext, state) {
            if (state is MainPageLoading || state is MainPageInitial) {
              return _buildLoading();
            } else if (state is MainPageLoadFailure) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                handleFailure(state.failure, bcContext);
              });

              return _buildErrorScreen(bcContext);
            } else if (state is MainPageGroupless) {
              return _buildGroupless(snapshot.data!);
            } else if (state is MainPageWithGroup) {
              return _buildContent(snapshot.data!, state.group);
            } else {
              throw 'unreachable state';
            }
          });
        });
  }

  Widget _buildLoading() {
    return Center(
      child: Loader(),
    );
  }

  Widget _buildContent(WsClient wsClient, Group group) {
    return WsProvider(
      wsClient: wsClient,
      child: AutoTabsRouter(
        duration: Duration(seconds: 0),
        routes: [
          ChatRoute(group: group),
          EventsRoute(group: group),
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

  Widget _buildErrorScreen(BuildContext context) {
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
}
