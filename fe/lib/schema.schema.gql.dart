// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fe/serializers.gql.dart' as _i1;
import 'package:fe/stdlib/helpers/uuid_type.dart' as _i2;

part 'schema.schema.gql.g.dart';

abstract class GBoolean_comparison_exp
    implements Built<GBoolean_comparison_exp, GBoolean_comparison_expBuilder> {
  GBoolean_comparison_exp._();

  factory GBoolean_comparison_exp(
          [Function(GBoolean_comparison_expBuilder b) updates]) =
      _$GBoolean_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  bool? get G_eq;
  @BuiltValueField(wireName: '_gt')
  bool? get G_gt;
  @BuiltValueField(wireName: '_gte')
  bool? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<bool>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  bool? get G_lt;
  @BuiltValueField(wireName: '_lte')
  bool? get G_lte;
  @BuiltValueField(wireName: '_neq')
  bool? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<bool>? get G_nin;
  static Serializer<GBoolean_comparison_exp> get serializer =>
      _$gBooleanComparisonExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GBoolean_comparison_exp.serializer, this)
          as Map<String, dynamic>);
  static GBoolean_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GBoolean_comparison_exp.serializer, json);
}

abstract class Ggroup_join_tokens_aggregate_order_by
    implements
        Built<Ggroup_join_tokens_aggregate_order_by,
            Ggroup_join_tokens_aggregate_order_byBuilder> {
  Ggroup_join_tokens_aggregate_order_by._();

  factory Ggroup_join_tokens_aggregate_order_by(
          [Function(Ggroup_join_tokens_aggregate_order_byBuilder b) updates]) =
      _$Ggroup_join_tokens_aggregate_order_by;

  Gorder_by? get count;
  Ggroup_join_tokens_max_order_by? get max;
  Ggroup_join_tokens_min_order_by? get min;
  static Serializer<Ggroup_join_tokens_aggregate_order_by> get serializer =>
      _$ggroupJoinTokensAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_join_tokens_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_join_tokens_aggregate_order_by.serializer, json);
}

abstract class Ggroup_join_tokens_arr_rel_insert_input
    implements
        Built<Ggroup_join_tokens_arr_rel_insert_input,
            Ggroup_join_tokens_arr_rel_insert_inputBuilder> {
  Ggroup_join_tokens_arr_rel_insert_input._();

  factory Ggroup_join_tokens_arr_rel_insert_input(
      [Function(Ggroup_join_tokens_arr_rel_insert_inputBuilder b)
          updates]) = _$Ggroup_join_tokens_arr_rel_insert_input;

  BuiltList<Ggroup_join_tokens_insert_input> get data;
  Ggroup_join_tokens_on_conflict? get on_conflict;
  static Serializer<Ggroup_join_tokens_arr_rel_insert_input> get serializer =>
      _$ggroupJoinTokensArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          Ggroup_join_tokens_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_join_tokens_arr_rel_insert_input.serializer, json);
}

abstract class Ggroup_join_tokens_bool_exp
    implements
        Built<Ggroup_join_tokens_bool_exp, Ggroup_join_tokens_bool_expBuilder> {
  Ggroup_join_tokens_bool_exp._();

  factory Ggroup_join_tokens_bool_exp(
          [Function(Ggroup_join_tokens_bool_expBuilder b) updates]) =
      _$Ggroup_join_tokens_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Ggroup_join_tokens_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Ggroup_join_tokens_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Ggroup_join_tokens_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  GString_comparison_exp? get join_token;
  static Serializer<Ggroup_join_tokens_bool_exp> get serializer =>
      _$ggroupJoinTokensBoolExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_join_tokens_bool_exp.serializer, this) as Map<String, dynamic>);
  static Ggroup_join_tokens_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_bool_exp.serializer, json);
}

class Ggroup_join_tokens_constraint extends EnumClass {
  const Ggroup_join_tokens_constraint._(String name) : super(name);

  static const Ggroup_join_tokens_constraint group_join_tokens_group_id_key =
      _$ggroupJoinTokensConstraintgroup_join_tokens_group_id_key;

  static const Ggroup_join_tokens_constraint group_join_tokens_pkey =
      _$ggroupJoinTokensConstraintgroup_join_tokens_pkey;

  static Serializer<Ggroup_join_tokens_constraint> get serializer =>
      _$ggroupJoinTokensConstraintSerializer;
  static BuiltSet<Ggroup_join_tokens_constraint> get values =>
      _$ggroupJoinTokensConstraintValues;
  static Ggroup_join_tokens_constraint valueOf(String name) =>
      _$ggroupJoinTokensConstraintValueOf(name);
}

abstract class Ggroup_join_tokens_insert_input
    implements
        Built<Ggroup_join_tokens_insert_input,
            Ggroup_join_tokens_insert_inputBuilder> {
  Ggroup_join_tokens_insert_input._();

  factory Ggroup_join_tokens_insert_input(
          [Function(Ggroup_join_tokens_insert_inputBuilder b) updates]) =
      _$Ggroup_join_tokens_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  String? get join_token;
  static Serializer<Ggroup_join_tokens_insert_input> get serializer =>
      _$ggroupJoinTokensInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_join_tokens_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_insert_input.serializer, json);
}

abstract class Ggroup_join_tokens_max_order_by
    implements
        Built<Ggroup_join_tokens_max_order_by,
            Ggroup_join_tokens_max_order_byBuilder> {
  Ggroup_join_tokens_max_order_by._();

  factory Ggroup_join_tokens_max_order_by(
          [Function(Ggroup_join_tokens_max_order_byBuilder b) updates]) =
      _$Ggroup_join_tokens_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get join_token;
  static Serializer<Ggroup_join_tokens_max_order_by> get serializer =>
      _$ggroupJoinTokensMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_join_tokens_max_order_by.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_max_order_by.serializer, json);
}

abstract class Ggroup_join_tokens_min_order_by
    implements
        Built<Ggroup_join_tokens_min_order_by,
            Ggroup_join_tokens_min_order_byBuilder> {
  Ggroup_join_tokens_min_order_by._();

  factory Ggroup_join_tokens_min_order_by(
          [Function(Ggroup_join_tokens_min_order_byBuilder b) updates]) =
      _$Ggroup_join_tokens_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get join_token;
  static Serializer<Ggroup_join_tokens_min_order_by> get serializer =>
      _$ggroupJoinTokensMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_join_tokens_min_order_by.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_min_order_by.serializer, json);
}

abstract class Ggroup_join_tokens_on_conflict
    implements
        Built<Ggroup_join_tokens_on_conflict,
            Ggroup_join_tokens_on_conflictBuilder> {
  Ggroup_join_tokens_on_conflict._();

  factory Ggroup_join_tokens_on_conflict(
          [Function(Ggroup_join_tokens_on_conflictBuilder b) updates]) =
      _$Ggroup_join_tokens_on_conflict;

  Ggroup_join_tokens_constraint get constraint;
  BuiltList<Ggroup_join_tokens_update_column> get update_columns;
  Ggroup_join_tokens_bool_exp? get where;
  static Serializer<Ggroup_join_tokens_on_conflict> get serializer =>
      _$ggroupJoinTokensOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_join_tokens_on_conflict.serializer, this) as Map<String, dynamic>);
  static Ggroup_join_tokens_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_on_conflict.serializer, json);
}

abstract class Ggroup_join_tokens_order_by
    implements
        Built<Ggroup_join_tokens_order_by, Ggroup_join_tokens_order_byBuilder> {
  Ggroup_join_tokens_order_by._();

  factory Ggroup_join_tokens_order_by(
          [Function(Ggroup_join_tokens_order_byBuilder b) updates]) =
      _$Ggroup_join_tokens_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get join_token;
  static Serializer<Ggroup_join_tokens_order_by> get serializer =>
      _$ggroupJoinTokensOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_join_tokens_order_by.serializer, this) as Map<String, dynamic>);
  static Ggroup_join_tokens_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_order_by.serializer, json);
}

