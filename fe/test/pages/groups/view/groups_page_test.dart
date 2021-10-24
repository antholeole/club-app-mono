import 'package:fe/data/models/club.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:fe/pages/groups/view/groups_page.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/club/club_tab.dart';
import 'package:fe/pages/groups/view/widgets/groups_tabs/dm/dm_tab.dart';
import 'package:fe/pages/main/cubit/main_cubit.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/service_locator.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/fixtures/mocks.dart';
import '../../../test_helpers/get_it_helpers.dart';
import '../../../test_helpers/pump_app.dart';
import '../../../test_helpers/stub_bloc_stream.dart';
import '../../../test_helpers/stub_gql_response.dart';

void main() {
  const resp = {
    'admin_clubs': [
      {
        'group': {
          'group_name': 'Sports Ball Team',
          'id': 'b454d579-c4d2-403c-95cd-ac8dbc97476a',
          'group_join_tokens': [
            {'join_token': 'soKVRwlKA4'}
          ]
        }
      }
    ],
    'member_clubs': [
      {
        'group': {
          'group_name': 'ISU D&D Club',
          'id': '56610d26-d62d-4628-8c08-eabf7ab7e8ad'
        }
      }
    ],
    'dms': [
      {
        'thread': {
          'name': null,
          'id': '0e18b5f2-5f27-44b8-9840-2aaf3f01aa52',
          'user_to_threads': [
            {
              'user': {
                'id': '04c9b164-8535-4ae0-a091-9681a425b935',
                'name': 'Anthony Oleinik',
                'profile_picture': null
              }
            },
            {
              'user': {
                'id': 'd3ac2f6b-e56f-47d2-9121-c5444b959a3f',
                'name': 'Brit B',
                'profile_picture': null
              }
            }
          ]
        }
      },
      {
        'thread': {
          'name': null,
          'id': '23b5b652-dd69-43c2-9790-8b877203a463',
          'user_to_threads': [
            {
              'user': {
                'id': '04c9b164-8535-4ae0-a091-9681a425b935',
                'name': 'Anthony Oleinik',
                'profile_picture': null
              }
            },
            {
              'user': {
                'id': 'a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f',
                'name': 'Charles Xavier',
                'profile_picture': null
              }
            },
            {
              'user': {
                'id': 'd3ac2f6b-e56f-47d2-9121-c5444b959a3f',
                'name': 'Brit B',
                'profile_picture': null
              }
            }
          ]
        }
      },
      {
        'thread': {
          'name': null,
          'id': 'dc602f4d-9a34-491b-af4f-82acdc017e78',
          'user_to_threads': [
            {
              'user': {
                'id': 'a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f',
                'name': 'Charles Xavier',
                'profile_picture': null
              }
            },
            {
              'user': {
                'id': '04c9b164-8535-4ae0-a091-9681a425b935',
                'name': 'Anthony Oleinik',
                'profile_picture': null
              }
            }
          ]
        }
      },
      {
        'thread': {
          'name': null,
          'id': 'b4ca3a92-963b-4605-9b7b-494890802812',
          'user_to_threads': [
            {
              'user': {
                'id': '4aff9671-edc3-410e-843e-647203def97d',
                'name': 'Midget',
                'profile_picture': null
              }
            },
            {
              'user': {
                'id': '04c9b164-8535-4ae0-a091-9681a425b935',
                'name': 'Anthony Oleinik',
                'profile_picture': null
              }
            }
          ]
        }
      }
    ]
  };

  final respAsObj = GQuerySelfGroupsData.fromJson(resp)!;

  final User fakeUser = User(id: UuidType.generate(), name: 'asdasd');
  final MainCubit mockMainCubit = MockMainCubit.getMock();

  setUp(() {
    registerAllMockServices();

    stubBlocStream<MainState>(mockMainCubit,
        initialState: MainState.withClub(
            Club(admin: false, id: UuidType.generate(), name: 'asdasd')));
  });

  Widget build({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(create: (_) => mockMainCubit),
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(fakeUser),
        ),
      ],
      child: child,
    );
  }

  group('groups page', () {
    testWidgets('should render groupsView', (tester) async {
      stubGqlResponse(getIt<AuthGqlClient>(), data: (_) => respAsObj);

      await tester.pumpApp(build(child: const GroupsPage()));

      expect(find.byType(GroupsView), findsOneWidget);
    });
  });

  group('groups view', () {
    testWidgets('should display group + dm for every group + dm',
        (tester) async {
      stubGqlResponse(getIt<AuthGqlClient>(), data: (_) => respAsObj);

      await tester.pumpApp(build(child: const GroupsPage()));
      await tester.pump(const Duration(microseconds: 10));

      expect(
          find.byType(ClubTab, skipOffstage: false),
          findsNWidgets(
              respAsObj.admin_clubs.length + respAsObj.member_clubs.length));

      expect(find.byType(DmTab, skipOffstage: false),
          findsNWidgets(respAsObj.dms.length));
    });
  });

  //should have club tab for every club
  //should have dm tab for every dm
}
