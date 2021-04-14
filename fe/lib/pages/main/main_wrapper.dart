import 'package:auto_route/auto_route.dart';
import 'package:fe/data_classes/local_user.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';
import 'main_helpers/bottom_sheet/channels_bottom_sheet.dart';
import 'main_helpers/drawers/left_drawer/club_drawer.dart';
import 'main_service.dart';

class MainWrapper extends StatefulWidget {
  MainWrapper() : assert(getIt<LocalUser>().isLoggedIn());

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final MainService _mainService = getIt<MainService>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainPageActionsCubit _mainPageActionsCubit = MainPageActionsCubit();
  UuidType? selectedChat;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _mainPageActionsCubit,
          ),
        ],
        child: BlocListener(
          bloc: _mainPageActionsCubit,
          listener: (context, state) {
            if (state is Logout) {
              _logout(state.withError);
            } else if (state is ScaffoldUpdate) {
              //rebuild with new scaffold parts
              setState(() {});
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: _mainPageActionsCubit.state.endDrawer,
            appBar: AppBar(
              backwardsCompatibility: false,
              backgroundColor: Color(0xffFBFBFB),
              foregroundColor: Colors.grey[900],
              automaticallyImplyLeading: false,
              title: Column(
                children: _buildTitle(context),
              ),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: _scaffoldKey.currentState?.openDrawer,
              ),
              actions: _mainPageActionsCubit.state.endDrawer != null
                  ? [
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: _scaffoldKey.currentState?.openEndDrawer,
                      )
                    ]
                  : [],
            ),
            drawer: ClubDrawer(),
            backgroundColor: Colors.white,
            body: AutoTabsRouter(
              routes: [
                EventsRoute(),
                EventsRoute(),
              ],
            ),
            bottomNavigationBar: BottomNav(
                onClickTab: _changeTab,
                icons: [Icons.chat_bubble_outline, Icons.event]),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    //rebuilds so that we can use the scaoffold state in the scaffold.
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
  }

  List<Widget> _buildTitle(BuildContext context) {
    final titleElements = <Widget>[Text('#Defense')];

    if (_mainPageActionsCubit.state.subtitle != null) {
      titleElements.add(Text(
        _mainPageActionsCubit.state.subtitle!,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ));
    }

    return titleElements;
  }

  void _changeTab(int tab) {
    if (tab == 0) {
      showModalBottomSheet(
          context: context, builder: (context) => ChannelsBottomSheet());
    } else {
      AutoRouter.of(context)
          .innerRouterOf<TabsRouter>(Main.name)!
          .setActiveIndex(tab);
    }

    //sideeffect: rebuilds bottomNav with new value
    setState(() {});
  }

  Future<void> _logout(bool withError) async {
    await _mainService.logOut();
    AutoRouter.of(context).popUntilRouteWithName(Main.name);
    await AutoRouter.of(context).popAndPush(LoginRoute());

    if (withError) {
      Toaster.of(context)
          .errorToast("Sorry you've been logged out due to an error.");
    } else {
      Toaster.of(context).warningToast('Logged Out.');
    }
  }
}