abstract class Ggroup_join_tokens_pk_columns_input
    implements
        Built<Ggroup_join_tokens_pk_columns_input,
            Ggroup_join_tokens_pk_columns_inputBuilder> {
  Ggroup_join_tokens_pk_columns_input._();

  factory Ggroup_join_tokens_pk_columns_input(
          [Function(Ggroup_join_tokens_pk_columns_inputBuilder b) updates]) =
      _$Ggroup_join_tokens_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Ggroup_join_tokens_pk_columns_input> get serializer =>
      _$ggroupJoinTokensPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_join_tokens_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_join_tokens_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_join_tokens_pk_columns_input.serializer, json);
}

class Ggroup_join_tokens_select_column extends EnumClass {
  const Ggroup_join_tokens_select_column._(String name) : super(name);

  static const Ggroup_join_tokens_select_column group_id =
      _$ggroupJoinTokensSelectColumngroup_id;

  static const Ggroup_join_tokens_select_column id =
      _$ggroupJoinTokensSelectColumnid;

  static const Ggroup_join_tokens_select_column join_token =
      _$ggroupJoinTokensSelectColumnjoin_token;

  static Serializer<Ggroup_join_tokens_select_column> get serializer =>
      _$ggroupJoinTokensSelectColumnSerializer;
  static BuiltSet<Ggroup_join_tokens_select_column> get values =>
      _$ggroupJoinTokensSelectColumnValues;
  static Ggroup_join_tokens_select_column valueOf(String name) =>
      _$ggroupJoinTokensSelectColumnValueOf(name);
}

abstract class Ggroup_join_tokens_set_input
    implements
        Built<Ggroup_join_tokens_set_input,
            Ggroup_join_tokens_set_inputBuilder> {
  Ggroup_join_tokens_set_input._();

  factory Ggroup_join_tokens_set_input(
          [Function(Ggroup_join_tokens_set_inputBuilder b) updates]) =
      _$Ggroup_join_tokens_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  String? get join_token;
  static Serializer<Ggroup_join_tokens_set_input> get serializer =>
      _$ggroupJoinTokensSetInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_join_tokens_set_input.serializer, this) as Map<String, dynamic>);
  static Ggroup_join_tokens_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_join_tokens_set_input.serializer, json);
}

class Ggroup_join_tokens_update_column extends EnumClass {
  const Ggroup_join_tokens_update_column._(String name) : super(name);

  static const Ggroup_join_tokens_update_column group_id =
      _$ggroupJoinTokensUpdateColumngroup_id;

  static const Ggroup_join_tokens_update_column id =
      _$ggroupJoinTokensUpdateColumnid;

  static const Ggroup_join_tokens_update_column join_token =
      _$ggroupJoinTokensUpdateColumnjoin_token;

  static Serializer<Ggroup_join_tokens_update_column> get serializer =>
      _$ggroupJoinTokensUpdateColumnSerializer;
  static BuiltSet<Ggroup_join_tokens_update_column> get values =>
      _$ggroupJoinTokensUpdateColumnValues;
  static Ggroup_join_tokens_update_column valueOf(String name) =>
      _$ggroupJoinTokensUpdateColumnValueOf(name);
}

abstract class Ggroup_threads_aggregate_order_by
    implements
        Built<Ggroup_threads_aggregate_order_by,
            Ggroup_threads_aggregate_order_byBuilder> {
  Ggroup_threads_aggregate_order_by._();

  factory Ggroup_threads_aggregate_order_by(
          [Function(Ggroup_threads_aggregate_order_byBuilder b) updates]) =
      _$Ggroup_threads_aggregate_order_by;

  Gorder_by? get count;
  Ggroup_threads_max_order_by? get max;
  Ggroup_threads_min_order_by? get min;
  static Serializer<Ggroup_threads_aggregate_order_by> get serializer =>
      _$ggroupThreadsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_threads_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_threads_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_aggregate_order_by.serializer, json);
}

abstract class Ggroup_threads_arr_rel_insert_input
    implements
        Built<Ggroup_threads_arr_rel_insert_input,
            Ggroup_threads_arr_rel_insert_inputBuilder> {
  Ggroup_threads_arr_rel_insert_input._();

  factory Ggroup_threads_arr_rel_insert_input(
          [Function(Ggroup_threads_arr_rel_insert_inputBuilder b) updates]) =
      _$Ggroup_threads_arr_rel_insert_input;

  BuiltList<Ggroup_threads_insert_input> get data;
  Ggroup_threads_on_conflict? get on_conflict;
  static Serializer<Ggroup_threads_arr_rel_insert_input> get serializer =>
      _$ggroupThreadsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_threads_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_threads_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_threads_arr_rel_insert_input.serializer, json);
}

abstract class Ggroup_threads_bool_exp
    implements Built<Ggroup_threads_bool_exp, Ggroup_threads_bool_expBuilder> {
  Ggroup_threads_bool_exp._();

  factory Ggroup_threads_bool_exp(
          [Function(Ggroup_threads_bool_expBuilder b) updates]) =
      _$Ggroup_threads_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Ggroup_threads_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Ggroup_threads_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Ggroup_threads_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  Gmessages_bool_exp? get messages;
  GString_comparison_exp? get name;
  Guser_to_thread_bool_exp? get user_to_threads;
  static Serializer<Ggroup_threads_bool_exp> get serializer =>
      _$ggroupThreadsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_threads_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_threads_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroup_threads_bool_exp.serializer, json);
}

class Ggroup_threads_constraint extends EnumClass {
  const Ggroup_threads_constraint._(String name) : super(name);

  static const Ggroup_threads_constraint group_threads_pkey =
      _$ggroupThreadsConstraintgroup_threads_pkey;

  static Serializer<Ggroup_threads_constraint> get serializer =>
      _$ggroupThreadsConstraintSerializer;
  static BuiltSet<Ggroup_threads_constraint> get values =>
      _$ggroupThreadsConstraintValues;
  static Ggroup_threads_constraint valueOf(String name) =>
      _$ggroupThreadsConstraintValueOf(name);
}

abstract class Ggroup_threads_insert_input
    implements
        Built<Ggroup_threads_insert_input, Ggroup_threads_insert_inputBuilder> {
  Ggroup_threads_insert_input._();

  factory Ggroup_threads_insert_input(
          [Function(Ggroup_threads_insert_inputBuilder b) updates]) =
      _$Ggroup_threads_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  Gmessages_arr_rel_insert_input? get messages;
  String? get name;
  Guser_to_thread_arr_rel_insert_input? get user_to_threads;
  static Serializer<Ggroup_threads_insert_input> get serializer =>
      _$ggroupThreadsInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_threads_insert_input.serializer, this) as Map<String, dynamic>);
  static Ggroup_threads_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_insert_input.serializer, json);
}

abstract class Ggroup_threads_max_order_by
    implements
        Built<Ggroup_threads_max_order_by, Ggroup_threads_max_order_byBuilder> {
  Ggroup_threads_max_order_by._();

  factory Ggroup_threads_max_order_by(
          [Function(Ggroup_threads_max_order_byBuilder b) updates]) =
      _$Ggroup_threads_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Ggroup_threads_max_order_by> get serializer =>
      _$ggroupThreadsMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_threads_max_order_by.serializer, this) as Map<String, dynamic>);
  static Ggroup_threads_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_max_order_by.serializer, json);
}

abstract class Ggroup_threads_min_order_by
    implements
        Built<Ggroup_threads_min_order_by, Ggroup_threads_min_order_byBuilder> {
  Ggroup_threads_min_order_by._();

  factory Ggroup_threads_min_order_by(
          [Function(Ggroup_threads_min_order_byBuilder b) updates]) =
      _$Ggroup_threads_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Ggroup_threads_min_order_by> get serializer =>
      _$ggroupThreadsMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_threads_min_order_by.serializer, this) as Map<String, dynamic>);
  static Ggroup_threads_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_min_order_by.serializer, json);
}

