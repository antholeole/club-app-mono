import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:fe/gql/fake/fake.data.gql.dart'
    show GFakeGqlData, GFakeGqlData_group_join_tokens;
import 'package:fe/gql/fake/fake.req.gql.dart' show GFakeGqlReq;
import 'package:fe/gql/fake/fake.var.gql.dart' show GFakeGqlVars;
import 'package:fe/gql/query_group_join_token.data.gql.dart'
    show GQueryGroupJoinTokenData, GQueryGroupJoinTokenData_group_join_tokens;
import 'package:fe/gql/query_group_join_token.req.gql.dart'
    show GQueryGroupJoinTokenReq;
import 'package:fe/gql/query_group_join_token.var.gql.dart'
    show GQueryGroupJoinTokenVars;
import 'package:fe/gql/query_self_group_preview.data.gql.dart'
    show
        GQuerySelfGroupsPreviewData,
        GQuerySelfGroupsPreviewData_user_to_group,
        GQuerySelfGroupsPreviewData_user_to_group_group;
import 'package:fe/gql/query_self_group_preview.req.gql.dart'
    show GQuerySelfGroupsPreviewReq;
import 'package:fe/gql/query_self_group_preview.var.gql.dart'
    show GQuerySelfGroupsPreviewVars;
import 'package:fe/gql/query_self_threads_in_group.data.gql.dart'
    show
        GQuerySelfThreadsInGroupData,
        GQuerySelfThreadsInGroupData_group_threads;
import 'package:fe/gql/query_self_threads_in_group.req.gql.dart'
    show GQuerySelfThreadsInGroupReq;
import 'package:fe/gql/query_self_threads_in_group.var.gql.dart'
    show GQuerySelfThreadsInGroupVars;
import 'package:fe/gql/query_thread_name_by_id.data.gql.dart'
    show GQueryThreadNameData, GQueryThreadNameData_group_threads_by_pk;
import 'package:fe/gql/query_thread_name_by_id.req.gql.dart'
    show GQueryThreadNameReq;
import 'package:fe/gql/query_thread_name_by_id.var.gql.dart'
    show GQueryThreadNameVars;
import 'package:fe/gql/query_users_in_group.data.gql.dart'
    show
        GQueryUsersInGroupData,
        GQueryUsersInGroupData_user_to_group,
        GQueryUsersInGroupData_user_to_group_user;
import 'package:fe/gql/query_users_in_group.req.gql.dart'
    show GQueryUsersInGroupReq;
import 'package:fe/gql/query_users_in_group.var.gql.dart'
    show GQueryUsersInGroupVars;
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
import 'package:fe/schema.schema.gql.dart'
    show
        GBoolean_comparison_exp,
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
        Ggroup_threads_aggregate_order_by,
        Ggroup_threads_arr_rel_insert_input,
        Ggroup_threads_bool_exp,
        Ggroup_threads_constraint,
        Ggroup_threads_insert_input,
        Ggroup_threads_max_order_by,
        Ggroup_threads_min_order_by,
        Ggroup_threads_obj_rel_insert_input,
        Ggroup_threads_on_conflict,
        Ggroup_threads_order_by,
        Ggroup_threads_pk_columns_input,
        Ggroup_threads_select_column,
        Ggroup_threads_set_input,
        Ggroup_threads_update_column,
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
        Gmessages_aggregate_order_by,
        Gmessages_arr_rel_insert_input,
        Gmessages_bool_exp,
        Gmessages_constraint,
        Gmessages_insert_input,
        Gmessages_max_order_by,
        Gmessages_min_order_by,
        Gmessages_on_conflict,
        Gmessages_order_by,
        Gmessages_pk_columns_input,
        Gmessages_select_column,
        Gmessages_set_input,
        Gmessages_update_column,
        Gorder_by,
        Gtimestamptz,
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
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(UuidTypeSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GBoolean_comparison_exp,
  GFakeGqlData,
  GFakeGqlData_group_join_tokens,
  GFakeGqlReq,
  GFakeGqlVars,
  GQueryGroupJoinTokenData,
  GQueryGroupJoinTokenData_group_join_tokens,
  GQueryGroupJoinTokenReq,
  GQueryGroupJoinTokenVars,
  GQuerySelfGroupsPreviewData,
  GQuerySelfGroupsPreviewData_user_to_group,
  GQuerySelfGroupsPreviewData_user_to_group_group,
  GQuerySelfGroupsPreviewReq,
  GQuerySelfGroupsPreviewVars,
  GQuerySelfThreadsInGroupData,
  GQuerySelfThreadsInGroupData_group_threads,
  GQuerySelfThreadsInGroupReq,
  GQuerySelfThreadsInGroupVars,
  GQueryThreadNameData,
  GQueryThreadNameData_group_threads_by_pk,
  GQueryThreadNameReq,
  GQueryThreadNameVars,
  GQueryUsersInGroupData,
  GQueryUsersInGroupData_user_to_group,
  GQueryUsersInGroupData_user_to_group_user,
  GQueryUsersInGroupReq,
  GQueryUsersInGroupVars,
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
  Ggroup_threads_aggregate_order_by,
  Ggroup_threads_arr_rel_insert_input,
  Ggroup_threads_bool_exp,
  Ggroup_threads_constraint,
  Ggroup_threads_insert_input,
  Ggroup_threads_max_order_by,
  Ggroup_threads_min_order_by,
  Ggroup_threads_obj_rel_insert_input,
  Ggroup_threads_on_conflict,
  Ggroup_threads_order_by,
  Ggroup_threads_pk_columns_input,
  Ggroup_threads_select_column,
  Ggroup_threads_set_input,
  Ggroup_threads_update_column,
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
  Gmessages_aggregate_order_by,
  Gmessages_arr_rel_insert_input,
  Gmessages_bool_exp,
  Gmessages_constraint,
  Gmessages_insert_input,
  Gmessages_max_order_by,
  Gmessages_min_order_by,
  Gmessages_on_conflict,
  Gmessages_order_by,
  Gmessages_pk_columns_input,
  Gmessages_select_column,
  Gmessages_set_input,
  Gmessages_update_column,
  Gorder_by,
  Gtimestamptz,
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
