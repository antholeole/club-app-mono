import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:fe/gql/query_group_join_token.req.gql.dart'
    show GQueryGroupJoinTokenReq;
import 'package:fe/gql/query_group_join_token.var.gql.dart'
    show GQueryGroupJoinTokenVars;
import 'package:fe/gql/query_self_group_preview.req.gql.dart'
    show GQuerySelfGroupsPreviewReq;
import 'package:fe/gql/query_self_group_preview.var.gql.dart'
    show GQuerySelfGroupsPreviewVars;
import 'package:fe/gql/query_users_in_group.req.gql.dart'
    show GQueryUsersInGroupReq;
import 'package:fe/gql/query_users_in_group.var.gql.dart'
    show GQueryUsersInGroupVars;
import 'package:fe/gql/remove_self_from_group.req.gql.dart'
    show GRemoveSelfFromGroupReq;
import 'package:fe/gql/remove_self_from_group.var.gql.dart'
    show GRemoveSelfFromGroupVars;
import 'package:fe/gql/schema.schema.gql.dart'
    show
        GString_comparison_exp,
        Ggroups_aggregate_order_by,
        Ggroups_arr_rel_insert_input,
        Ggroups_bool_exp,
        Ggroups_constraint,
        Ggroups_insert_input,
        Ggroups_max_order_by,
        Ggroups_min_order_by,
        Ggroups_obj_rel_insert_input,
        Ggroups_on_conflict,
        Ggroups_order_by,
        Ggroups_pk_columns_input,
        Ggroups_select_column,
        Ggroups_set_input,
        Ggroups_update_column,
        Gorder_by,
        Grefresh_tokens_aggregate_order_by,
        Grefresh_tokens_arr_rel_insert_input,
        Grefresh_tokens_bool_exp,
        Grefresh_tokens_constraint,
        Grefresh_tokens_insert_input,
        Grefresh_tokens_max_order_by,
        Grefresh_tokens_min_order_by,
        Grefresh_tokens_obj_rel_insert_input,
        Grefresh_tokens_on_conflict,
        Grefresh_tokens_order_by,
        Grefresh_tokens_pk_columns_input,
        Grefresh_tokens_select_column,
        Grefresh_tokens_set_input,
        Grefresh_tokens_update_column,
        Guser_to_groups_aggregate_order_by,
        Guser_to_groups_arr_rel_insert_input,
        Guser_to_groups_bool_exp,
        Guser_to_groups_constraint,
        Guser_to_groups_insert_input,
        Guser_to_groups_max_order_by,
        Guser_to_groups_min_order_by,
        Guser_to_groups_obj_rel_insert_input,
        Guser_to_groups_on_conflict,
        Guser_to_groups_order_by,
        Guser_to_groups_pk_columns_input,
        Guser_to_groups_select_column,
        Guser_to_groups_set_input,
        Guser_to_groups_update_column,
        Gusers_aggregate_order_by,
        Gusers_arr_rel_insert_input,
        Gusers_bool_exp,
        Gusers_constraint,
        Gusers_insert_input,
        Gusers_max_order_by,
        Gusers_min_order_by,
        Gusers_obj_rel_insert_input,
        Gusers_on_conflict,
        Gusers_order_by,
        Gusers_pk_columns_input,
        Gusers_select_column,
        Gusers_set_input,
        Gusers_update_column,
        Guuid_comparison_exp;
import 'package:fe/gql/update_group_join_token.req.gql.dart'
    show GUpdateGroupJoinTokenReq;
import 'package:fe/gql/update_group_join_token.var.gql.dart'
    show GUpdateGroupJoinTokenVars;
import 'package:fe/gql/update_self_name.data.gql.dart'
    show GUpdateSelfNameData, GUpdateSelfNameData_update_users_by_pk;
import 'package:fe/gql/update_self_name.req.gql.dart' show GUpdateSelfNameReq;
import 'package:fe/gql/update_self_name.var.gql.dart' show GUpdateSelfNameVars;
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(UuidTypeSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GQueryGroupJoinTokenReq,
  GQueryGroupJoinTokenVars,
  GQuerySelfGroupsPreviewReq,
  GQuerySelfGroupsPreviewVars,
  GQueryUsersInGroupReq,
  GQueryUsersInGroupVars,
  GRemoveSelfFromGroupReq,
  GRemoveSelfFromGroupVars,
  GString_comparison_exp,
  GUpdateGroupJoinTokenReq,
  GUpdateGroupJoinTokenVars,
  GUpdateSelfNameData,
  GUpdateSelfNameData_update_users_by_pk,
  GUpdateSelfNameReq,
  GUpdateSelfNameVars,
  Ggroups_aggregate_order_by,
  Ggroups_arr_rel_insert_input,
  Ggroups_bool_exp,
  Ggroups_constraint,
  Ggroups_insert_input,
  Ggroups_max_order_by,
  Ggroups_min_order_by,
  Ggroups_obj_rel_insert_input,
  Ggroups_on_conflict,
  Ggroups_order_by,
  Ggroups_pk_columns_input,
  Ggroups_select_column,
  Ggroups_set_input,
  Ggroups_update_column,
  Gorder_by,
  Grefresh_tokens_aggregate_order_by,
  Grefresh_tokens_arr_rel_insert_input,
  Grefresh_tokens_bool_exp,
  Grefresh_tokens_constraint,
  Grefresh_tokens_insert_input,
  Grefresh_tokens_max_order_by,
  Grefresh_tokens_min_order_by,
  Grefresh_tokens_obj_rel_insert_input,
  Grefresh_tokens_on_conflict,
  Grefresh_tokens_order_by,
  Grefresh_tokens_pk_columns_input,
  Grefresh_tokens_select_column,
  Grefresh_tokens_set_input,
  Grefresh_tokens_update_column,
  Guser_to_groups_aggregate_order_by,
  Guser_to_groups_arr_rel_insert_input,
  Guser_to_groups_bool_exp,
  Guser_to_groups_constraint,
  Guser_to_groups_insert_input,
  Guser_to_groups_max_order_by,
  Guser_to_groups_min_order_by,
  Guser_to_groups_obj_rel_insert_input,
  Guser_to_groups_on_conflict,
  Guser_to_groups_order_by,
  Guser_to_groups_pk_columns_input,
  Guser_to_groups_select_column,
  Guser_to_groups_set_input,
  Guser_to_groups_update_column,
  Gusers_aggregate_order_by,
  Gusers_arr_rel_insert_input,
  Gusers_bool_exp,
  Gusers_constraint,
  Gusers_insert_input,
  Gusers_max_order_by,
  Gusers_min_order_by,
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