abstract class Ggroup_threads_obj_rel_insert_input
    implements
        Built<Ggroup_threads_obj_rel_insert_input,
            Ggroup_threads_obj_rel_insert_inputBuilder> {
  Ggroup_threads_obj_rel_insert_input._();

  factory Ggroup_threads_obj_rel_insert_input(
          [Function(Ggroup_threads_obj_rel_insert_inputBuilder b) updates]) =
      _$Ggroup_threads_obj_rel_insert_input;

  Ggroup_threads_insert_input get data;
  Ggroup_threads_on_conflict? get on_conflict;
  static Serializer<Ggroup_threads_obj_rel_insert_input> get serializer =>
      _$ggroupThreadsObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_threads_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_threads_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_threads_obj_rel_insert_input.serializer, json);
}

abstract class Ggroup_threads_on_conflict
    implements
        Built<Ggroup_threads_on_conflict, Ggroup_threads_on_conflictBuilder> {
  Ggroup_threads_on_conflict._();

  factory Ggroup_threads_on_conflict(
          [Function(Ggroup_threads_on_conflictBuilder b) updates]) =
      _$Ggroup_threads_on_conflict;

  Ggroup_threads_constraint get constraint;
  BuiltList<Ggroup_threads_update_column> get update_columns;
  Ggroup_threads_bool_exp? get where;
  static Serializer<Ggroup_threads_on_conflict> get serializer =>
      _$ggroupThreadsOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_threads_on_conflict.serializer, this) as Map<String, dynamic>);
  static Ggroup_threads_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_on_conflict.serializer, json);
}

abstract class Ggroup_threads_order_by
    implements Built<Ggroup_threads_order_by, Ggroup_threads_order_byBuilder> {
  Ggroup_threads_order_by._();

  factory Ggroup_threads_order_by(
          [Function(Ggroup_threads_order_byBuilder b) updates]) =
      _$Ggroup_threads_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gmessages_aggregate_order_by? get messages_aggregate;
  Gorder_by? get name;
  Guser_to_thread_aggregate_order_by? get user_to_threads_aggregate;
  static Serializer<Ggroup_threads_order_by> get serializer =>
      _$ggroupThreadsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_threads_order_by.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_threads_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroup_threads_order_by.serializer, json);
}

abstract class Ggroup_threads_pk_columns_input
    implements
        Built<Ggroup_threads_pk_columns_input,
            Ggroup_threads_pk_columns_inputBuilder> {
  Ggroup_threads_pk_columns_input._();

  factory Ggroup_threads_pk_columns_input(
          [Function(Ggroup_threads_pk_columns_inputBuilder b) updates]) =
      _$Ggroup_threads_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Ggroup_threads_pk_columns_input> get serializer =>
      _$ggroupThreadsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_threads_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_threads_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_pk_columns_input.serializer, json);
}

class Ggroup_threads_select_column extends EnumClass {
  const Ggroup_threads_select_column._(String name) : super(name);

  static const Ggroup_threads_select_column group_id =
      _$ggroupThreadsSelectColumngroup_id;

  static const Ggroup_threads_select_column id = _$ggroupThreadsSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Ggroup_threads_select_column Gname =
      _$ggroupThreadsSelectColumnGname;

  static Serializer<Ggroup_threads_select_column> get serializer =>
      _$ggroupThreadsSelectColumnSerializer;
  static BuiltSet<Ggroup_threads_select_column> get values =>
      _$ggroupThreadsSelectColumnValues;
  static Ggroup_threads_select_column valueOf(String name) =>
      _$ggroupThreadsSelectColumnValueOf(name);
}

abstract class Ggroup_threads_set_input
    implements
        Built<Ggroup_threads_set_input, Ggroup_threads_set_inputBuilder> {
  Ggroup_threads_set_input._();

  factory Ggroup_threads_set_input(
          [Function(Ggroup_threads_set_inputBuilder b) updates]) =
      _$Ggroup_threads_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  String? get name;
  static Serializer<Ggroup_threads_set_input> get serializer =>
      _$ggroupThreadsSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_threads_set_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_threads_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_threads_set_input.serializer, json);
}

class Ggroup_threads_update_column extends EnumClass {
  const Ggroup_threads_update_column._(String name) : super(name);

  static const Ggroup_threads_update_column group_id =
      _$ggroupThreadsUpdateColumngroup_id;

  static const Ggroup_threads_update_column id = _$ggroupThreadsUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Ggroup_threads_update_column Gname =
      _$ggroupThreadsUpdateColumnGname;

  static Serializer<Ggroup_threads_update_column> get serializer =>
      _$ggroupThreadsUpdateColumnSerializer;
  static BuiltSet<Ggroup_threads_update_column> get values =>
      _$ggroupThreadsUpdateColumnValues;
  static Ggroup_threads_update_column valueOf(String name) =>
      _$ggroupThreadsUpdateColumnValueOf(name);
}

abstract class Ggroups_bool_exp
    implements Built<Ggroups_bool_exp, Ggroups_bool_expBuilder> {
  Ggroups_bool_exp._();

  factory Ggroups_bool_exp([Function(Ggroups_bool_expBuilder b) updates]) =
      _$Ggroups_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Ggroups_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Ggroups_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Ggroups_bool_exp>? get G_or;
  Ggroup_join_tokens_bool_exp? get group_join_tokens;
  GString_comparison_exp? get group_name;
  Ggroup_threads_bool_exp? get group_threads;
  Guuid_comparison_exp? get id;
  Guser_to_group_bool_exp? get user_to_groups;
  static Serializer<Ggroups_bool_exp> get serializer =>
      _$ggroupsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_bool_exp.serializer, json);
}

class Ggroups_constraint extends EnumClass {
  const Ggroups_constraint._(String name) : super(name);

  static const Ggroups_constraint groups_pkey = _$ggroupsConstraintgroups_pkey;

  static Serializer<Ggroups_constraint> get serializer =>
      _$ggroupsConstraintSerializer;
  static BuiltSet<Ggroups_constraint> get values => _$ggroupsConstraintValues;
  static Ggroups_constraint valueOf(String name) =>
      _$ggroupsConstraintValueOf(name);
}

abstract class Ggroups_insert_input
    implements Built<Ggroups_insert_input, Ggroups_insert_inputBuilder> {
  Ggroups_insert_input._();

  factory Ggroups_insert_input(
          [Function(Ggroups_insert_inputBuilder b) updates]) =
      _$Ggroups_insert_input;

  Ggroup_join_tokens_arr_rel_insert_input? get group_join_tokens;
  String? get group_name;
  Ggroup_threads_arr_rel_insert_input? get group_threads;
  _i2.UuidType? get id;
  Guser_to_group_arr_rel_insert_input? get user_to_groups;
  static Serializer<Ggroups_insert_input> get serializer =>
      _$ggroupsInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_insert_input.serializer, json);
}

abstract class Ggroups_obj_rel_insert_input
    implements
        Built<Ggroups_obj_rel_insert_input,
            Ggroups_obj_rel_insert_inputBuilder> {
  Ggroups_obj_rel_insert_input._();

  factory Ggroups_obj_rel_insert_input(
          [Function(Ggroups_obj_rel_insert_inputBuilder b) updates]) =
      _$Ggroups_obj_rel_insert_input;

  Ggroups_insert_input get data;
  Ggroups_on_conflict? get on_conflict;
  static Serializer<Ggroups_obj_rel_insert_input> get serializer =>
      _$ggroupsObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroups_obj_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Ggroups_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroups_obj_rel_insert_input.serializer, json);
}

abstract class Ggroups_on_conflict
    implements Built<Ggroups_on_conflict, Ggroups_on_conflictBuilder> {
  Ggroups_on_conflict._();

  factory Ggroups_on_conflict(
      [Function(Ggroups_on_conflictBuilder b) updates]) = _$Ggroups_on_conflict;

  Ggroups_constraint get constraint;
  BuiltList<Ggroups_update_column> get update_columns;
  Ggroups_bool_exp? get where;
  static Serializer<Ggroups_on_conflict> get serializer =>
      _$ggroupsOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_on_conflict.serializer, json);
}

