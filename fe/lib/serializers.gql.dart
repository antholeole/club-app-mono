import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:fe/gql/add_role_to_group.data.gql.dart'
    show GAddRoleToGroupData, GAddRoleToGroupData_insert_roles_one;
import 'package:fe/gql/add_role_to_group.req.gql.dart' show GAddRoleToGroupReq;
import 'package:fe/gql/add_role_to_group.var.gql.dart' show GAddRoleToGroupVars;
import 'package:fe/gql/add_roles_to_users.data.gql.dart'
    show GAddRolesToUsersData, GAddRolesToUsersData_insert_user_to_role;
import 'package:fe/gql/add_roles_to_users.req.gql.dart'
    show GAddRolesToUsersReq;
import 'package:fe/gql/add_roles_to_users.var.gql.dart'
    show GAddRolesToUsersVars;
import 'package:fe/gql/authenticate.data.gql.dart'
    show GAuthenticateData, GAuthenticateData_authenticate;
import 'package:fe/gql/authenticate.req.gql.dart' show GAuthenticateReq;
import 'package:fe/gql/authenticate.var.gql.dart' show GAuthenticateVars;
import 'package:fe/gql/fake/fake.data.gql.dart'
    show GFakeGqlData, GFakeGqlData_dms;
import 'package:fe/gql/fake/fake.req.gql.dart' show GFakeGqlReq;
import 'package:fe/gql/fake/fake.var.gql.dart' show GFakeGqlVars;
import 'package:fe/gql/get_new_messages.data.gql.dart'
    show
        GGetNewMessagesData,
        GGetNewMessagesData_messages,
        GGetNewMessagesData_messages_message_reactions,
        GGetNewMessagesData_messages_message_reactions_user,
        GGetNewMessagesData_messages_user;
import 'package:fe/gql/get_new_messages.req.gql.dart' show GGetNewMessagesReq;
import 'package:fe/gql/get_new_messages.var.gql.dart' show GGetNewMessagesVars;
import 'package:fe/gql/get_new_reactions.data.gql.dart'
    show
        GGetNewReactionsData,
        GGetNewReactionsData_message_reactions,
        GGetNewReactionsData_message_reactions_message,
        GGetNewReactionsData_message_reactions_user;
import 'package:fe/gql/get_new_reactions.req.gql.dart' show GGetNewReactionsReq;
import 'package:fe/gql/get_new_reactions.var.gql.dart'
    show GGetNewReactionsVars;
import 'package:fe/gql/get_or_create_dm.data.gql.dart'
    show GGetOrCreateDmData, GGetOrCreateDmData_get_or_create_dm;
import 'package:fe/gql/get_or_create_dm.req.gql.dart' show GGetOrCreateDmReq;
import 'package:fe/gql/get_or_create_dm.var.gql.dart' show GGetOrCreateDmVars;
import 'package:fe/gql/insert_message.data.gql.dart'
    show
        GInsertMessageData,
        GInsertMessageData_insert_messages,
        GInsertMessageData_insert_messages_returning;
import 'package:fe/gql/insert_message.req.gql.dart' show GInsertMessageReq;
import 'package:fe/gql/insert_message.var.gql.dart' show GInsertMessageVars;
import 'package:fe/gql/query_messages_in_chat.data.gql.dart'
    show
        GQueryMessagesInChatData,
        GQueryMessagesInChatData_messages,
        GQueryMessagesInChatData_messages_message_reactions,
        GQueryMessagesInChatData_messages_message_reactions_user,
        GQueryMessagesInChatData_messages_user;
import 'package:fe/gql/query_messages_in_chat.req.gql.dart'
    show GQueryMessagesInChatReq;
import 'package:fe/gql/query_messages_in_chat.var.gql.dart'
    show GQueryMessagesInChatVars;
import 'package:fe/gql/query_roles_in_group.data.gql.dart'
    show GQueryRolesInGroupData, GQueryRolesInGroupData_roles;
import 'package:fe/gql/query_roles_in_group.req.gql.dart'
    show GQueryRolesInGroupReq;
import 'package:fe/gql/query_roles_in_group.var.gql.dart'
    show GQueryRolesInGroupVars;
