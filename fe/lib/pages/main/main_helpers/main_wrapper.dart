import 'dart:collection';

import 'package:fe/data_classes/local_user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fe/helper_widgets/router.gr.dart';
import 'package:fe/pages/main/cubit/scaffold_update_cubit.dart';
import 'package:fe/theme/bottom_nav/bottom_nav.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:fe/conn_clients/gql_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet/channels_bottom_sheet.dart';
import 'drawers/club_drawer.dart';

class MainWrapper extends StatefulWidget {
  late final LocalUser _user;
  late final Client _gqlClient;

  //LinkedHashMap to preserve order
  final LinkedHashMap<PageRouteInfo, IconData> _routes = LinkedHashMap.from({
    ChatPageRoute(): Icons.chat_bubble_outline,
    EventsPageRoute(): Icons.event,
  });

  MainWrapper({required LocalUser user}) {
    _user = user;
    _gqlClient = buildGqlClient(user);
  }

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScaffoldUpdateCubit _scaffoldUpdateCubit = ScaffoldUpdateCubit();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scaffoldKeySetup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _scaffoldUpdateCubit,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _scaffoldUpdateCubit.state.endDrawer,
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
          actions: _scaffoldUpdateCubit.state.endDrawer != null
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
        body: MultiProvider(
            providers: [
              Provider<LocalUser>(create: (_) => widget._user),
              Provider<Client>(
                create: (_) => widget._gqlClient,
              )
            ],
            child: AutoTabsRouter(
              routes: widget._routes.keys.toList(),
            )),
        bottomNavigationBar: BottomNav(
          onClickTab: _changeTab,
          icons: widget._routes.values.toList(),
        ),
      ),
    );
  }

  List<Widget> _buildTitle(BuildContext context) {
    final titleElements = <Widget>[Text('#Defense')];

    if (_scaffoldUpdateCubit.state.subtitle != null) {
      titleElements.add(Text(
        _scaffoldUpdateCubit.state.subtitle!,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ));
    }

    return titleElements;
  }

  void _changeTab(int tab) {
    if (widget._routes.entries.elementAt(tab).key.routeName ==
        ChatPageRoute.name) {
      showModalBottomSheet(
          context: context, builder: (context) => ChannelsBottomSheet());
    } else {
      AutoRouter.of(context)
          .innerRouterOf<TabsRouter>(MainWrapperRoute.name)!
          .setActiveIndex(tab);
    }

    //sideeffect: rebuilds bottomNav with new value
    setState(() {});
  }

  void _scaffoldKeySetup() {
    //side effect: menu button gets updated to have scaffold key's real current state
    setState(() {});
  }
}