abstract class Ggroups_order_by
    implements Built<Ggroups_order_by, Ggroups_order_byBuilder> {
  Ggroups_order_by._();

  factory Ggroups_order_by([Function(Ggroups_order_byBuilder b) updates]) =
      _$Ggroups_order_by;

  Ggroup_join_tokens_aggregate_order_by? get group_join_tokens_aggregate;
  Gorder_by? get group_name;
  Ggroup_threads_aggregate_order_by? get group_threads_aggregate;
  Gorder_by? get id;
  Guser_to_group_aggregate_order_by? get user_to_groups_aggregate;
  static Serializer<Ggroups_order_by> get serializer =>
      _$ggroupsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_order_by.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_order_by.serializer, json);
}

abstract class Ggroups_pk_columns_input
    implements
        Built<Ggroups_pk_columns_input, Ggroups_pk_columns_inputBuilder> {
  Ggroups_pk_columns_input._();

  factory Ggroups_pk_columns_input(
          [Function(Ggroups_pk_columns_inputBuilder b) updates]) =
      _$Ggroups_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Ggroups_pk_columns_input> get serializer =>
      _$ggroupsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_pk_columns_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroups_pk_columns_input.serializer, json);
}

class Ggroups_select_column extends EnumClass {
  const Ggroups_select_column._(String name) : super(name);

  static const Ggroups_select_column group_name =
      _$ggroupsSelectColumngroup_name;

  static const Ggroups_select_column id = _$ggroupsSelectColumnid;

  static Serializer<Ggroups_select_column> get serializer =>
      _$ggroupsSelectColumnSerializer;
  static BuiltSet<Ggroups_select_column> get values =>
      _$ggroupsSelectColumnValues;
  static Ggroups_select_column valueOf(String name) =>
      _$ggroupsSelectColumnValueOf(name);
}

abstract class Ggroups_set_input
    implements Built<Ggroups_set_input, Ggroups_set_inputBuilder> {
  Ggroups_set_input._();

  factory Ggroups_set_input([Function(Ggroups_set_inputBuilder b) updates]) =
      _$Ggroups_set_input;

  String? get group_name;
  _i2.UuidType? get id;
  static Serializer<Ggroups_set_input> get serializer =>
      _$ggroupsSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_set_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_set_input.serializer, json);
}

class Ggroups_update_column extends EnumClass {
  const Ggroups_update_column._(String name) : super(name);

  static const Ggroups_update_column group_name =
      _$ggroupsUpdateColumngroup_name;

  static const Ggroups_update_column id = _$ggroupsUpdateColumnid;

  static Serializer<Ggroups_update_column> get serializer =>
      _$ggroupsUpdateColumnSerializer;
  static BuiltSet<Ggroups_update_column> get values =>
      _$ggroupsUpdateColumnValues;
  static Ggroups_update_column valueOf(String name) =>
      _$ggroupsUpdateColumnValueOf(name);
}

abstract class Gmessages_aggregate_order_by
    implements
        Built<Gmessages_aggregate_order_by,
            Gmessages_aggregate_order_byBuilder> {
  Gmessages_aggregate_order_by._();

  factory Gmessages_aggregate_order_by(
          [Function(Gmessages_aggregate_order_byBuilder b) updates]) =
      _$Gmessages_aggregate_order_by;

  Gorder_by? get count;
  Gmessages_max_order_by? get max;
  Gmessages_min_order_by? get min;
  static Serializer<Gmessages_aggregate_order_by> get serializer =>
      _$gmessagesAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessages_aggregate_order_by.serializer, this) as Map<String, dynamic>);
  static Gmessages_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessages_aggregate_order_by.serializer, json);
}

abstract class Gmessages_arr_rel_insert_input
    implements
        Built<Gmessages_arr_rel_insert_input,
            Gmessages_arr_rel_insert_inputBuilder> {
  Gmessages_arr_rel_insert_input._();

  factory Gmessages_arr_rel_insert_input(
          [Function(Gmessages_arr_rel_insert_inputBuilder b) updates]) =
      _$Gmessages_arr_rel_insert_input;

  BuiltList<Gmessages_insert_input> get data;
  Gmessages_on_conflict? get on_conflict;
  static Serializer<Gmessages_arr_rel_insert_input> get serializer =>
      _$gmessagesArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessages_arr_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gmessages_arr_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessages_arr_rel_insert_input.serializer, json);
}

abstract class Gmessages_bool_exp
    implements Built<Gmessages_bool_exp, Gmessages_bool_expBuilder> {
  Gmessages_bool_exp._();

  factory Gmessages_bool_exp([Function(Gmessages_bool_expBuilder b) updates]) =
      _$Gmessages_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gmessages_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gmessages_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gmessages_bool_exp>? get G_or;
  Gtimestamptz_comparison_exp? get created_at;
  GBoolean_comparison_exp? get deleted;
  Ggroup_threads_bool_exp? get group_thread;
  Guuid_comparison_exp? get id;
  GBoolean_comparison_exp? get is_image;
  GString_comparison_exp? get message;
  Guuid_comparison_exp? get thread_id;
  Gtimestamptz_comparison_exp? get updated_at;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_sent;
  static Serializer<Gmessages_bool_exp> get serializer =>
      _$gmessagesBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_bool_exp.serializer, json);
}

class Gmessages_constraint extends EnumClass {
  const Gmessages_constraint._(String name) : super(name);

  static const Gmessages_constraint messages_pkey =
      _$gmessagesConstraintmessages_pkey;

  static Serializer<Gmessages_constraint> get serializer =>
      _$gmessagesConstraintSerializer;
  static BuiltSet<Gmessages_constraint> get values =>
      _$gmessagesConstraintValues;
  static Gmessages_constraint valueOf(String name) =>
      _$gmessagesConstraintValueOf(name);
}

abstract class Gmessages_insert_input
    implements Built<Gmessages_insert_input, Gmessages_insert_inputBuilder> {
  Gmessages_insert_input._();

  factory Gmessages_insert_input(
          [Function(Gmessages_insert_inputBuilder b) updates]) =
      _$Gmessages_insert_input;

  DateTime? get created_at;
  bool? get deleted;
  Ggroup_threads_obj_rel_insert_input? get group_thread;
  _i2.UuidType? get id;
  bool? get is_image;
  String? get message;
  _i2.UuidType? get thread_id;
  DateTime? get updated_at;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_sent;
  static Serializer<Gmessages_insert_input> get serializer =>
      _$gmessagesInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_insert_input.serializer, json);
}

abstract class Gmessages_max_order_by
    implements Built<Gmessages_max_order_by, Gmessages_max_order_byBuilder> {
  Gmessages_max_order_by._();

  factory Gmessages_max_order_by(
          [Function(Gmessages_max_order_byBuilder b) updates]) =
      _$Gmessages_max_order_by;

  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get message;
  Gorder_by? get thread_id;
  Gorder_by? get updated_at;
  Gorder_by? get user_sent;
  static Serializer<Gmessages_max_order_by> get serializer =>
      _$gmessagesMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_max_order_by.serializer, json);
}

abstract class Gmessages_min_order_by
    implements Built<Gmessages_min_order_by, Gmessages_min_order_byBuilder> {
  Gmessages_min_order_by._();

  factory Gmessages_min_order_by(
          [Function(Gmessages_min_order_byBuilder b) updates]) =
      _$Gmessages_min_order_by;

  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get message;
  Gorder_by? get thread_id;
  Gorder_by? get updated_at;
  Gorder_by? get user_sent;
  static Serializer<Gmessages_min_order_by> get serializer =>
      _$gmessagesMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_min_order_by.serializer, json);
}

abstract class Gmessages_on_conflict
    implements Built<Gmessages_on_conflict, Gmessages_on_conflictBuilder> {
  Gmessages_on_conflict._();

  factory Gmessages_on_conflict(
          [Function(Gmessages_on_conflictBuilder b) updates]) =
      _$Gmessages_on_conflict;

  Gmessages_constraint get constraint;
  BuiltList<Gmessages_update_column> get update_columns;
  Gmessages_bool_exp? get where;
  static Serializer<Gmessages_on_conflict> get serializer =>
      _$gmessagesOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_on_conflict.serializer, json);
}