import 'package:fe/gql/query_self_group_preview.data.gql.dart'
    show
        GQuerySelfGroupsPreviewData,
        GQuerySelfGroupsPreviewData_user_to_group,
        GQuerySelfGroupsPreviewData_user_to_group_group;
import 'package:fe/gql/query_self_group_preview.req.gql.dart'
    show GQuerySelfGroupsPreviewReq;
import 'package:fe/gql/query_self_group_preview.var.gql.dart'
    show GQuerySelfGroupsPreviewVars;
import 'package:fe/gql/query_self_groups.data.gql.dart'
    show
        GQuerySelfGroupsData,
        GQuerySelfGroupsData_admin_clubs,
        GQuerySelfGroupsData_admin_clubs_group,
        GQuerySelfGroupsData_dms,
        GQuerySelfGroupsData_dms_user_to_dms,
        GQuerySelfGroupsData_dms_user_to_dms_user,
        GQuerySelfGroupsData_member_clubs,
        GQuerySelfGroupsData_member_clubs_group,
        Ggroup_base_fieldsData;
import 'package:fe/gql/query_self_groups.req.gql.dart'
    show GQuerySelfGroupsReq, Ggroup_base_fieldsReq;
import 'package:fe/gql/query_self_groups.var.gql.dart'
    show GQuerySelfGroupsVars, Ggroup_base_fieldsVars;
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart'
    show GQuerySelfThreadsInGroupData, GQuerySelfThreadsInGroupData_threads;
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart'
    show GQuerySelfThreadsInGroupReq;
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart'
    show GQuerySelfThreadsInGroupVars;
import 'package:fe/gql/query_users_in_dm.data.gql.dart'
    show
        GQueryUsersInDmData,
        GQueryUsersInDmData_user_to_dm,
        GQueryUsersInDmData_user_to_dm_user;
import 'package:fe/gql/query_users_in_dm.req.gql.dart' show GQueryUsersInDmReq;
import 'package:fe/gql/query_users_in_dm.var.gql.dart' show GQueryUsersInDmVars;
import 'package:fe/gql/query_users_in_group.data.gql.dart'
    show
        GQueryUsersInGroupData,
        GQueryUsersInGroupData_user_to_group,
        GQueryUsersInGroupData_user_to_group_user,
        GQueryUsersInGroupData_user_to_group_user_user_to_roles,
        GQueryUsersInGroupData_user_to_group_user_user_to_roles_role;
import 'package:fe/gql/query_users_in_group.req.gql.dart'
    show GQueryUsersInGroupReq;
import 'package:fe/gql/query_users_in_group.var.gql.dart'
    show GQueryUsersInGroupVars;
import 'package:fe/gql/query_users_in_thread.data.gql.dart'
    show
        GQueryUsersInThreadData,
        GQueryUsersInThreadData_user_to_thread,
        GQueryUsersInThreadData_user_to_thread_user;
import 'package:fe/gql/query_users_in_thread.req.gql.dart'
    show GQueryUsersInThreadReq;
import 'package:fe/gql/query_users_in_thread.var.gql.dart'
    show GQueryUsersInThreadVars;
import 'package:fe/gql/query_verify_self_in_thread.data.gql.dart'
    show
        GQueryVerifySelfInThreadData,
        GQueryVerifySelfInThreadData_threads_aggregate,
        GQueryVerifySelfInThreadData_threads_aggregate_aggregate;
import 'package:fe/gql/query_verify_self_in_thread.req.gql.dart'
    show GQueryVerifySelfInThreadReq;
import 'package:fe/gql/query_verify_self_in_thread.var.gql.dart'
    show GQueryVerifySelfInThreadVars;
import 'package:fe/gql/query_view_only_threads.data.gql.dart'
    show GQueryViewOnlyThreadsData, GQueryViewOnlyThreadsData_threads;
import 'package:fe/gql/query_view_only_threads.req.gql.dart'
    show GQueryViewOnlyThreadsReq;
import 'package:fe/gql/query_view_only_threads.var.gql.dart'
    show GQueryViewOnlyThreadsVars;
import 'package:fe/gql/refresh.data.gql.dart'
    show GRefreshData, GRefreshData_refresh_access_token;
