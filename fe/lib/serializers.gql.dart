import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:fe/gql/authenticate.data.gql.dart'
    show GAuthenticateData, GAuthenticateData_authenticate;
import 'package:fe/gql/authenticate.req.gql.dart' show GAuthenticateReq;
import 'package:fe/gql/authenticate.var.gql.dart' show GAuthenticateVars;
import 'package:fe/gql/fake/fake.data.gql.dart'
    show GFakeGqlData, GFakeGqlData_group_join_tokens;
import 'package:fe/gql/fake/fake.req.gql.dart' show GFakeGqlReq;
import 'package:fe/gql/fake/fake.var.gql.dart' show GFakeGqlVars;
import 'package:fe/gql/get_messages.data.gql.dart'
    show
        GGetMessagesData,
        GGetMessagesData_messages,
        GGetMessagesData_messages_user;
import 'package:fe/gql/get_messages.req.gql.dart' show GGetMessagesReq;
import 'package:fe/gql/get_messages.var.gql.dart' show GGetMessagesVars;
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
import 'package:fe/gql/query_group_join_token.data.gql.dart'
    show GQueryGroupJoinTokenData, GQueryGroupJoinTokenData_group_join_tokens;
import 'package:fe/gql/query_group_join_token.req.gql.dart'
    show GQueryGroupJoinTokenReq;
import 'package:fe/gql/query_group_join_token.var.gql.dart'
    show GQueryGroupJoinTokenVars;
import 'package:fe/gql/query_likers_names.data.gql.dart'
    show
        GQueryLikersNamesData,
        GQueryLikersNamesData_message_reactions,
        GQueryLikersNamesData_message_reactions_user;
import 'package:fe/gql/query_likers_names.req.gql.dart'
    show GQueryLikersNamesReq;
import 'package:fe/gql/query_likers_names.var.gql.dart'
    show GQueryLikersNamesVars;
import 'package:fe/gql/query_messages_in_thread.data.gql.dart'
    show
        GQueryMessagesInThreadData,
        GQueryMessagesInThreadData_messages,
        GQueryMessagesInThreadData_messages_message_reactions,
        GQueryMessagesInThreadData_messages_message_reactions_message_reaction_type,
        GQueryMessagesInThreadData_messages_message_reactions_user,
        GQueryMessagesInThreadData_messages_user;
import 'package:fe/gql/query_messages_in_thread.req.gql.dart'
    show GQueryMessagesInThreadReq;
import 'package:fe/gql/query_messages_in_thread.var.gql.dart'
    show GQueryMessagesInThreadVars;
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
        GQuerySelfGroupsData_admin_clubs_group_group_join_tokens,
        GQuerySelfGroupsData_dms,
        GQuerySelfGroupsData_dms_thread,
        GQuerySelfGroupsData_dms_thread_user_to_threads,
        GQuerySelfGroupsData_dms_thread_user_to_threads_user,
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
import 'package:fe/gql/query_users_in_group.data.gql.dart'
    show
        GQueryUsersInGroupData,
        GQueryUsersInGroupData_user_to_group,
        GQueryUsersInGroupData_user_to_group_user;
import 'package:fe/gql/query_users_in_group.req.gql.dart'
    show GQueryUsersInGroupReq;
import 'package:fe/gql/query_users_in_group.var.gql.dart'
    show GQueryUsersInGroupVars;
import 'package:fe/gql/query_verify_self_in_thread.data.gql.dart'
    show
        GQueryVerifySelfInThreadData,
        GQueryVerifySelfInThreadData_threads_aggregate,
        GQueryVerifySelfInThreadData_threads_aggregate_aggregate;
import 'package:fe/gql/query_verify_self_in_thread.req.gql.dart'
    show GQueryVerifySelfInThreadReq;
import 'package:fe/gql/query_verify_self_in_thread.var.gql.dart'
    show GQueryVerifySelfInThreadVars;
import 'package:fe/gql/refresh.data.gql.dart'
    show GRefreshData, GRefreshData_refresh_access_token;
import 'package:fe/gql/refresh.req.gql.dart' show GRefreshReq;
import 'package:fe/gql/refresh.var.gql.dart' show GRefreshVars;
import 'package:fe/gql/remove_self_from_group.data.gql.dart'
    show
        GRemoveSelfFromGroupData,
        GRemoveSelfFromGroupData_delete_user_to_group;