abstract class Gmessages_order_by
    implements Built<Gmessages_order_by, Gmessages_order_byBuilder> {
  Gmessages_order_by._();

  factory Gmessages_order_by([Function(Gmessages_order_byBuilder b) updates]) =
      _$Gmessages_order_by;

  Gorder_by? get created_at;
  Gorder_by? get deleted;
  Ggroup_threads_order_by? get group_thread;
  Gorder_by? get id;
  Gorder_by? get is_image;
  Gorder_by? get message;
  Gorder_by? get thread_id;
  Gorder_by? get updated_at;
  Gusers_order_by? get user;
  Gorder_by? get user_sent;
  static Serializer<Gmessages_order_by> get serializer =>
      _$gmessagesOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_order_by.serializer, json);
}

abstract class Gmessages_pk_columns_input
    implements
        Built<Gmessages_pk_columns_input, Gmessages_pk_columns_inputBuilder> {
  Gmessages_pk_columns_input._();

  factory Gmessages_pk_columns_input(
          [Function(Gmessages_pk_columns_inputBuilder b) updates]) =
      _$Gmessages_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Gmessages_pk_columns_input> get serializer =>
      _$gmessagesPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessages_pk_columns_input.serializer, this) as Map<String, dynamic>);
  static Gmessages_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessages_pk_columns_input.serializer, json);
}

class Gmessages_select_column extends EnumClass {
  const Gmessages_select_column._(String name) : super(name);

  static const Gmessages_select_column created_at =
      _$gmessagesSelectColumncreated_at;

  static const Gmessages_select_column deleted = _$gmessagesSelectColumndeleted;

  static const Gmessages_select_column id = _$gmessagesSelectColumnid;

  static const Gmessages_select_column is_image =
      _$gmessagesSelectColumnis_image;

  static const Gmessages_select_column message = _$gmessagesSelectColumnmessage;

  static const Gmessages_select_column thread_id =
      _$gmessagesSelectColumnthread_id;

  static const Gmessages_select_column updated_at =
      _$gmessagesSelectColumnupdated_at;

  static const Gmessages_select_column user_sent =
      _$gmessagesSelectColumnuser_sent;

  static Serializer<Gmessages_select_column> get serializer =>
      _$gmessagesSelectColumnSerializer;
  static BuiltSet<Gmessages_select_column> get values =>
      _$gmessagesSelectColumnValues;
  static Gmessages_select_column valueOf(String name) =>
      _$gmessagesSelectColumnValueOf(name);
}

abstract class Gmessages_set_input
    implements Built<Gmessages_set_input, Gmessages_set_inputBuilder> {
  Gmessages_set_input._();

  factory Gmessages_set_input(
      [Function(Gmessages_set_inputBuilder b) updates]) = _$Gmessages_set_input;

  DateTime? get created_at;
  bool? get deleted;
  _i2.UuidType? get id;
  bool? get is_image;
  String? get message;
  _i2.UuidType? get thread_id;
  DateTime? get updated_at;
  _i2.UuidType? get user_sent;
  static Serializer<Gmessages_set_input> get serializer =>
      _$gmessagesSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessages_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gmessages_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessages_set_input.serializer, json);
}

class Gmessages_update_column extends EnumClass {
  const Gmessages_update_column._(String name) : super(name);

  static const Gmessages_update_column created_at =
      _$gmessagesUpdateColumncreated_at;

  static const Gmessages_update_column deleted = _$gmessagesUpdateColumndeleted;

  static const Gmessages_update_column id = _$gmessagesUpdateColumnid;

  static const Gmessages_update_column is_image =
      _$gmessagesUpdateColumnis_image;

  static const Gmessages_update_column message = _$gmessagesUpdateColumnmessage;

  static const Gmessages_update_column thread_id =
      _$gmessagesUpdateColumnthread_id;

  static const Gmessages_update_column updated_at =
      _$gmessagesUpdateColumnupdated_at;

  static const Gmessages_update_column user_sent =
      _$gmessagesUpdateColumnuser_sent;

  static Serializer<Gmessages_update_column> get serializer =>
      _$gmessagesUpdateColumnSerializer;
  static BuiltSet<Gmessages_update_column> get values =>
      _$gmessagesUpdateColumnValues;
  static Gmessages_update_column valueOf(String name) =>
      _$gmessagesUpdateColumnValueOf(name);
}

class Gorder_by extends EnumClass {
  const Gorder_by._(String name) : super(name);

  static const Gorder_by asc = _$gorderByasc;

  static const Gorder_by asc_nulls_first = _$gorderByasc_nulls_first;

  static const Gorder_by asc_nulls_last = _$gorderByasc_nulls_last;

  static const Gorder_by desc = _$gorderBydesc;

  static const Gorder_by desc_nulls_first = _$gorderBydesc_nulls_first;

  static const Gorder_by desc_nulls_last = _$gorderBydesc_nulls_last;

  static Serializer<Gorder_by> get serializer => _$gorderBySerializer;
  static BuiltSet<Gorder_by> get values => _$gorderByValues;
  static Gorder_by valueOf(String name) => _$gorderByValueOf(name);
}

abstract class GString_comparison_exp
    implements Built<GString_comparison_exp, GString_comparison_expBuilder> {
  GString_comparison_exp._();

  factory GString_comparison_exp(
          [Function(GString_comparison_expBuilder b) updates]) =
      _$GString_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  String? get G_eq;
  @BuiltValueField(wireName: '_gt')
  String? get G_gt;
  @BuiltValueField(wireName: '_gte')
  String? get G_gte;
  @BuiltValueField(wireName: '_ilike')
  String? get G_ilike;
  @BuiltValueField(wireName: '_in')
  BuiltList<String>? get G_in;
  @BuiltValueField(wireName: '_iregex')
  String? get G_iregex;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_like')
  String? get G_like;
  @BuiltValueField(wireName: '_lt')
  String? get G_lt;
  @BuiltValueField(wireName: '_lte')
  String? get G_lte;
  @BuiltValueField(wireName: '_neq')
  String? get G_neq;
  @BuiltValueField(wireName: '_nilike')
  String? get G_nilike;
  @BuiltValueField(wireName: '_nin')
  BuiltList<String>? get G_nin;
  @BuiltValueField(wireName: '_niregex')
  String? get G_niregex;
  @BuiltValueField(wireName: '_nlike')
  String? get G_nlike;
  @BuiltValueField(wireName: '_nregex')
  String? get G_nregex;
  @BuiltValueField(wireName: '_nsimilar')
  String? get G_nsimilar;
  @BuiltValueField(wireName: '_regex')
  String? get G_regex;
  @BuiltValueField(wireName: '_similar')
  String? get G_similar;
  static Serializer<GString_comparison_exp> get serializer =>
      _$gStringComparisonExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GString_comparison_exp.serializer, this)
          as Map<String, dynamic>);
  static GString_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GString_comparison_exp.serializer, json);
}

abstract class Gtimestamptz_comparison_exp
    implements
        Built<Gtimestamptz_comparison_exp, Gtimestamptz_comparison_expBuilder> {
  Gtimestamptz_comparison_exp._();

  factory Gtimestamptz_comparison_exp(
          [Function(Gtimestamptz_comparison_expBuilder b) updates]) =
      _$Gtimestamptz_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  DateTime? get G_eq;
  @BuiltValueField(wireName: '_gt')
  DateTime? get G_gt;
  @BuiltValueField(wireName: '_gte')
  DateTime? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<DateTime>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  DateTime? get G_lt;
  @BuiltValueField(wireName: '_lte')
  DateTime? get G_lte;
  @BuiltValueField(wireName: '_neq')
  DateTime? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<DateTime>? get G_nin;
  static Serializer<Gtimestamptz_comparison_exp> get serializer =>
      _$gtimestamptzComparisonExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gtimestamptz_comparison_exp.serializer, this) as Map<String, dynamic>);
  static Gtimestamptz_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gtimestamptz_comparison_exp.serializer, json);
}