import 'package:fe/gql/refresh.req.gql.dart' show GRefreshReq;
import 'package:fe/gql/refresh.var.gql.dart' show GRefreshVars;
import 'package:fe/gql/remove_role_from_group.data.gql.dart'
    show GRemoveRoleFromGroupData, GRemoveRoleFromGroupData_delete_roles;
import 'package:fe/gql/remove_role_from_group.req.gql.dart'
    show GRemoveRoleFromGroupReq;
import 'package:fe/gql/remove_role_from_group.var.gql.dart'
    show GRemoveRoleFromGroupVars;
import 'package:fe/gql/remove_role_from_user.data.gql.dart'
    show GRemoveRoleFromUserData, GRemoveRoleFromUserData_delete_user_to_role;
import 'package:fe/gql/remove_role_from_user.req.gql.dart'
    show GRemoveRoleFromUserReq;
import 'package:fe/gql/remove_role_from_user.var.gql.dart'
    show GRemoveRoleFromUserVars;
import 'package:fe/gql/remove_self_from_group.data.gql.dart'
    show GRemoveSelfFromGroupData, GRemoveSelfFromGroupData_delete_user_to_role;
import 'package:fe/gql/remove_self_from_group.req.gql.dart'
    show GRemoveSelfFromGroupReq;
import 'package:fe/gql/remove_self_from_group.var.gql.dart'
    show GRemoveSelfFromGroupVars;
import 'package:fe/gql/update_self_name.data.gql.dart'
    show GUpdateSelfNameData, GUpdateSelfNameData_update_users_by_pk;
import 'package:fe/gql/update_self_name.req.gql.dart' show GUpdateSelfNameReq;
import 'package:fe/gql/update_self_name.var.gql.dart' show GUpdateSelfNameVars;
import 'package:fe/gql/upsert_reaction.data.gql.dart'
    show GUpsertReactionData, GUpsertReactionData_insert_message_reactions_one;