import 'package:fe/gql/remove_self_from_group.req.gql.dart'
    show GRemoveSelfFromGroupReq;
import 'package:fe/gql/remove_self_from_group.var.gql.dart'
    show GRemoveSelfFromGroupVars;
import 'package:fe/gql/update_self_name.data.gql.dart'
    show GUpdateSelfNameData, GUpdateSelfNameData_update_users_by_pk;
import 'package:fe/gql/update_self_name.req.gql.dart' show GUpdateSelfNameReq;
import 'package:fe/gql/update_self_name.var.gql.dart' show GUpdateSelfNameVars;
import 'package:fe/gql/upsert_group_join_token.data.gql.dart'
    show
        GUpsertGroupJoinTokenData,
        GUpsertGroupJoinTokenData_insert_group_join_tokens_one;
import 'package:fe/gql/upsert_group_join_token.req.gql.dart'
    show GUpsertGroupJoinTokenReq;
import 'package:fe/gql/upsert_group_join_token.var.gql.dart'
    show GUpsertGroupJoinTokenVars;
import 'package:fe/gql/upsert_reaction.data.gql.dart'
    show GUpsertReactionData, GUpsertReactionData_insert_message_reactions_one;
import 'package:fe/gql/upsert_reaction.req.gql.dart' show GUpsertReactionReq;
import 'package:fe/gql/upsert_reaction.var.gql.dart' show GUpsertReactionVars;
import 'package:fe/schema.schema.gql.dart'
    show
        GBoolean_comparison_exp,
        GIdentityProvider,
        GString_comparison_exp,
        Ggroup_join_tokens_aggregate_order_by,
        Ggroup_join_tokens_arr_rel_insert_input,
        Ggroup_join_tokens_bool_exp,
        Ggroup_join_tokens_constraint,
        Ggroup_join_tokens_insert_input,
        Ggroup_join_tokens_max_order_by,
        Ggroup_join_tokens_min_order_by,
        Ggroup_join_tokens_on_conflict,
        Ggroup_join_tokens_order_by,
        Ggroup_join_tokens_pk_columns_input,
        Ggroup_join_tokens_select_column,
        Ggroup_join_tokens_set_input,
        Ggroup_join_tokens_update_column,
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
        Gsingle_dms_bool_exp,
        Gsingle_dms_insert_input,
        Gsingle_dms_order_by,
        Gsingle_dms_select_column,
        Gsingle_dms_set_input,
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
        Guser_to_group_aggregate_order_by,
        Guser_to_group_arr_rel_insert_input,
        Guser_to_group_bool_exp,
        Guser_to_group_constraint,
        Guser_to_group_insert_input,
        Guser_to_group_max_order_by,
        Guser_to_group_min_order_by,
        Guser_to_group_on_conflict,
        Guser_to_group_order_by,
        Guser_to_group_pk_columns_input,
        Guser_to_group_select_column,
        Guser_to_group_set_input,
        Guser_to_group_update_column,
        Guser_to_thread_aggregate_order_by,
        Guser_to_thread_arr_rel_insert_input,
        Guser_to_thread_bool_exp,
        Guser_to_thread_constraint,
        Guser_to_thread_insert_input,
        Guser_to_thread_max_order_by,
        Guser_to_thread_min_order_by,
        Guser_to_thread_on_conflict,
        Guser_to_thread_order_by,
        Guser_to_thread_pk_columns_input,
        Guser_to_thread_select_column,
        Guser_to_thread_set_input,
        Guser_to_thread_update_column,
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
  GAuthenticateData,
  GAuthenticateData_authenticate,
  GAuthenticateReq,
  GAuthenticateVars,
  GBoolean_comparison_exp,
  GFakeGqlData,
  GFakeGqlData_group_join_tokens,
  GFakeGqlReq,
  GFakeGqlVars,
  GGetMessagesData,
  GGetMessagesData_messages,
  GGetMessagesData_messages_user,
  GGetMessagesReq,
  GGetMessagesVars,
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
  GQueryGroupJoinTokenData,
  GQueryGroupJoinTokenData_group_join_tokens,
  GQueryGroupJoinTokenReq,
  GQueryGroupJoinTokenVars,
  GQueryLikersNamesData,
  GQueryLikersNamesData_message_reactions,
  GQueryLikersNamesData_message_reactions_user,
  GQueryLikersNamesReq,
  GQueryLikersNamesVars,
  GQueryMessagesInThreadData,
  GQueryMessagesInThreadData_messages,
  GQueryMessagesInThreadData_messages_message_reactions,
  GQueryMessagesInThreadData_messages_message_reactions_message_reaction_type,
  GQueryMessagesInThreadData_messages_message_reactions_user,
  GQueryMessagesInThreadData_messages_user,
  GQueryMessagesInThreadReq,
  GQueryMessagesInThreadVars,
  GQuerySelfGroupsData,
  GQuerySelfGroupsData_admin_clubs,
  GQuerySelfGroupsData_admin_clubs_group,
  GQuerySelfGroupsData_admin_clubs_group_group_join_tokens,
  GQuerySelfGroupsData_dms,
  GQuerySelfGroupsData_dms_thread,
  GQuerySelfGroupsData_dms_thread_user_to_threads,
  GQuerySelfGroupsData_dms_thread_user_to_threads_user,
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
  GQueryUsersInGroupData,
  GQueryUsersInGroupData_user_to_group,
  GQueryUsersInGroupData_user_to_group_user,
  GQueryUsersInGroupReq,
  GQueryUsersInGroupVars,
  GQueryVerifySelfInThreadData,
  GQueryVerifySelfInThreadData_threads_aggregate,
  GQueryVerifySelfInThreadData_threads_aggregate_aggregate,
  GQueryVerifySelfInThreadReq,
  GQueryVerifySelfInThreadVars,
  GRefreshData,
  GRefreshData_refresh_access_token,
  GRefreshReq,
  GRefreshVars,
  GRemoveSelfFromGroupData,
  GRemoveSelfFromGroupData_delete_user_to_group,
  GRemoveSelfFromGroupReq,
  GRemoveSelfFromGroupVars,
  GString_comparison_exp,
  GUpdateSelfNameData,
  GUpdateSelfNameData_update_users_by_pk,
  GUpdateSelfNameReq,
  GUpdateSelfNameVars,
  GUpsertGroupJoinTokenData,
  GUpsertGroupJoinTokenData_insert_group_join_tokens_one,
  GUpsertGroupJoinTokenReq,
  GUpsertGroupJoinTokenVars,
  GUpsertReactionData,
  GUpsertReactionData_insert_message_reactions_one,
  GUpsertReactionReq,
  GUpsertReactionVars,
  Ggroup_base_fieldsData,
  Ggroup_base_fieldsReq,
  Ggroup_base_fieldsVars,
  Ggroup_join_tokens_aggregate_order_by,
  Ggroup_join_tokens_arr_rel_insert_input,
  Ggroup_join_tokens_bool_exp,
  Ggroup_join_tokens_constraint,
  Ggroup_join_tokens_insert_input,
  Ggroup_join_tokens_max_order_by,
  Ggroup_join_tokens_min_order_by,
  Ggroup_join_tokens_on_conflict,
  Ggroup_join_tokens_order_by,
  Ggroup_join_tokens_pk_columns_input,
  Ggroup_join_tokens_select_column,
  Ggroup_join_tokens_set_input,
  Ggroup_join_tokens_update_column,
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
  Gsingle_dms_bool_exp,
  Gsingle_dms_insert_input,
  Gsingle_dms_order_by,
  Gsingle_dms_select_column,
  Gsingle_dms_set_input,
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
  Guser_to_group_aggregate_order_by,
  Guser_to_group_arr_rel_insert_input,
  Guser_to_group_bool_exp,
  Guser_to_group_constraint,
  Guser_to_group_insert_input,
  Guser_to_group_max_order_by,
  Guser_to_group_min_order_by,
  Guser_to_group_on_conflict,
  Guser_to_group_order_by,
  Guser_to_group_pk_columns_input,
  Guser_to_group_select_column,
  Guser_to_group_set_input,
  Guser_to_group_update_column,
  Guser_to_thread_aggregate_order_by,
  Guser_to_thread_arr_rel_insert_input,
  Guser_to_thread_bool_exp,
  Guser_to_thread_constraint,
  Guser_to_thread_insert_input,
  Guser_to_thread_max_order_by,
  Guser_to_thread_min_order_by,
  Guser_to_thread_on_conflict,
  Guser_to_thread_order_by,
  Guser_to_thread_pk_columns_input,
  Guser_to_thread_select_column,
  Guser_to_thread_set_input,
  Guser_to_thread_update_column,
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
