import 'package:fe/data_classes/local_user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fe/pages/main/cubit/main_page_actions_cubit.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';
import 'package:fe/stdlib/router/router.gr.dart';
import 'package:fe/stdlib/theme/bottom_nav/bottom_nav.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:fe/stdlib/clients/gql_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../service_locator.dart';
import 'main_helpers/bottom_sheet/channels_bottom_sheet.dart';
import 'main_helpers/drawers/club_drawer.dart';

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
  final MainPageActionsCubit _mainPageActionsCubit = MainPageActionsCubit();
  final LocalFileStore _localFileStore = getIt<LocalFileStore>();
  UuidType? selectedChat;

  @override
  void initState() {
    super.initState();
  }

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
              _logout();
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
            body: MultiProvider(
                providers: [
                  Provider<LocalUser>(create: (_) => widget._user),
                  Provider<Client>(
                    create: (_) => widget._gqlClient,
                  )
                ],
                child: AutoTabsRouter(
                  routes: [
                    EventsRoute(),
                    EventsRoute(),
                  ],
                )),
            bottomNavigationBar: BottomNav(
                onClickTab: _changeTab,
                icons: [Icons.chat_bubble_outline, Icons.event]),
          ),
        ));
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

  Future<void> _logout() async {
    await Future.wait([_localFileStore.clear(), widget._user.logOut()]);
    await AutoRouter.of(context).navigate(LoginRoute());
  }
}
