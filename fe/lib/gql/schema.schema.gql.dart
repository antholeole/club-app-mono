// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fe/gql/serializers.gql.dart' as _i1;
import 'package:fe/helpers/uuid_type.dart' as _i2;

part 'schema.schema.gql.g.dart';

abstract class Ggroups_aggregate_order_by
    implements
        Built<Ggroups_aggregate_order_by, Ggroups_aggregate_order_byBuilder> {
  Ggroups_aggregate_order_by._();

  factory Ggroups_aggregate_order_by(
          [Function(Ggroups_aggregate_order_byBuilder b) updates]) =
      _$Ggroups_aggregate_order_by;

  Gorder_by? get count;
  Ggroups_max_order_by? get max;
  Ggroups_min_order_by? get min;
  static Serializer<Ggroups_aggregate_order_by> get serializer =>
      _$ggroupsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroups_aggregate_order_by.serializer, this) as Map<String, dynamic>);
  static Ggroups_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroups_aggregate_order_by.serializer, json);
}

abstract class Ggroups_arr_rel_insert_input
    implements
        Built<Ggroups_arr_rel_insert_input,
            Ggroups_arr_rel_insert_inputBuilder> {
  Ggroups_arr_rel_insert_input._();

  factory Ggroups_arr_rel_insert_input(
          [Function(Ggroups_arr_rel_insert_inputBuilder b) updates]) =
      _$Ggroups_arr_rel_insert_input;

  BuiltList<Ggroups_insert_input> get data;
  Ggroups_on_conflict? get on_conflict;
  static Serializer<Ggroups_arr_rel_insert_input> get serializer =>
      _$ggroupsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroups_arr_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Ggroups_arr_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroups_arr_rel_insert_input.serializer, json);
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
  GString_comparison_exp? get group_name;
  Guuid_comparison_exp? get id;
  Guser_to_groups_bool_exp? get user_to_groups;
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

  String? get group_name;
  _i2.UuidType? get id;
  Guser_to_groups_arr_rel_insert_input? get user_to_groups;
  static Serializer<Ggroups_insert_input> get serializer =>
      _$ggroupsInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_insert_input.serializer, json);
}

abstract class Ggroups_max_order_by
    implements Built<Ggroups_max_order_by, Ggroups_max_order_byBuilder> {
  Ggroups_max_order_by._();

  factory Ggroups_max_order_by(
          [Function(Ggroups_max_order_byBuilder b) updates]) =
      _$Ggroups_max_order_by;

  Gorder_by? get group_name;
  Gorder_by? get id;
  static Serializer<Ggroups_max_order_by> get serializer =>
      _$ggroupsMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_max_order_by.serializer, json);
}

abstract class Ggroups_min_order_by
    implements Built<Ggroups_min_order_by, Ggroups_min_order_byBuilder> {
  Ggroups_min_order_by._();

  factory Ggroups_min_order_by(
          [Function(Ggroups_min_order_byBuilder b) updates]) =
      _$Ggroups_min_order_by;

  Gorder_by? get group_name;
  Gorder_by? get id;
  static Serializer<Ggroups_min_order_by> get serializer =>
      _$ggroupsMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroups_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Ggroups_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Ggroups_min_order_by.serializer, json);
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

  Gorder_by? get group_name;
  Gorder_by? get id;
  Guser_to_groups_aggregate_order_by? get user_to_groups_aggregate;
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

abstract class Grefresh_tokens_aggregate_order_by
    implements
        Built<Grefresh_tokens_aggregate_order_by,
            Grefresh_tokens_aggregate_order_byBuilder> {
  Grefresh_tokens_aggregate_order_by._();

  factory Grefresh_tokens_aggregate_order_by(
          [Function(Grefresh_tokens_aggregate_order_byBuilder b) updates]) =
      _$Grefresh_tokens_aggregate_order_by;

  Gorder_by? get count;
  Grefresh_tokens_max_order_by? get max;
  Grefresh_tokens_min_order_by? get min;
  static Serializer<Grefresh_tokens_aggregate_order_by> get serializer =>
      _$grefreshTokensAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grefresh_tokens_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Grefresh_tokens_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_aggregate_order_by.serializer, json);
}

