import 'package:fe/data/models/group.dart';
import 'package:fe/gql/query_self_groups.var.gql.dart';
import 'package:fe/pages/main/cubit/user_cubit.dart';
import 'package:fe/services/clients/gql_client/auth_gql_client.dart';
import 'package:fe/services/toaster/cubit/data_carriers/toast.dart';
import 'package:fe/services/toaster/cubit/toaster_cubit.dart';
import 'package:fe/stdlib/shared_widgets/gql_operation.dart';
import 'package:fe/stdlib/shared_widgets/hydrated_builder.dart';
import 'package:fe/gql/query_self_groups.data.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fe/gql/remove_self_from_group.req.gql.dart';

import '../../../../../../../service_locator.dart';

class LeaveClubButton extends StatelessWidget {
  static const LEAVE_GROUP_PROMPT_COPY = 'Leave Group';

  final _gqlClient = getIt<AuthGqlClient>();

  @visibleForTesting
  static const String LEAVE_GROUP = 'leave group';

  LeaveClubButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<Club>();

    return ListTile(
      title: const Text(
        LeaveClubButton.LEAVE_GROUP,
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
      onTap: () => context.read<ToasterCubit>().add(Toast(
          type: ToastType.Warning,
          message: "Are you sure you'd like to leave ${group.name}?",
          expireAt: null,
          action: ToastAction(
              action: () => _gqlClient.mutateFromUi(
                      GRemoveSelfFromGroupReq((q) => q
                        ..vars.groupId = group.id
                        ..vars.userId = context.read<UserCubit>().user.id
                        ..fetchPolicy = FetchPolicy.NetworkOnly),
                      context, onComplete: (_) {
                    context
                        .read<
                            ReRequester<GQuerySelfGroupsData,
                                GQuerySelfGroupsVars>>()
                        .reRequest();

                    if (context.read<Group>().id == group.id) {
                      context.read<HydratedSetter<Group>>().set(null);
                    }
                  },
                      errorMessage: 'failed to leave group',
                      successMessage: 'Left group ${group.name}'),
              actionText: LEAVE_GROUP_PROMPT_COPY))),
    );
  }
}