abstract class Guser_to_group_aggregate_order_by
    implements
        Built<Guser_to_group_aggregate_order_by,
            Guser_to_group_aggregate_order_byBuilder> {
  Guser_to_group_aggregate_order_by._();

  factory Guser_to_group_aggregate_order_by(
          [Function(Guser_to_group_aggregate_order_byBuilder b) updates]) =
      _$Guser_to_group_aggregate_order_by;

  Gorder_by? get count;
  Guser_to_group_max_order_by? get max;
  Guser_to_group_min_order_by? get min;
  static Serializer<Guser_to_group_aggregate_order_by> get serializer =>
      _$guserToGroupAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_group_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_group_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_aggregate_order_by.serializer, json);
}

abstract class Guser_to_group_arr_rel_insert_input
    implements
        Built<Guser_to_group_arr_rel_insert_input,
            Guser_to_group_arr_rel_insert_inputBuilder> {
  Guser_to_group_arr_rel_insert_input._();

  factory Guser_to_group_arr_rel_insert_input(
          [Function(Guser_to_group_arr_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_group_arr_rel_insert_input;

  BuiltList<Guser_to_group_insert_input> get data;
  Guser_to_group_on_conflict? get on_conflict;
  static Serializer<Guser_to_group_arr_rel_insert_input> get serializer =>
      _$guserToGroupArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_group_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_group_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Guser_to_group_arr_rel_insert_input.serializer, json);
}

abstract class Guser_to_group_bool_exp
    implements Built<Guser_to_group_bool_exp, Guser_to_group_bool_expBuilder> {
  Guser_to_group_bool_exp._();

  factory Guser_to_group_bool_exp(
          [Function(Guser_to_group_bool_expBuilder b) updates]) =
      _$Guser_to_group_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Guser_to_group_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Guser_to_group_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Guser_to_group_bool_exp>? get G_or;
  GBoolean_comparison_exp? get admin;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Guser_to_group_bool_exp> get serializer =>
      _$guserToGroupBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_group_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_group_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_group_bool_exp.serializer, json);
}

class Guser_to_group_constraint extends EnumClass {
  const Guser_to_group_constraint._(String name) : super(name);

  static const Guser_to_group_constraint user_to_group_pkey =
      _$guserToGroupConstraintuser_to_group_pkey;

  static Serializer<Guser_to_group_constraint> get serializer =>
      _$guserToGroupConstraintSerializer;
  static BuiltSet<Guser_to_group_constraint> get values =>
      _$guserToGroupConstraintValues;
  static Guser_to_group_constraint valueOf(String name) =>
      _$guserToGroupConstraintValueOf(name);
}

abstract class Guser_to_group_insert_input
    implements
        Built<Guser_to_group_insert_input, Guser_to_group_insert_inputBuilder> {
  Guser_to_group_insert_input._();

  factory Guser_to_group_insert_input(
          [Function(Guser_to_group_insert_inputBuilder b) updates]) =
      _$Guser_to_group_insert_input;

  bool? get admin;
  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_group_insert_input> get serializer =>
      _$guserToGroupInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_group_insert_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_group_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_insert_input.serializer, json);
}

abstract class Guser_to_group_max_order_by
    implements
        Built<Guser_to_group_max_order_by, Guser_to_group_max_order_byBuilder> {
  Guser_to_group_max_order_by._();

  factory Guser_to_group_max_order_by(
          [Function(Guser_to_group_max_order_byBuilder b) updates]) =
      _$Guser_to_group_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_group_max_order_by> get serializer =>
      _$guserToGroupMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_group_max_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_group_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_max_order_by.serializer, json);
}

abstract class Guser_to_group_min_order_by
    implements
        Built<Guser_to_group_min_order_by, Guser_to_group_min_order_byBuilder> {
  Guser_to_group_min_order_by._();

  factory Guser_to_group_min_order_by(
          [Function(Guser_to_group_min_order_byBuilder b) updates]) =
      _$Guser_to_group_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_group_min_order_by> get serializer =>
      _$guserToGroupMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_group_min_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_group_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_min_order_by.serializer, json);
}

abstract class Guser_to_group_on_conflict
    implements
        Built<Guser_to_group_on_conflict, Guser_to_group_on_conflictBuilder> {
  Guser_to_group_on_conflict._();

  factory Guser_to_group_on_conflict(
          [Function(Guser_to_group_on_conflictBuilder b) updates]) =
      _$Guser_to_group_on_conflict;

  Guser_to_group_constraint get constraint;
  BuiltList<Guser_to_group_update_column> get update_columns;
  Guser_to_group_bool_exp? get where;
  static Serializer<Guser_to_group_on_conflict> get serializer =>
      _$guserToGroupOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_group_on_conflict.serializer, this) as Map<String, dynamic>);
  static Guser_to_group_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_on_conflict.serializer, json);
}

abstract class Guser_to_group_order_by
    implements Built<Guser_to_group_order_by, Guser_to_group_order_byBuilder> {
  Guser_to_group_order_by._();

  factory Guser_to_group_order_by(
          [Function(Guser_to_group_order_byBuilder b) updates]) =
      _$Guser_to_group_order_by;

  Gorder_by? get admin;
  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Guser_to_group_order_by> get serializer =>
      _$guserToGroupOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_group_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_group_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_group_order_by.serializer, json);
}

abstract class Guser_to_group_pk_columns_input
    implements
        Built<Guser_to_group_pk_columns_input,
            Guser_to_group_pk_columns_inputBuilder> {
  Guser_to_group_pk_columns_input._();

  factory Guser_to_group_pk_columns_input(
          [Function(Guser_to_group_pk_columns_inputBuilder b) updates]) =
      _$Guser_to_group_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Guser_to_group_pk_columns_input> get serializer =>
      _$guserToGroupPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_group_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_group_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_pk_columns_input.serializer, json);
}

class Guser_to_group_select_column extends EnumClass {
  const Guser_to_group_select_column._(String name) : super(name);

  static const Guser_to_group_select_column admin =
      _$guserToGroupSelectColumnadmin;

  static const Guser_to_group_select_column group_id =
      _$guserToGroupSelectColumngroup_id;

  static const Guser_to_group_select_column id = _$guserToGroupSelectColumnid;

  static const Guser_to_group_select_column user_id =
      _$guserToGroupSelectColumnuser_id;

  static Serializer<Guser_to_group_select_column> get serializer =>
      _$guserToGroupSelectColumnSerializer;
  static BuiltSet<Guser_to_group_select_column> get values =>
      _$guserToGroupSelectColumnValues;
  static Guser_to_group_select_column valueOf(String name) =>
      _$guserToGroupSelectColumnValueOf(name);
}

abstract class Guser_to_group_set_input
    implements
        Built<Guser_to_group_set_input, Guser_to_group_set_inputBuilder> {
  Guser_to_group_set_input._();

  factory Guser_to_group_set_input(
          [Function(Guser_to_group_set_inputBuilder b) updates]) =
      _$Guser_to_group_set_input;

  bool? get admin;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_group_set_input> get serializer =>
      _$guserToGroupSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_group_set_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_group_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_set_input.serializer, json);
}

class Guser_to_group_update_column extends EnumClass {
  const Guser_to_group_update_column._(String name) : super(name);

  static const Guser_to_group_update_column admin =
      _$guserToGroupUpdateColumnadmin;

  static const Guser_to_group_update_column group_id =
      _$guserToGroupUpdateColumngroup_id;

  static const Guser_to_group_update_column id = _$guserToGroupUpdateColumnid;

  static const Guser_to_group_update_column user_id =
      _$guserToGroupUpdateColumnuser_id;

  static Serializer<Guser_to_group_update_column> get serializer =>
      _$guserToGroupUpdateColumnSerializer;
  static BuiltSet<Guser_to_group_update_column> get values =>
      _$guserToGroupUpdateColumnValues;
  static Guser_to_group_update_column valueOf(String name) =>
      _$guserToGroupUpdateColumnValueOf(name);
}