abstract class Grefresh_tokens_arr_rel_insert_input
    implements
        Built<Grefresh_tokens_arr_rel_insert_input,
            Grefresh_tokens_arr_rel_insert_inputBuilder> {
  Grefresh_tokens_arr_rel_insert_input._();

  factory Grefresh_tokens_arr_rel_insert_input(
          [Function(Grefresh_tokens_arr_rel_insert_inputBuilder b) updates]) =
      _$Grefresh_tokens_arr_rel_insert_input;

  BuiltList<Grefresh_tokens_insert_input> get data;
  Grefresh_tokens_on_conflict? get on_conflict;
  static Serializer<Grefresh_tokens_arr_rel_insert_input> get serializer =>
      _$grefreshTokensArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grefresh_tokens_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Grefresh_tokens_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Grefresh_tokens_arr_rel_insert_input.serializer, json);
}

abstract class Grefresh_tokens_bool_exp
    implements
        Built<Grefresh_tokens_bool_exp, Grefresh_tokens_bool_expBuilder> {
  Grefresh_tokens_bool_exp._();

  factory Grefresh_tokens_bool_exp(
          [Function(Grefresh_tokens_bool_expBuilder b) updates]) =
      _$Grefresh_tokens_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Grefresh_tokens_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Grefresh_tokens_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Grefresh_tokens_bool_exp>? get G_or;
  Guuid_comparison_exp? get id;
  GString_comparison_exp? get refresh_token;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Grefresh_tokens_bool_exp> get serializer =>
      _$grefreshTokensBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Grefresh_tokens_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Grefresh_tokens_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_bool_exp.serializer, json);
}

class Grefresh_tokens_constraint extends EnumClass {
  const Grefresh_tokens_constraint._(String name) : super(name);

  static const Grefresh_tokens_constraint refresh_tokens_pkey =
      _$grefreshTokensConstraintrefresh_tokens_pkey;

  static const Grefresh_tokens_constraint refresh_tokens_user_id_key =
      _$grefreshTokensConstraintrefresh_tokens_user_id_key;

  static Serializer<Grefresh_tokens_constraint> get serializer =>
      _$grefreshTokensConstraintSerializer;
  static BuiltSet<Grefresh_tokens_constraint> get values =>
      _$grefreshTokensConstraintValues;
  static Grefresh_tokens_constraint valueOf(String name) =>
      _$grefreshTokensConstraintValueOf(name);
}

abstract class Grefresh_tokens_insert_input
    implements
        Built<Grefresh_tokens_insert_input,
            Grefresh_tokens_insert_inputBuilder> {
  Grefresh_tokens_insert_input._();

  factory Grefresh_tokens_insert_input(
          [Function(Grefresh_tokens_insert_inputBuilder b) updates]) =
      _$Grefresh_tokens_insert_input;

  _i2.UuidType? get id;
  String? get refresh_token;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Grefresh_tokens_insert_input> get serializer =>
      _$grefreshTokensInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grefresh_tokens_insert_input.serializer, this) as Map<String, dynamic>);
  static Grefresh_tokens_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_insert_input.serializer, json);
}

abstract class Grefresh_tokens_max_order_by
    implements
        Built<Grefresh_tokens_max_order_by,
            Grefresh_tokens_max_order_byBuilder> {
  Grefresh_tokens_max_order_by._();

  factory Grefresh_tokens_max_order_by(
          [Function(Grefresh_tokens_max_order_byBuilder b) updates]) =
      _$Grefresh_tokens_max_order_by;

  Gorder_by? get id;
  Gorder_by? get refresh_token;
  Gorder_by? get user_id;
  static Serializer<Grefresh_tokens_max_order_by> get serializer =>
      _$grefreshTokensMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grefresh_tokens_max_order_by.serializer, this) as Map<String, dynamic>);
  static Grefresh_tokens_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_max_order_by.serializer, json);
}

abstract class Grefresh_tokens_min_order_by
    implements
        Built<Grefresh_tokens_min_order_by,
            Grefresh_tokens_min_order_byBuilder> {
  Grefresh_tokens_min_order_by._();

  factory Grefresh_tokens_min_order_by(
          [Function(Grefresh_tokens_min_order_byBuilder b) updates]) =
      _$Grefresh_tokens_min_order_by;

  Gorder_by? get id;
  Gorder_by? get refresh_token;
  Gorder_by? get user_id;
  static Serializer<Grefresh_tokens_min_order_by> get serializer =>
      _$grefreshTokensMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grefresh_tokens_min_order_by.serializer, this) as Map<String, dynamic>);
  static Grefresh_tokens_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_min_order_by.serializer, json);
}

