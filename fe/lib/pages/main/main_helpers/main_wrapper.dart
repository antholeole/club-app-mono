import 'dart:collection';

import 'package:fe/data_classes/local_user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/main/cubit/hive_cubit.dart';
import 'package:fe/pages/main/cubit/scaffold_update_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:fe/stdlib/theme/logo.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'bottom_sheet/channels_bottom_sheet.dart';
import 'drawers/club_drawer.dart';

class MainWrapper extends StatefulWidget {
  late final LocalUser _user;
  late final Client _gqlClient;

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
  late final HiveCubit _hiveCubit = HiveCubit();
  UuidType? selectedChat;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scaffoldKeySetup());
    Hive.openBox('main').then(_hiveCubit.addBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _scaffoldUpdateCubit,
        ),
        BlocProvider(
          create: (_) => _hiveCubit,
        ),
      ],
      child: BlocBuilder<HiveCubit, HiveState>(
        builder: (context, state) {
          if (state is HiveInitial) {
            return Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Center(child: Logo()));
          } else {
            return Scaffold(
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
                    routes: [
                      EventsRoute(), //ChatRoute(chat: selectedChat!)
                      EventsRoute(),
                    ],
                  )),
              bottomNavigationBar: BottomNav(
                  onClickTab: _changeTab,
                  icons: [Icons.chat_bubble_outline, Icons.event]),
            );
          }
        },
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

  void _scaffoldKeySetup() {
    //side effect: menu button gets updated to have scaffold key's real current state
    setState(() {});
  }
}