import 'package:fe/gql/upsert_reaction.req.gql.dart' show GUpsertReactionReq;
import 'package:fe/gql/upsert_reaction.var.gql.dart' show GUpsertReactionVars;
import 'package:fe/schema.schema.gql.dart'
    show
        GBoolean_comparison_exp,
        GIdentityProvider,
        GString_comparison_exp,
        Gdms_bool_exp,
        Gdms_constraint,
        Gdms_insert_input,
        Gdms_obj_rel_insert_input,
        Gdms_on_conflict,
        Gdms_order_by,
        Gdms_pk_columns_input,
        Gdms_select_column,
        Gdms_set_input,
        Gdms_update_column,
        Ggroup_metadata_bool_exp,
        Ggroup_metadata_constraint,
        Ggroup_metadata_insert_input,
        Ggroup_metadata_obj_rel_insert_input,
        Ggroup_metadata_on_conflict,
        Ggroup_metadata_order_by,
        Ggroup_metadata_pk_columns_input,
        Ggroup_metadata_select_column,
        Ggroup_metadata_set_input,
        Ggroup_metadata_update_column,
        Ggroups_bool_exp,
        Ggroups_constraint,
        Ggroups_insert_input,
        Ggroups_obj_rel_insert_input,
        Ggroups_on_conflict,
        Ggroups_order_by,
        Ggroups_pk_columns_input,
        Ggroups_select_column,
        Ggroups_set_input,
        Ggroups_update_column,
        Gmessage_reaction_types_bool_exp,
        Gmessage_reaction_types_constraint,
        Gmessage_reaction_types_enum,
        Gmessage_reaction_types_enum_comparison_exp,
        Gmessage_reaction_types_insert_input,
        Gmessage_reaction_types_obj_rel_insert_input,
        Gmessage_reaction_types_on_conflict,
        Gmessage_reaction_types_order_by,
        Gmessage_reaction_types_pk_columns_input,
        Gmessage_reaction_types_select_column,
        Gmessage_reaction_types_set_input,
        Gmessage_reaction_types_update_column,
        Gmessage_reactions_aggregate_order_by,
        Gmessage_reactions_arr_rel_insert_input,
        Gmessage_reactions_bool_exp,
        Gmessage_reactions_constraint,
        Gmessage_reactions_insert_input,
        Gmessage_reactions_max_order_by,
        Gmessage_reactions_min_order_by,
        Gmessage_reactions_on_conflict,
        Gmessage_reactions_order_by,
        Gmessage_reactions_pk_columns_input,
        Gmessage_reactions_select_column,
        Gmessage_reactions_set_input,
        Gmessage_reactions_update_column,
        Gmessages_aggregate_order_by,
        Gmessages_arr_rel_insert_input,
        Gmessages_bool_exp,
        Gmessages_constraint,
        Gmessages_insert_input,
        Gmessages_max_order_by,
        Gmessages_min_order_by,
        Gmessages_obj_rel_insert_input,
        Gmessages_on_conflict,
        Gmessages_order_by,
        Gmessages_pk_columns_input,
        Gmessages_select_column,
        Gmessages_set_input,
        Gmessages_update_column,
        Gorder_by,
        Grole_to_threads_aggregate_order_by,
        Grole_to_threads_arr_rel_insert_input,
        Grole_to_threads_bool_exp,
        Grole_to_threads_constraint,
        Grole_to_threads_insert_input,
        Grole_to_threads_max_order_by,
        Grole_to_threads_min_order_by,
        Grole_to_threads_on_conflict,
        Grole_to_threads_order_by,
        Grole_to_threads_pk_columns_input,
        Grole_to_threads_select_column,
        Grole_to_threads_set_input,
        Grole_to_threads_update_column,
        Groles_aggregate_order_by,
        Groles_arr_rel_insert_input,
        Groles_bool_exp,
        Groles_constraint,
        Groles_insert_input,
        Groles_max_order_by,
        Groles_min_order_by,
        Groles_obj_rel_insert_input,
        Groles_on_conflict,
        Groles_order_by,
        Groles_pk_columns_input,
        Groles_select_column,
        Groles_set_input,
        Groles_update_column,
        Gthreads_aggregate_order_by,
        Gthreads_arr_rel_insert_input,
        Gthreads_bool_exp,
        Gthreads_constraint,
        Gthreads_insert_input,
        Gthreads_max_order_by,
        Gthreads_min_order_by,
        Gthreads_obj_rel_insert_input,
        Gthreads_on_conflict,
        Gthreads_order_by,
        Gthreads_pk_columns_input,
        Gthreads_select_column,
        Gthreads_set_input,
        Gthreads_update_column,
        Gtimestamptz_comparison_exp,
        Guser_to_dm_aggregate_order_by,
        Guser_to_dm_arr_rel_insert_input,
        Guser_to_dm_bool_exp,
        Guser_to_dm_constraint,
        Guser_to_dm_insert_input,
        Guser_to_dm_max_order_by,
        Guser_to_dm_min_order_by,
        Guser_to_dm_on_conflict,
        Guser_to_dm_order_by,
        Guser_to_dm_pk_columns_input,
        Guser_to_dm_select_column,
        Guser_to_dm_set_input,
        Guser_to_dm_update_column,
        Guser_to_group_aggregate_order_by,
        Guser_to_group_arr_rel_insert_input,
        Guser_to_group_bool_exp,
        Guser_to_group_insert_input,
        Guser_to_group_max_order_by,
        Guser_to_group_min_order_by,
        Guser_to_group_order_by,
        Guser_to_group_select_column,
        Guser_to_role_aggregate_order_by,
        Guser_to_role_arr_rel_insert_input,
        Guser_to_role_bool_exp,
        Guser_to_role_constraint,
        Guser_to_role_insert_input,
        Guser_to_role_max_order_by,
        Guser_to_role_min_order_by,
        Guser_to_role_on_conflict,
        Guser_to_role_order_by,
        Guser_to_role_pk_columns_input,
        Guser_to_role_select_column,
        Guser_to_role_set_input,
        Guser_to_role_update_column,
        Guser_to_thread_aggregate_order_by,
        Guser_to_thread_arr_rel_insert_input,
        Guser_to_thread_bool_exp,
        Guser_to_thread_insert_input,
        Guser_to_thread_max_order_by,
        Guser_to_thread_min_order_by,
        Guser_to_thread_order_by,
        Guser_to_thread_select_column,
        Gusers_bool_exp,
        Gusers_constraint,
        Gusers_insert_input,
        Gusers_obj_rel_insert_input,
        Gusers_on_conflict,
        Gusers_order_by,
        Gusers_pk_columns_input,
        Gusers_select_column,
        Gusers_set_input,
        Gusers_update_column,
        Guuid_comparison_exp;