abstract class Grefresh_tokens_obj_rel_insert_input
    implements
        Built<Grefresh_tokens_obj_rel_insert_input,
            Grefresh_tokens_obj_rel_insert_inputBuilder> {
  Grefresh_tokens_obj_rel_insert_input._();

  factory Grefresh_tokens_obj_rel_insert_input(
          [Function(Grefresh_tokens_obj_rel_insert_inputBuilder b) updates]) =
      _$Grefresh_tokens_obj_rel_insert_input;

  Grefresh_tokens_insert_input get data;
  Grefresh_tokens_on_conflict? get on_conflict;
  static Serializer<Grefresh_tokens_obj_rel_insert_input> get serializer =>
      _$grefreshTokensObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grefresh_tokens_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Grefresh_tokens_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Grefresh_tokens_obj_rel_insert_input.serializer, json);
}

abstract class Grefresh_tokens_on_conflict
    implements
        Built<Grefresh_tokens_on_conflict, Grefresh_tokens_on_conflictBuilder> {
  Grefresh_tokens_on_conflict._();

  factory Grefresh_tokens_on_conflict(
          [Function(Grefresh_tokens_on_conflictBuilder b) updates]) =
      _$Grefresh_tokens_on_conflict;

  Grefresh_tokens_constraint get constraint;
  BuiltList<Grefresh_tokens_update_column> get update_columns;
  Grefresh_tokens_bool_exp? get where;
  static Serializer<Grefresh_tokens_on_conflict> get serializer =>
      _$grefreshTokensOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grefresh_tokens_on_conflict.serializer, this) as Map<String, dynamic>);
  static Grefresh_tokens_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_on_conflict.serializer, json);
}

abstract class Grefresh_tokens_order_by
    implements
        Built<Grefresh_tokens_order_by, Grefresh_tokens_order_byBuilder> {
  Grefresh_tokens_order_by._();

  factory Grefresh_tokens_order_by(
          [Function(Grefresh_tokens_order_byBuilder b) updates]) =
      _$Grefresh_tokens_order_by;

  Gorder_by? get id;
  Gorder_by? get refresh_token;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Grefresh_tokens_order_by> get serializer =>
      _$grefreshTokensOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Grefresh_tokens_order_by.serializer, this)
          as Map<String, dynamic>);
  static Grefresh_tokens_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_order_by.serializer, json);
}

abstract class Grefresh_tokens_pk_columns_input
    implements
        Built<Grefresh_tokens_pk_columns_input,
            Grefresh_tokens_pk_columns_inputBuilder> {
  Grefresh_tokens_pk_columns_input._();

  factory Grefresh_tokens_pk_columns_input(
          [Function(Grefresh_tokens_pk_columns_inputBuilder b) updates]) =
      _$Grefresh_tokens_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Grefresh_tokens_pk_columns_input> get serializer =>
      _$grefreshTokensPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grefresh_tokens_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Grefresh_tokens_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_pk_columns_input.serializer, json);
}

class Grefresh_tokens_select_column extends EnumClass {
  const Grefresh_tokens_select_column._(String name) : super(name);

  static const Grefresh_tokens_select_column id =
      _$grefreshTokensSelectColumnid;

  static const Grefresh_tokens_select_column refresh_token =
      _$grefreshTokensSelectColumnrefresh_token;

  static const Grefresh_tokens_select_column user_id =
      _$grefreshTokensSelectColumnuser_id;

  static Serializer<Grefresh_tokens_select_column> get serializer =>
      _$grefreshTokensSelectColumnSerializer;
  static BuiltSet<Grefresh_tokens_select_column> get values =>
      _$grefreshTokensSelectColumnValues;
  static Grefresh_tokens_select_column valueOf(String name) =>
      _$grefreshTokensSelectColumnValueOf(name);
}

abstract class Grefresh_tokens_set_input
    implements
        Built<Grefresh_tokens_set_input, Grefresh_tokens_set_inputBuilder> {
  Grefresh_tokens_set_input._();

  factory Grefresh_tokens_set_input(
          [Function(Grefresh_tokens_set_inputBuilder b) updates]) =
      _$Grefresh_tokens_set_input;

  _i2.UuidType? get id;
  String? get refresh_token;
  _i2.UuidType? get user_id;
  static Serializer<Grefresh_tokens_set_input> get serializer =>
      _$grefreshTokensSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Grefresh_tokens_set_input.serializer, this)
          as Map<String, dynamic>);
  static Grefresh_tokens_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grefresh_tokens_set_input.serializer, json);
}

class Grefresh_tokens_update_column extends EnumClass {
  const Grefresh_tokens_update_column._(String name) : super(name);