abstract class Guser_to_thread_aggregate_order_by
    implements
        Built<Guser_to_thread_aggregate_order_by,
            Guser_to_thread_aggregate_order_byBuilder> {
  Guser_to_thread_aggregate_order_by._();

  factory Guser_to_thread_aggregate_order_by(
          [Function(Guser_to_thread_aggregate_order_byBuilder b) updates]) =
      _$Guser_to_thread_aggregate_order_by;

  Gorder_by? get count;
  Guser_to_thread_max_order_by? get max;
  Guser_to_thread_min_order_by? get min;
  static Serializer<Guser_to_thread_aggregate_order_by> get serializer =>
      _$guserToThreadAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_thread_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_thread_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_aggregate_order_by.serializer, json);
}

abstract class Guser_to_thread_arr_rel_insert_input
    implements
        Built<Guser_to_thread_arr_rel_insert_input,
            Guser_to_thread_arr_rel_insert_inputBuilder> {
  Guser_to_thread_arr_rel_insert_input._();

  factory Guser_to_thread_arr_rel_insert_input(
          [Function(Guser_to_thread_arr_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_thread_arr_rel_insert_input;

  BuiltList<Guser_to_thread_insert_input> get data;
  Guser_to_thread_on_conflict? get on_conflict;
  static Serializer<Guser_to_thread_arr_rel_insert_input> get serializer =>
      _$guserToThreadArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_thread_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_thread_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Guser_to_thread_arr_rel_insert_input.serializer, json);
}

abstract class Guser_to_thread_bool_exp
    implements
        Built<Guser_to_thread_bool_exp, Guser_to_thread_bool_expBuilder> {
  Guser_to_thread_bool_exp._();

  factory Guser_to_thread_bool_exp(
          [Function(Guser_to_thread_bool_expBuilder b) updates]) =
      _$Guser_to_thread_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Guser_to_thread_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Guser_to_thread_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Guser_to_thread_bool_exp>? get G_or;
  Ggroup_threads_bool_exp? get group_thread;
  Guuid_comparison_exp? get id;
  Guuid_comparison_exp? get thread_id;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Guser_to_thread_bool_exp> get serializer =>
      _$guserToThreadBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_thread_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_thread_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_bool_exp.serializer, json);
}

class Guser_to_thread_constraint extends EnumClass {
  const Guser_to_thread_constraint._(String name) : super(name);

  static const Guser_to_thread_constraint user_to_thread_pkey =
      _$guserToThreadConstraintuser_to_thread_pkey;

  static Serializer<Guser_to_thread_constraint> get serializer =>
      _$guserToThreadConstraintSerializer;
  static BuiltSet<Guser_to_thread_constraint> get values =>
      _$guserToThreadConstraintValues;
  static Guser_to_thread_constraint valueOf(String name) =>
      _$guserToThreadConstraintValueOf(name);
}

abstract class Guser_to_thread_insert_input
    implements
        Built<Guser_to_thread_insert_input,
            Guser_to_thread_insert_inputBuilder> {
  Guser_to_thread_insert_input._();

  factory Guser_to_thread_insert_input(
          [Function(Guser_to_thread_insert_inputBuilder b) updates]) =
      _$Guser_to_thread_insert_input;

  Ggroup_threads_obj_rel_insert_input? get group_thread;
  _i2.UuidType? get id;
  _i2.UuidType? get thread_id;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_thread_insert_input> get serializer =>
      _$guserToThreadInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_thread_insert_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_thread_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_insert_input.serializer, json);
}

abstract class Guser_to_thread_max_order_by
    implements
        Built<Guser_to_thread_max_order_by,
            Guser_to_thread_max_order_byBuilder> {
  Guser_to_thread_max_order_by._();

  factory Guser_to_thread_max_order_by(
          [Function(Guser_to_thread_max_order_byBuilder b) updates]) =
      _$Guser_to_thread_max_order_by;

  Gorder_by? get id;
  Gorder_by? get thread_id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_thread_max_order_by> get serializer =>
      _$guserToThreadMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_thread_max_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_thread_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_max_order_by.serializer, json);
}

abstract class Guser_to_thread_min_order_by
    implements
        Built<Guser_to_thread_min_order_by,
            Guser_to_thread_min_order_byBuilder> {
  Guser_to_thread_min_order_by._();

  factory Guser_to_thread_min_order_by(
          [Function(Guser_to_thread_min_order_byBuilder b) updates]) =
      _$Guser_to_thread_min_order_by;

  Gorder_by? get id;
  Gorder_by? get thread_id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_thread_min_order_by> get serializer =>
      _$guserToThreadMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_thread_min_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_thread_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_min_order_by.serializer, json);
}

abstract class Guser_to_thread_on_conflict
    implements
        Built<Guser_to_thread_on_conflict, Guser_to_thread_on_conflictBuilder> {
  Guser_to_thread_on_conflict._();

  factory Guser_to_thread_on_conflict(
          [Function(Guser_to_thread_on_conflictBuilder b) updates]) =
      _$Guser_to_thread_on_conflict;

  Guser_to_thread_constraint get constraint;
  BuiltList<Guser_to_thread_update_column> get update_columns;
  Guser_to_thread_bool_exp? get where;
  static Serializer<Guser_to_thread_on_conflict> get serializer =>
      _$guserToThreadOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_thread_on_conflict.serializer, this) as Map<String, dynamic>);
  static Guser_to_thread_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_on_conflict.serializer, json);
}

abstract class Guser_to_thread_order_by
    implements
        Built<Guser_to_thread_order_by, Guser_to_thread_order_byBuilder> {
  Guser_to_thread_order_by._();

  factory Guser_to_thread_order_by(
          [Function(Guser_to_thread_order_byBuilder b) updates]) =
      _$Guser_to_thread_order_by;

  Ggroup_threads_order_by? get group_thread;
  Gorder_by? get id;
  Gorder_by? get thread_id;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Guser_to_thread_order_by> get serializer =>
      _$guserToThreadOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_thread_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_thread_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_order_by.serializer, json);
}

abstract class Guser_to_thread_pk_columns_input
    implements
        Built<Guser_to_thread_pk_columns_input,
            Guser_to_thread_pk_columns_inputBuilder> {
  Guser_to_thread_pk_columns_input._();

  factory Guser_to_thread_pk_columns_input(
          [Function(Guser_to_thread_pk_columns_inputBuilder b) updates]) =
      _$Guser_to_thread_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Guser_to_thread_pk_columns_input> get serializer =>
      _$guserToThreadPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_thread_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_thread_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_pk_columns_input.serializer, json);
}

class Guser_to_thread_select_column extends EnumClass {
  const Guser_to_thread_select_column._(String name) : super(name);

  static const Guser_to_thread_select_column id = _$guserToThreadSelectColumnid;

  static const Guser_to_thread_select_column thread_id =
      _$guserToThreadSelectColumnthread_id;

  static const Guser_to_thread_select_column user_id =
      _$guserToThreadSelectColumnuser_id;

  static Serializer<Guser_to_thread_select_column> get serializer =>
      _$guserToThreadSelectColumnSerializer;
  static BuiltSet<Guser_to_thread_select_column> get values =>
      _$guserToThreadSelectColumnValues;
  static Guser_to_thread_select_column valueOf(String name) =>
      _$guserToThreadSelectColumnValueOf(name);
}

abstract class Guser_to_thread_set_input
    implements
        Built<Guser_to_thread_set_input, Guser_to_thread_set_inputBuilder> {
  Guser_to_thread_set_input._();

  factory Guser_to_thread_set_input(
          [Function(Guser_to_thread_set_inputBuilder b) updates]) =
      _$Guser_to_thread_set_input;

  _i2.UuidType? get id;
  _i2.UuidType? get thread_id;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_thread_set_input> get serializer =>
      _$guserToThreadSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_thread_set_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_thread_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_thread_set_input.serializer, json);
}

class Guser_to_thread_update_column extends EnumClass {
  const Guser_to_thread_update_column._(String name) : super(name);

  static const Guser_to_thread_update_column id = _$guserToThreadUpdateColumnid;

  static const Guser_to_thread_update_column thread_id =
      _$guserToThreadUpdateColumnthread_id;

  static const Guser_to_thread_update_column user_id =
      _$guserToThreadUpdateColumnuser_id;

