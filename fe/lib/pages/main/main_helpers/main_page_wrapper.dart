import 'package:fe/pages/chat/cubit/bottom_sheet_open_cubit.dart';
import 'package:fe/pages/chat/cubit/chat_cubit.dart';
import 'package:fe/pages/main/bloc/main_page_bloc.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/page_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/cubit/scaffold_cubit.dart';
import 'package:fe/pages/main/main_helpers/scaffold/main_scaffold.dart';
import 'package:fe/pages/main/main_page.dart';
import 'package:fe/pages/main/providers/user_provider.dart';
import 'package:fe/pages/main/providers/ws_provider.dart';
import 'package:fe/stdlib/errors/failure.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';
import '../main_service.dart';

//sole purpose of this widget is to allow mainPAge
//to access MainPageProvider stuff through context (refresh build context)
//makes everything a lot cleaner down there.
class MainPageWrapper extends StatefulWidget {
  const MainPageWrapper();

  @override
  _MainPageWrapperState createState() => _MainPageWrapperState();
}

class _MainPageWrapperState extends State<MainPageWrapper> {
  final _mainService = getIt<MainService>();
  late Future<InitalLoadCarrier> _initalLoadFuture;

  @override
  void initState() {
    _initalLoadFuture = _mainService.initalLoad();
    _mainService.querySelfGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InitalLoadCarrier>(
        future: _initalLoadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                color: Colors.white, child: Center(child: Loader()));
          }

          if (snapshot.hasError) {
            if (snapshot.error is Failure) {
              handleFailure(snapshot.error as Failure, context);
              _buildErrorScreen();
            }
          }

          return WsProvider(
              wsClient: snapshot.data!.wsClient,
              child: UserProvider(
                user: snapshot.data!.localUser,
                child: MultiBlocProvider(
                  providers: [
                    //chat cubits
                    BlocProvider(create: (_) => ChatCubit()),
                    BlocProvider(create: (_) => ChatBottomSheetCubit()),

                    //main cubits
                    BlocProvider(create: (_) => ScaffoldCubit()),
                    BlocProvider(create: (_) => PageCubit()),
                    BlocProvider(
                        create: (_) => MainPageBloc(
                            data: snapshot.data!.selfGroupsPreviewData))
                  ],
                  child:
                      Builder(builder: (_) => MainScaffold(child: MainPage())),
                ),
              ));
        });
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      body: Center(
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
            onClick: () => setState(() {
              _initalLoadFuture = _mainService.initalLoad();
            }),
            icon: Icons.refresh,
          ),
        ],
      )),
    );
  }
}
