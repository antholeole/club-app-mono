import 'package:auto_route/auto_route.dart';
import 'package:fe/data_classes/json/local_user.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:fe/stdlib/theme/loader.dart';
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
  late BuildContext _toastableContext;
  bool _initalLoadComplete = false;

  @override
  Widget build(BuildContext context) {
    return Toaster(
      context: context,
      child: Builder(
        builder: (toastableContext) {
          _toastableContext = toastableContext;
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
                  } else if (state is SelectGroup) {
                    //rebuild with new group
                    debugPrint(
                        'switched group to ${state.selectedGroup?.name}');
                    setState(() {});
                  }
                },
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    backwardsCompatibility: false,
                    backgroundColor: Color(0xffFBFBFB),
                    foregroundColor: Colors.grey[900],
                    automaticallyImplyLeading: false,
                    title: Column(
                      children: _buildTitle(),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: _scaffoldKey.currentState?.openDrawer,
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: _scaffoldKey.currentState?.openEndDrawer,
                      )
                    ],
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
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _mainService.initalLoad().then((v) => setState(() {
          _initalLoadComplete = true;
        }));
  }

  List<Widget> _buildTitle() {
    final titleElements = <Widget>[];

    const subheaderStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
    );

    if (!_initalLoadComplete) {
      titleElements.add(Loader(
        size: 18,
      ));
    } else if (_initalLoadComplete &&
        _mainPageActionsCubit.state.selectedGroup == null) {
      titleElements.add(Text('No Club Selected', style: subheaderStyle));
    } else {
      titleElements.add(Text(
        _mainPageActionsCubit.state.selectedGroup!.name,
        style: subheaderStyle,
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
      Toaster.of(_toastableContext)
          .errorToast("Sorry you've been logged out due to an error.");
    } else {
      Toaster.of(_toastableContext).warningToast('Logged Out.');
    }
  }
}