  static Serializer<Guser_to_thread_update_column> get serializer =>
      _$guserToThreadUpdateColumnSerializer;
  static BuiltSet<Guser_to_thread_update_column> get values =>
      _$guserToThreadUpdateColumnValues;
  static Guser_to_thread_update_column valueOf(String name) =>
      _$guserToThreadUpdateColumnValueOf(name);
}

abstract class Gusers_bool_exp
    implements Built<Gusers_bool_exp, Gusers_bool_expBuilder> {
  Gusers_bool_exp._();

  factory Gusers_bool_exp([Function(Gusers_bool_expBuilder b) updates]) =
      _$Gusers_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gusers_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gusers_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gusers_bool_exp>? get G_or;
  GString_comparison_exp? get email;
  Guuid_comparison_exp? get id;
  Gmessages_bool_exp? get messages;
  GString_comparison_exp? get name;
  GString_comparison_exp? get profile_picture;
  GString_comparison_exp? get sub;
  Guser_to_group_bool_exp? get user_to_groups;
  Guser_to_thread_bool_exp? get user_to_threads;
  static Serializer<Gusers_bool_exp> get serializer =>
      _$gusersBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gusers_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_bool_exp.serializer, json);
}

class Gusers_constraint extends EnumClass {
  const Gusers_constraint._(String name) : super(name);

  static const Gusers_constraint users_pkey = _$gusersConstraintusers_pkey;

  static const Gusers_constraint users_sub_key =
      _$gusersConstraintusers_sub_key;

  static Serializer<Gusers_constraint> get serializer =>
      _$gusersConstraintSerializer;
  static BuiltSet<Gusers_constraint> get values => _$gusersConstraintValues;
  static Gusers_constraint valueOf(String name) =>
      _$gusersConstraintValueOf(name);
}

abstract class Gusers_insert_input
    implements Built<Gusers_insert_input, Gusers_insert_inputBuilder> {
  Gusers_insert_input._();

  factory Gusers_insert_input(
      [Function(Gusers_insert_inputBuilder b) updates]) = _$Gusers_insert_input;

  String? get email;
  _i2.UuidType? get id;
  Gmessages_arr_rel_insert_input? get messages;
  String? get name;
  String? get profile_picture;
  String? get sub;
  Guser_to_group_arr_rel_insert_input? get user_to_groups;
  Guser_to_thread_arr_rel_insert_input? get user_to_threads;
  static Serializer<Gusers_insert_input> get serializer =>
      _$gusersInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gusers_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_insert_input.serializer, json);
}

abstract class Gusers_obj_rel_insert_input
    implements
        Built<Gusers_obj_rel_insert_input, Gusers_obj_rel_insert_inputBuilder> {
  Gusers_obj_rel_insert_input._();

  factory Gusers_obj_rel_insert_input(
          [Function(Gusers_obj_rel_insert_inputBuilder b) updates]) =
      _$Gusers_obj_rel_insert_input;

  Gusers_insert_input get data;
  Gusers_on_conflict? get on_conflict;
  static Serializer<Gusers_obj_rel_insert_input> get serializer =>
      _$gusersObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gusers_obj_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gusers_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gusers_obj_rel_insert_input.serializer, json);
}

abstract class Gusers_on_conflict
    implements Built<Gusers_on_conflict, Gusers_on_conflictBuilder> {
  Gusers_on_conflict._();

  factory Gusers_on_conflict([Function(Gusers_on_conflictBuilder b) updates]) =
      _$Gusers_on_conflict;

  Gusers_constraint get constraint;
  BuiltList<Gusers_update_column> get update_columns;
  Gusers_bool_exp? get where;
  static Serializer<Gusers_on_conflict> get serializer =>
      _$gusersOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Gusers_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_on_conflict.serializer, json);
}

abstract class Gusers_order_by
    implements Built<Gusers_order_by, Gusers_order_byBuilder> {
  Gusers_order_by._();

  factory Gusers_order_by([Function(Gusers_order_byBuilder b) updates]) =
      _$Gusers_order_by;

  Gorder_by? get email;
  Gorder_by? get id;
  Gmessages_aggregate_order_by? get messages_aggregate;
  Gorder_by? get name;
  Gorder_by? get profile_picture;
  Gorder_by? get sub;
  Guser_to_group_aggregate_order_by? get user_to_groups_aggregate;
  Guser_to_thread_aggregate_order_by? get user_to_threads_aggregate;
  static Serializer<Gusers_order_by> get serializer =>
      _$gusersOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gusers_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_order_by.serializer, json);
}

abstract class Gusers_pk_columns_input
    implements Built<Gusers_pk_columns_input, Gusers_pk_columns_inputBuilder> {
  Gusers_pk_columns_input._();

  factory Gusers_pk_columns_input(
          [Function(Gusers_pk_columns_inputBuilder b) updates]) =
      _$Gusers_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Gusers_pk_columns_input> get serializer =>
      _$gusersPkColumnsInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_pk_columns_input.serializer, this)
          as Map<String, dynamic>);
  static Gusers_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_pk_columns_input.serializer, json);
}

class Gusers_select_column extends EnumClass {
  const Gusers_select_column._(String name) : super(name);

  static const Gusers_select_column email = _$gusersSelectColumnemail;

  static const Gusers_select_column id = _$gusersSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gusers_select_column Gname = _$gusersSelectColumnGname;

  static const Gusers_select_column profile_picture =
      _$gusersSelectColumnprofile_picture;

  static const Gusers_select_column sub = _$gusersSelectColumnsub;

  static Serializer<Gusers_select_column> get serializer =>
      _$gusersSelectColumnSerializer;
  static BuiltSet<Gusers_select_column> get values =>
      _$gusersSelectColumnValues;
  static Gusers_select_column valueOf(String name) =>
      _$gusersSelectColumnValueOf(name);
}

abstract class Gusers_set_input
    implements Built<Gusers_set_input, Gusers_set_inputBuilder> {
  Gusers_set_input._();

  factory Gusers_set_input([Function(Gusers_set_inputBuilder b) updates]) =
      _$Gusers_set_input;

  String? get email;
  _i2.UuidType? get id;
  String? get name;
  String? get profile_picture;
  String? get sub;
  static Serializer<Gusers_set_input> get serializer =>
      _$gusersSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gusers_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_set_input.serializer, json);
}

class Gusers_update_column extends EnumClass {
  const Gusers_update_column._(String name) : super(name);

  static const Gusers_update_column email = _$gusersUpdateColumnemail;

  static const Gusers_update_column id = _$gusersUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gusers_update_column Gname = _$gusersUpdateColumnGname;

  static const Gusers_update_column profile_picture =
      _$gusersUpdateColumnprofile_picture;

  static const Gusers_update_column sub = _$gusersUpdateColumnsub;

  static Serializer<Gusers_update_column> get serializer =>
      _$gusersUpdateColumnSerializer;
  static BuiltSet<Gusers_update_column> get values =>
      _$gusersUpdateColumnValues;
  static Gusers_update_column valueOf(String name) =>
      _$gusersUpdateColumnValueOf(name);
}

abstract class Guuid_comparison_exp
    implements Built<Guuid_comparison_exp, Guuid_comparison_expBuilder> {
  Guuid_comparison_exp._();

  factory Guuid_comparison_exp(
          [Function(Guuid_comparison_expBuilder b) updates]) =
      _$Guuid_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  _i2.UuidType? get G_eq;
  @BuiltValueField(wireName: '_gt')
  _i2.UuidType? get G_gt;
  @BuiltValueField(wireName: '_gte')
  _i2.UuidType? get G_gte;
  @BuiltValueField(wireName: '_in')
  BuiltList<_i2.UuidType>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_lt')
  _i2.UuidType? get G_lt;
  @BuiltValueField(wireName: '_lte')
  _i2.UuidType? get G_lte;
  @BuiltValueField(wireName: '_neq')
  _i2.UuidType? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<_i2.UuidType>? get G_nin;
  static Serializer<Guuid_comparison_exp> get serializer =>
      _$guuidComparisonExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guuid_comparison_exp.serializer, this)
          as Map<String, dynamic>);
  static Guuid_comparison_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guuid_comparison_exp.serializer, json);
}