  static const Grefresh_tokens_update_column id =
      _$grefreshTokensUpdateColumnid;

  static const Grefresh_tokens_update_column refresh_token =
      _$grefreshTokensUpdateColumnrefresh_token;

  static const Grefresh_tokens_update_column user_id =
      _$grefreshTokensUpdateColumnuser_id;

  static Serializer<Grefresh_tokens_update_column> get serializer =>
      _$grefreshTokensUpdateColumnSerializer;
  static BuiltSet<Grefresh_tokens_update_column> get values =>
      _$grefreshTokensUpdateColumnValues;
  static Grefresh_tokens_update_column valueOf(String name) =>
      _$grefreshTokensUpdateColumnValueOf(name);
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
  @BuiltValueField(wireName: '_nlike')
  String? get G_nlike;
  @BuiltValueField(wireName: '_nsimilar')
  String? get G_nsimilar;
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

abstract class Guser_to_groups_aggregate_order_by
    implements
        Built<Guser_to_groups_aggregate_order_by,
            Guser_to_groups_aggregate_order_byBuilder> {
  Guser_to_groups_aggregate_order_by._();

  factory Guser_to_groups_aggregate_order_by(
          [Function(Guser_to_groups_aggregate_order_byBuilder b) updates]) =
      _$Guser_to_groups_aggregate_order_by;

  Gorder_by? get count;
  Guser_to_groups_max_order_by? get max;
  Guser_to_groups_min_order_by? get min;
  static Serializer<Guser_to_groups_aggregate_order_by> get serializer =>
      _$guserToGroupsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_groups_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_groups_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_aggregate_order_by.serializer, json);
}

abstract class Guser_to_groups_arr_rel_insert_input
    implements
        Built<Guser_to_groups_arr_rel_insert_input,
            Guser_to_groups_arr_rel_insert_inputBuilder> {
  Guser_to_groups_arr_rel_insert_input._();

  factory Guser_to_groups_arr_rel_insert_input(
          [Function(Guser_to_groups_arr_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_groups_arr_rel_insert_input;

  BuiltList<Guser_to_groups_insert_input> get data;
  Guser_to_groups_on_conflict? get on_conflict;
  static Serializer<Guser_to_groups_arr_rel_insert_input> get serializer =>
      _$guserToGroupsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_groups_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_groups_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Guser_to_groups_arr_rel_insert_input.serializer, json);
}

abstract class Guser_to_groups_bool_exp
    implements
        Built<Guser_to_groups_bool_exp, Guser_to_groups_bool_expBuilder> {
  Guser_to_groups_bool_exp._();

  factory Guser_to_groups_bool_exp(
          [Function(Guser_to_groups_bool_expBuilder b) updates]) =
      _$Guser_to_groups_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Guser_to_groups_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Guser_to_groups_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Guser_to_groups_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Guser_to_groups_bool_exp> get serializer =>
      _$guserToGroupsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_groups_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_groups_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_bool_exp.serializer, json);
}

class Guser_to_groups_constraint extends EnumClass {
  const Guser_to_groups_constraint._(String name) : super(name);

  static const Guser_to_groups_constraint user_to_groups_pkey =
      _$guserToGroupsConstraintuser_to_groups_pkey;

  static Serializer<Guser_to_groups_constraint> get serializer =>
      _$guserToGroupsConstraintSerializer;
  static BuiltSet<Guser_to_groups_constraint> get values =>
      _$guserToGroupsConstraintValues;
  static Guser_to_groups_constraint valueOf(String name) =>
      _$guserToGroupsConstraintValueOf(name);
}

abstract class Guser_to_groups_insert_input
    implements
        Built<Guser_to_groups_insert_input,
            Guser_to_groups_insert_inputBuilder> {
  Guser_to_groups_insert_input._();

  factory Guser_to_groups_insert_input(
          [Function(Guser_to_groups_insert_inputBuilder b) updates]) =
      _$Guser_to_groups_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_groups_insert_input> get serializer =>
      _$guserToGroupsInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_groups_insert_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_groups_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_insert_input.serializer, json);
}

abstract class Guser_to_groups_max_order_by
    implements
        Built<Guser_to_groups_max_order_by,
            Guser_to_groups_max_order_byBuilder> {
  Guser_to_groups_max_order_by._();

  factory Guser_to_groups_max_order_by(
          [Function(Guser_to_groups_max_order_byBuilder b) updates]) =
      _$Guser_to_groups_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_groups_max_order_by> get serializer =>
      _$guserToGroupsMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_groups_max_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_groups_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_max_order_by.serializer, json);
}