import 'package:fe/stdlib/helpers/datetime_type_converter.dart'
    show DateTimeSerializer;
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(UuidTypeSerializer())
  ..add(DateTimeSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAddRoleToGroupData,
  GAddRoleToGroupData_insert_roles_one,
  GAddRoleToGroupReq,
  GAddRoleToGroupVars,
  GAddRolesToUsersData,
  GAddRolesToUsersData_insert_user_to_role,
  GAddRolesToUsersReq,
  GAddRolesToUsersVars,
  GAuthenticateData,
  GAuthenticateData_authenticate,
  GAuthenticateReq,
  GAuthenticateVars,
  GBoolean_comparison_exp,
  GFakeGqlData,
  GFakeGqlData_dms,
  GFakeGqlReq,
  GFakeGqlVars,
  GGetNewMessagesData,
  GGetNewMessagesData_messages,
  GGetNewMessagesData_messages_message_reactions,
  GGetNewMessagesData_messages_message_reactions_user,
  GGetNewMessagesData_messages_user,
  GGetNewMessagesReq,
  GGetNewMessagesVars,
  GGetNewReactionsData,
  GGetNewReactionsData_message_reactions,
  GGetNewReactionsData_message_reactions_message,
  GGetNewReactionsData_message_reactions_user,
  GGetNewReactionsReq,
  GGetNewReactionsVars,
  GGetOrCreateDmData,
  GGetOrCreateDmData_get_or_create_dm,
  GGetOrCreateDmReq,
  GGetOrCreateDmVars,
  GIdentityProvider,
  GInsertMessageData,
  GInsertMessageData_insert_messages,
  GInsertMessageData_insert_messages_returning,
  GInsertMessageReq,
  GInsertMessageVars,
  GQueryMessagesInChatData,
  GQueryMessagesInChatData_messages,
  GQueryMessagesInChatData_messages_message_reactions,
  GQueryMessagesInChatData_messages_message_reactions_user,
  GQueryMessagesInChatData_messages_user,
  GQueryMessagesInChatReq,
  GQueryMessagesInChatVars,
  GQueryRolesInGroupData,
  GQueryRolesInGroupData_roles,
  GQueryRolesInGroupReq,
  GQueryRolesInGroupVars,
  GQuerySelfGroupsData,
  GQuerySelfGroupsData_admin_clubs,
  GQuerySelfGroupsData_admin_clubs_group,
  GQuerySelfGroupsData_dms,
  GQuerySelfGroupsData_dms_user_to_dms,
  GQuerySelfGroupsData_dms_user_to_dms_user,
  GQuerySelfGroupsData_member_clubs,
  GQuerySelfGroupsData_member_clubs_group,
  GQuerySelfGroupsPreviewData,
  GQuerySelfGroupsPreviewData_user_to_group,
  GQuerySelfGroupsPreviewData_user_to_group_group,
  GQuerySelfGroupsPreviewReq,
  GQuerySelfGroupsPreviewVars,
  GQuerySelfGroupsReq,
  GQuerySelfGroupsVars,
  GQuerySelfThreadsInGroupData,
  GQuerySelfThreadsInGroupData_threads,
  GQuerySelfThreadsInGroupReq,
  GQuerySelfThreadsInGroupVars,
  GQueryUsersInDmData,
  GQueryUsersInDmData_user_to_dm,
  GQueryUsersInDmData_user_to_dm_user,
  GQueryUsersInDmReq,
  GQueryUsersInDmVars,
  GQueryUsersInGroupData,
  GQueryUsersInGroupData_user_to_group,
  GQueryUsersInGroupData_user_to_group_user,
  GQueryUsersInGroupData_user_to_group_user_user_to_roles,
  GQueryUsersInGroupData_user_to_group_user_user_to_roles_role,
  GQueryUsersInGroupReq,
  GQueryUsersInGroupVars,
  GQueryUsersInThreadData,
  GQueryUsersInThreadData_user_to_thread,
  GQueryUsersInThreadData_user_to_thread_user,
  GQueryUsersInThreadReq,
  GQueryUsersInThreadVars,
  GQueryVerifySelfInThreadData,
  GQueryVerifySelfInThreadData_threads_aggregate,
  GQueryVerifySelfInThreadData_threads_aggregate_aggregate,
  GQueryVerifySelfInThreadReq,
  GQueryVerifySelfInThreadVars,
  GQueryViewOnlyThreadsData,
  GQueryViewOnlyThreadsData_threads,
  GQueryViewOnlyThreadsReq,
  GQueryViewOnlyThreadsVars,
  GRefreshData,
  GRefreshData_refresh_access_token,
  GRefreshReq,
  GRefreshVars,
  GRemoveRoleFromGroupData,
  GRemoveRoleFromGroupData_delete_roles,
  GRemoveRoleFromGroupReq,
  GRemoveRoleFromGroupVars,
  GRemoveRoleFromUserData,
  GRemoveRoleFromUserData_delete_user_to_role,
  GRemoveRoleFromUserReq,
  GRemoveRoleFromUserVars,
  GRemoveSelfFromGroupData,
  GRemoveSelfFromGroupData_delete_user_to_role,
  GRemoveSelfFromGroupReq,
  GRemoveSelfFromGroupVars,
  GString_comparison_exp,
  GUpdateSelfNameData,
  GUpdateSelfNameData_update_users_by_pk,
  GUpdateSelfNameReq,
  GUpdateSelfNameVars,
  GUpsertReactionData,
  GUpsertReactionData_insert_message_reactions_one,
  GUpsertReactionReq,
  GUpsertReactionVars,
  Gdms_bool_exp,
  Gdms_constraint,
  Gdms_insert_input,
  Gdms_obj_rel_insert_input,
  Gdms_on_conflict,
  Gdms_order_by,
  Gdms_pk_columns_input,
  Gdms_select_column,
  Gdms_set_input,
  Gdms_update_column,
  Ggroup_base_fieldsData,
  Ggroup_base_fieldsReq,
  Ggroup_base_fieldsVars,
  Ggroup_metadata_bool_exp,
  Ggroup_metadata_constraint,
  Ggroup_metadata_insert_input,
  Ggroup_metadata_obj_rel_insert_input,
  Ggroup_metadata_on_conflict,
  Ggroup_metadata_order_by,
  Ggroup_metadata_pk_columns_input,
  Ggroup_metadata_select_column,
  Ggroup_metadata_set_input,
  Ggroup_metadata_update_column,
  Ggroups_bool_exp,
  Ggroups_constraint,
  Ggroups_insert_input,
  Ggroups_obj_rel_insert_input,
  Ggroups_on_conflict,
  Ggroups_order_by,
  Ggroups_pk_columns_input,
  Ggroups_select_column,
  Ggroups_set_input,
  Ggroups_update_column,
  Gmessage_reaction_types_bool_exp,
  Gmessage_reaction_types_constraint,
  Gmessage_reaction_types_enum,
  Gmessage_reaction_types_enum_comparison_exp,
  Gmessage_reaction_types_insert_input,
  Gmessage_reaction_types_obj_rel_insert_input,
  Gmessage_reaction_types_on_conflict,
  Gmessage_reaction_types_order_by,
  Gmessage_reaction_types_pk_columns_input,
  Gmessage_reaction_types_select_column,
  Gmessage_reaction_types_set_input,
  Gmessage_reaction_types_update_column,
  Gmessage_reactions_aggregate_order_by,
  Gmessage_reactions_arr_rel_insert_input,
  Gmessage_reactions_bool_exp,
  Gmessage_reactions_constraint,
  Gmessage_reactions_insert_input,
  Gmessage_reactions_max_order_by,
  Gmessage_reactions_min_order_by,
  Gmessage_reactions_on_conflict,
  Gmessage_reactions_order_by,
  Gmessage_reactions_pk_columns_input,
  Gmessage_reactions_select_column,
  Gmessage_reactions_set_input,
  Gmessage_reactions_update_column,
  Gmessages_aggregate_order_by,
  Gmessages_arr_rel_insert_input,
  Gmessages_bool_exp,
  Gmessages_constraint,
  Gmessages_insert_input,
  Gmessages_max_order_by,
  Gmessages_min_order_by,
  Gmessages_obj_rel_insert_input,
  Gmessages_on_conflict,
  Gmessages_order_by,
  Gmessages_pk_columns_input,
  Gmessages_select_column,
  Gmessages_set_input,
  Gmessages_update_column,
  Gorder_by,
  Grole_to_threads_aggregate_order_by,
  Grole_to_threads_arr_rel_insert_input,
  Grole_to_threads_bool_exp,
  Grole_to_threads_constraint,
  Grole_to_threads_insert_input,
  Grole_to_threads_max_order_by,
  Grole_to_threads_min_order_by,
  Grole_to_threads_on_conflict,
  Grole_to_threads_order_by,
  Grole_to_threads_pk_columns_input,
  Grole_to_threads_select_column,
  Grole_to_threads_set_input,
  Grole_to_threads_update_column,
  Groles_aggregate_order_by,
  Groles_arr_rel_insert_input,
  Groles_bool_exp,
  Groles_constraint,
  Groles_insert_input,
  Groles_max_order_by,
  Groles_min_order_by,
  Groles_obj_rel_insert_input,
  Groles_on_conflict,
  Groles_order_by,
  Groles_pk_columns_input,
  Groles_select_column,
  Groles_set_input,
  Groles_update_column,
  Gthreads_aggregate_order_by,
  Gthreads_arr_rel_insert_input,
  Gthreads_bool_exp,
  Gthreads_constraint,
  Gthreads_insert_input,
  Gthreads_max_order_by,
  Gthreads_min_order_by,
  Gthreads_obj_rel_insert_input,
  Gthreads_on_conflict,
  Gthreads_order_by,
  Gthreads_pk_columns_input,
  Gthreads_select_column,
  Gthreads_set_input,
  Gthreads_update_column,
  Gtimestamptz_comparison_exp,
  Guser_to_dm_aggregate_order_by,
  Guser_to_dm_arr_rel_insert_input,
  Guser_to_dm_bool_exp,
  Guser_to_dm_constraint,
  Guser_to_dm_insert_input,
  Guser_to_dm_max_order_by,
  Guser_to_dm_min_order_by,
  Guser_to_dm_on_conflict,
  Guser_to_dm_order_by,
  Guser_to_dm_pk_columns_input,
  Guser_to_dm_select_column,
  Guser_to_dm_set_input,
  Guser_to_dm_update_column,
  Guser_to_group_aggregate_order_by,
  Guser_to_group_arr_rel_insert_input,
  Guser_to_group_bool_exp,
  Guser_to_group_insert_input,
  Guser_to_group_max_order_by,
  Guser_to_group_min_order_by,
  Guser_to_group_order_by,
  Guser_to_group_select_column,
  Guser_to_role_aggregate_order_by,
  Guser_to_role_arr_rel_insert_input,
  Guser_to_role_bool_exp,
  Guser_to_role_constraint,
  Guser_to_role_insert_input,
  Guser_to_role_max_order_by,
  Guser_to_role_min_order_by,
  Guser_to_role_on_conflict,
  Guser_to_role_order_by,
  Guser_to_role_pk_columns_input,
  Guser_to_role_select_column,
  Guser_to_role_set_input,
  Guser_to_role_update_column,
  Guser_to_thread_aggregate_order_by,
  Guser_to_thread_arr_rel_insert_input,
  Guser_to_thread_bool_exp,
  Guser_to_thread_insert_input,
  Guser_to_thread_max_order_by,
  Guser_to_thread_min_order_by,
  Guser_to_thread_order_by,
  Guser_to_thread_select_column,
  Gusers_bool_exp,
  Gusers_constraint,
  Gusers_insert_input,
  Gusers_obj_rel_insert_input,
  Gusers_on_conflict,
  Gusers_order_by,
  Gusers_pk_columns_input,
  Gusers_select_column,
  Gusers_set_input,
  Gusers_update_column,
  Guuid_comparison_exp
])
final Serializers serializers = _serializersBuilder.build();
