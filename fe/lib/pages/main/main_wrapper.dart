import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/pages/main/main_helpers/drawers/right_drawer/group_drawer.dart';
import 'package:fe/stdlib/errors/handle_failure.dart';
import 'package:fe/stdlib/local_user.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/shared_widgets/join_group_button.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:fe/stdlib/theme/loader.dart';
import 'package:fe/stdlib/theme/pill_button.dart';
import 'package:fe/stdlib/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  MainPageState _pageState = MainPageState.Loading;

  @override
  void initState() {
    _initalLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Toaster(
      context: context,
      child: BlocProvider(
        create: (_) => _mainPageActionsCubit,
        child: Builder(
          builder: (toastableContext) {
            _toastableContext = toastableContext;
            return BlocListener(
              bloc: _mainPageActionsCubit,
              listener: (context, state) {
                if (state is Logout) {
                  _logout(state.withError);
                } else if (state is SelectGroup) {
                  //rebuild with new group
                  setState(() {});
                } else if (state is ResetPage) {
                  _initalLoad();
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
                  actions: _mainPageActionsCubit.state.selectedGroupId != null
                      ? [
                          IconButton(
                            icon: Icon(Icons.group),
                            onPressed: _scaffoldKey.currentState!.openEndDrawer,
                          )
                        ]
                      : [],
                ),
                drawer: ClubDrawer(),
                endDrawer: GroupDrawer(),
                backgroundColor: Colors.white,
                body: Builder(
                  builder: (bContext) {
                    if (bContext
                            .read<MainPageActionsCubit>()
                            .state
                            .selectedGroupId !=
                        null) {
                      return AutoTabsRouter(
                        routes: [
                          EventsRoute(),
                          EventsRoute(),
                        ],
                      );
                    } else if (_pageState == MainPageState.Error) {
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
                            onClick: _initalLoad,
                            icon: Icons.refresh,
                          ),
                        ],
                      ));
                    } else if (_pageState == MainPageState.Loading) {
                      return Container();
                    } else {
                      return Center(
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
                      ));
                    }
                  },
                ),
                bottomNavigationBar: BottomNav(
                    onClickTab: _changeTab,
                    icons: [Icons.chat_bubble_outline, Icons.event]),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _initalLoad() async {
    final initalLoadResult = await _mainService.initalLoad();

    setState(() {
      _pageState = initalLoadResult.state;
    });

    if (initalLoadResult.state == MainPageState.Error) {
      handleFailure(initalLoadResult.failure!, _toastableContext);
    }

    if (initalLoadResult.group != null) {
      _mainPageActionsCubit.selectGroup(initalLoadResult.group!.group.id);
    }
  }

  List<Widget> _buildTitle() {
    final titleElements = <Widget>[];

    if (_mainPageActionsCubit.state.selectedGroupId != null) {
      {
        titleElements.add(Text(
          _mainService
              .getGroup(_mainPageActionsCubit.state.selectedGroupId!)
              .group_name,
          style: Theme.of(context).textTheme.caption,
        ));
      }
    } else if (_pageState == MainPageState.Error) {
      titleElements.add(
          Text('An Error Occured', style: Theme.of(context).textTheme.caption));
    } else if (_pageState == MainPageState.Loading) {
      titleElements.add(Loader(
        size: 18,
      ));
    } else {
      titleElements.add(
          Text('No Club Selected', style: Theme.of(context).textTheme.caption));
    }

    return titleElements;
  }

  void _changeTab(int tab, bool held) {
    if (tab == 0 && held) {
      HapticFeedback.mediumImpact();
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
          .errorToast("Sorry, you've been logged out due to an error.");
    } else {
      Toaster.of(_toastableContext).warningToast('Logged Out.');
    }
  }
}