abstract class Guser_to_groups_min_order_by
    implements
        Built<Guser_to_groups_min_order_by,
            Guser_to_groups_min_order_byBuilder> {
  Guser_to_groups_min_order_by._();

  factory Guser_to_groups_min_order_by(
          [Function(Guser_to_groups_min_order_byBuilder b) updates]) =
      _$Guser_to_groups_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_groups_min_order_by> get serializer =>
      _$guserToGroupsMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_groups_min_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_groups_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_min_order_by.serializer, json);
}

abstract class Guser_to_groups_obj_rel_insert_input
    implements
        Built<Guser_to_groups_obj_rel_insert_input,
            Guser_to_groups_obj_rel_insert_inputBuilder> {
  Guser_to_groups_obj_rel_insert_input._();

  factory Guser_to_groups_obj_rel_insert_input(
          [Function(Guser_to_groups_obj_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_groups_obj_rel_insert_input;

  Guser_to_groups_insert_input get data;
  Guser_to_groups_on_conflict? get on_conflict;
  static Serializer<Guser_to_groups_obj_rel_insert_input> get serializer =>
      _$guserToGroupsObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_groups_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_groups_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Guser_to_groups_obj_rel_insert_input.serializer, json);
}

abstract class Guser_to_groups_on_conflict
    implements
        Built<Guser_to_groups_on_conflict, Guser_to_groups_on_conflictBuilder> {
  Guser_to_groups_on_conflict._();

  factory Guser_to_groups_on_conflict(
          [Function(Guser_to_groups_on_conflictBuilder b) updates]) =
      _$Guser_to_groups_on_conflict;

  Guser_to_groups_constraint get constraint;
  BuiltList<Guser_to_groups_update_column> get update_columns;
  Guser_to_groups_bool_exp? get where;
  static Serializer<Guser_to_groups_on_conflict> get serializer =>
      _$guserToGroupsOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_groups_on_conflict.serializer, this) as Map<String, dynamic>);
  static Guser_to_groups_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_on_conflict.serializer, json);
}

abstract class Guser_to_groups_order_by
    implements
        Built<Guser_to_groups_order_by, Guser_to_groups_order_byBuilder> {
  Guser_to_groups_order_by._();

  factory Guser_to_groups_order_by(
          [Function(Guser_to_groups_order_byBuilder b) updates]) =
      _$Guser_to_groups_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Guser_to_groups_order_by> get serializer =>
      _$guserToGroupsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_groups_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_groups_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_order_by.serializer, json);
}

abstract class Guser_to_groups_pk_columns_input
    implements
        Built<Guser_to_groups_pk_columns_input,
            Guser_to_groups_pk_columns_inputBuilder> {
  Guser_to_groups_pk_columns_input._();

  factory Guser_to_groups_pk_columns_input(
          [Function(Guser_to_groups_pk_columns_inputBuilder b) updates]) =
      _$Guser_to_groups_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Guser_to_groups_pk_columns_input> get serializer =>
      _$guserToGroupsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_groups_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_groups_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_pk_columns_input.serializer, json);
}

class Guser_to_groups_select_column extends EnumClass {
  const Guser_to_groups_select_column._(String name) : super(name);

  static const Guser_to_groups_select_column group_id =
      _$guserToGroupsSelectColumngroup_id;

  static const Guser_to_groups_select_column id = _$guserToGroupsSelectColumnid;

  static const Guser_to_groups_select_column user_id =
      _$guserToGroupsSelectColumnuser_id;

  static Serializer<Guser_to_groups_select_column> get serializer =>
      _$guserToGroupsSelectColumnSerializer;
  static BuiltSet<Guser_to_groups_select_column> get values =>
      _$guserToGroupsSelectColumnValues;
  static Guser_to_groups_select_column valueOf(String name) =>
      _$guserToGroupsSelectColumnValueOf(name);
}

abstract class Guser_to_groups_set_input
    implements
        Built<Guser_to_groups_set_input, Guser_to_groups_set_inputBuilder> {
  Guser_to_groups_set_input._();

  factory Guser_to_groups_set_input(
          [Function(Guser_to_groups_set_inputBuilder b) updates]) =
      _$Guser_to_groups_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_groups_set_input> get serializer =>
      _$guserToGroupsSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_groups_set_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_groups_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_groups_set_input.serializer, json);
}

class Guser_to_groups_update_column extends EnumClass {
  const Guser_to_groups_update_column._(String name) : super(name);

  static const Guser_to_groups_update_column group_id =
      _$guserToGroupsUpdateColumngroup_id;

  static const Guser_to_groups_update_column id = _$guserToGroupsUpdateColumnid;

  static const Guser_to_groups_update_column user_id =
      _$guserToGroupsUpdateColumnuser_id;

  static Serializer<Guser_to_groups_update_column> get serializer =>
      _$guserToGroupsUpdateColumnSerializer;
  static BuiltSet<Guser_to_groups_update_column> get values =>
      _$guserToGroupsUpdateColumnValues;
  static Guser_to_groups_update_column valueOf(String name) =>
      _$guserToGroupsUpdateColumnValueOf(name);
}

abstract class Gusers_aggregate_order_by
    implements
        Built<Gusers_aggregate_order_by, Gusers_aggregate_order_byBuilder> {
  Gusers_aggregate_order_by._();

  factory Gusers_aggregate_order_by(
          [Function(Gusers_aggregate_order_byBuilder b) updates]) =
      _$Gusers_aggregate_order_by;

  Gorder_by? get count;
  Gusers_max_order_by? get max;
  Gusers_min_order_by? get min;
  static Serializer<Gusers_aggregate_order_by> get serializer =>
      _$gusersAggregateOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_aggregate_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gusers_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gusers_aggregate_order_by.serializer, json);
}

abstract class Gusers_arr_rel_insert_input
    implements
        Built<Gusers_arr_rel_insert_input, Gusers_arr_rel_insert_inputBuilder> {
  Gusers_arr_rel_insert_input._();

  factory Gusers_arr_rel_insert_input(
          [Function(Gusers_arr_rel_insert_inputBuilder b) updates]) =
      _$Gusers_arr_rel_insert_input;

  BuiltList<Gusers_insert_input> get data;
  Gusers_on_conflict? get on_conflict;
  static Serializer<Gusers_arr_rel_insert_input> get serializer =>
      _$gusersArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gusers_arr_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gusers_arr_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gusers_arr_rel_insert_input.serializer, json);
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
  GString_comparison_exp? get is_online;
  GString_comparison_exp? get name;
  Grefresh_tokens_bool_exp? get refresh_token;
  GString_comparison_exp? get sub;
  Guser_to_groups_bool_exp? get user_to_groups;
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
  String? get is_online;
  String? get name;
  Grefresh_tokens_obj_rel_insert_input? get refresh_token;
  String? get sub;
  Guser_to_groups_arr_rel_insert_input? get user_to_groups;
  static Serializer<Gusers_insert_input> get serializer =>
      _$gusersInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gusers_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_insert_input.serializer, json);
}

abstract class Gusers_max_order_by
    implements Built<Gusers_max_order_by, Gusers_max_order_byBuilder> {
  Gusers_max_order_by._();

  factory Gusers_max_order_by(
      [Function(Gusers_max_order_byBuilder b) updates]) = _$Gusers_max_order_by;

  Gorder_by? get email;
  Gorder_by? get id;
  Gorder_by? get is_online;
  Gorder_by? get name;
  Gorder_by? get sub;
  static Serializer<Gusers_max_order_by> get serializer =>
      _$gusersMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gusers_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_max_order_by.serializer, json);
}

abstract class Gusers_min_order_by
    implements Built<Gusers_min_order_by, Gusers_min_order_byBuilder> {
  Gusers_min_order_by._();

  factory Gusers_min_order_by(
      [Function(Gusers_min_order_byBuilder b) updates]) = _$Gusers_min_order_by;

  Gorder_by? get email;
  Gorder_by? get id;
  Gorder_by? get is_online;
  Gorder_by? get name;
  Gorder_by? get sub;
  static Serializer<Gusers_min_order_by> get serializer =>
      _$gusersMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gusers_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gusers_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gusers_min_order_by.serializer, json);
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
  Gorder_by? get is_online;
  Gorder_by? get name;
  Grefresh_tokens_order_by? get refresh_token;
  Gorder_by? get sub;
  Guser_to_groups_aggregate_order_by? get user_to_groups_aggregate;
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

  static const Gusers_select_column is_online = _$gusersSelectColumnis_online;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gusers_select_column Gname = _$gusersSelectColumnGname;

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
  String? get is_online;
  String? get name;
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

  static const Gusers_update_column is_online = _$gusersUpdateColumnis_online;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gusers_update_column Gname = _$gusersUpdateColumnGname;

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
