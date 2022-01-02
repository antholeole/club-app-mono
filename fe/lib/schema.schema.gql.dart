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

abstract class Gdms_bool_exp
    implements Built<Gdms_bool_exp, Gdms_bool_expBuilder> {
  Gdms_bool_exp._();

  factory Gdms_bool_exp([Function(Gdms_bool_expBuilder b) updates]) =
      _$Gdms_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gdms_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gdms_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gdms_bool_exp>? get G_or;
  Guuid_comparison_exp? get id;
  Gmessages_bool_exp? get messages;
  GString_comparison_exp? get name;
  Guser_to_dm_bool_exp? get user_to_dms;
  static Serializer<Gdms_bool_exp> get serializer => _$gdmsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gdms_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_bool_exp.serializer, json);
}

class Gdms_constraint extends EnumClass {
  const Gdms_constraint._(String name) : super(name);

  static const Gdms_constraint dms_pkey = _$gdmsConstraintdms_pkey;

  static Serializer<Gdms_constraint> get serializer =>
      _$gdmsConstraintSerializer;
  static BuiltSet<Gdms_constraint> get values => _$gdmsConstraintValues;
  static Gdms_constraint valueOf(String name) => _$gdmsConstraintValueOf(name);
}

abstract class Gdms_insert_input
    implements Built<Gdms_insert_input, Gdms_insert_inputBuilder> {
  Gdms_insert_input._();

  factory Gdms_insert_input([Function(Gdms_insert_inputBuilder b) updates]) =
      _$Gdms_insert_input;

  _i2.UuidType? get id;
  Gmessages_arr_rel_insert_input? get messages;
  String? get name;
  Guser_to_dm_arr_rel_insert_input? get user_to_dms;
  static Serializer<Gdms_insert_input> get serializer =>
      _$gdmsInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gdms_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_insert_input.serializer, json);
}

abstract class Gdms_obj_rel_insert_input
    implements
        Built<Gdms_obj_rel_insert_input, Gdms_obj_rel_insert_inputBuilder> {
  Gdms_obj_rel_insert_input._();

  factory Gdms_obj_rel_insert_input(
          [Function(Gdms_obj_rel_insert_inputBuilder b) updates]) =
      _$Gdms_obj_rel_insert_input;

  Gdms_insert_input get data;
  Gdms_on_conflict? get on_conflict;
  static Serializer<Gdms_obj_rel_insert_input> get serializer =>
      _$gdmsObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_obj_rel_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gdms_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gdms_obj_rel_insert_input.serializer, json);
}

abstract class Gdms_on_conflict
    implements Built<Gdms_on_conflict, Gdms_on_conflictBuilder> {
  Gdms_on_conflict._();

  factory Gdms_on_conflict([Function(Gdms_on_conflictBuilder b) updates]) =
      _$Gdms_on_conflict;

  Gdms_constraint get constraint;
  BuiltList<Gdms_update_column> get update_columns;
  Gdms_bool_exp? get where;
  static Serializer<Gdms_on_conflict> get serializer =>
      _$gdmsOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Gdms_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_on_conflict.serializer, json);
}

abstract class Gdms_order_by
    implements Built<Gdms_order_by, Gdms_order_byBuilder> {
  Gdms_order_by._();

  factory Gdms_order_by([Function(Gdms_order_byBuilder b) updates]) =
      _$Gdms_order_by;

  Gorder_by? get id;
  Gmessages_aggregate_order_by? get messages_aggregate;
  Gorder_by? get name;
  Guser_to_dm_aggregate_order_by? get user_to_dms_aggregate;
  static Serializer<Gdms_order_by> get serializer => _$gdmsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gdms_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_order_by.serializer, json);
}

abstract class Gdms_pk_columns_input
    implements Built<Gdms_pk_columns_input, Gdms_pk_columns_inputBuilder> {
  Gdms_pk_columns_input._();

  factory Gdms_pk_columns_input(
          [Function(Gdms_pk_columns_inputBuilder b) updates]) =
      _$Gdms_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Gdms_pk_columns_input> get serializer =>
      _$gdmsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_pk_columns_input.serializer, this)
          as Map<String, dynamic>);
  static Gdms_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_pk_columns_input.serializer, json);
}

class Gdms_select_column extends EnumClass {
  const Gdms_select_column._(String name) : super(name);

  static const Gdms_select_column id = _$gdmsSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gdms_select_column Gname = _$gdmsSelectColumnGname;

  static Serializer<Gdms_select_column> get serializer =>
      _$gdmsSelectColumnSerializer;
  static BuiltSet<Gdms_select_column> get values => _$gdmsSelectColumnValues;
  static Gdms_select_column valueOf(String name) =>
      _$gdmsSelectColumnValueOf(name);
}

abstract class Gdms_set_input
    implements Built<Gdms_set_input, Gdms_set_inputBuilder> {
  Gdms_set_input._();

  factory Gdms_set_input([Function(Gdms_set_inputBuilder b) updates]) =
      _$Gdms_set_input;

  _i2.UuidType? get id;
  String? get name;
  static Serializer<Gdms_set_input> get serializer => _$gdmsSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gdms_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gdms_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gdms_set_input.serializer, json);
}

class Gdms_update_column extends EnumClass {
  const Gdms_update_column._(String name) : super(name);

  static const Gdms_update_column id = _$gdmsUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gdms_update_column Gname = _$gdmsUpdateColumnGname;

  static Serializer<Gdms_update_column> get serializer =>
      _$gdmsUpdateColumnSerializer;
  static BuiltSet<Gdms_update_column> get values => _$gdmsUpdateColumnValues;
  static Gdms_update_column valueOf(String name) =>
      _$gdmsUpdateColumnValueOf(name);
}

abstract class Ggroup_metadata_bool_exp
    implements
        Built<Ggroup_metadata_bool_exp, Ggroup_metadata_bool_expBuilder> {
  Ggroup_metadata_bool_exp._();

  factory Ggroup_metadata_bool_exp(
          [Function(Ggroup_metadata_bool_expBuilder b) updates]) =
      _$Ggroup_metadata_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Ggroup_metadata_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Ggroup_metadata_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Ggroup_metadata_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get owner_id;
  Gusers_bool_exp? get user;
  static Serializer<Ggroup_metadata_bool_exp> get serializer =>
      _$ggroupMetadataBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_metadata_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_metadata_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_bool_exp.serializer, json);
}

class Ggroup_metadata_constraint extends EnumClass {
  const Ggroup_metadata_constraint._(String name) : super(name);

  static const Ggroup_metadata_constraint group_metadata_pkey =
      _$ggroupMetadataConstraintgroup_metadata_pkey;

  static Serializer<Ggroup_metadata_constraint> get serializer =>
      _$ggroupMetadataConstraintSerializer;
  static BuiltSet<Ggroup_metadata_constraint> get values =>
      _$ggroupMetadataConstraintValues;
  static Ggroup_metadata_constraint valueOf(String name) =>
      _$ggroupMetadataConstraintValueOf(name);
}

abstract class Ggroup_metadata_insert_input
    implements
        Built<Ggroup_metadata_insert_input,
            Ggroup_metadata_insert_inputBuilder> {
  Ggroup_metadata_insert_input._();

  factory Ggroup_metadata_insert_input(
          [Function(Ggroup_metadata_insert_inputBuilder b) updates]) =
      _$Ggroup_metadata_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get owner_id;
  Gusers_obj_rel_insert_input? get user;
  static Serializer<Ggroup_metadata_insert_input> get serializer =>
      _$ggroupMetadataInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_metadata_insert_input.serializer, this) as Map<String, dynamic>);
  static Ggroup_metadata_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_insert_input.serializer, json);
}

abstract class Ggroup_metadata_obj_rel_insert_input
    implements
        Built<Ggroup_metadata_obj_rel_insert_input,
            Ggroup_metadata_obj_rel_insert_inputBuilder> {
  Ggroup_metadata_obj_rel_insert_input._();

  factory Ggroup_metadata_obj_rel_insert_input(
          [Function(Ggroup_metadata_obj_rel_insert_inputBuilder b) updates]) =
      _$Ggroup_metadata_obj_rel_insert_input;

  Ggroup_metadata_insert_input get data;
  Ggroup_metadata_on_conflict? get on_conflict;
  static Serializer<Ggroup_metadata_obj_rel_insert_input> get serializer =>
      _$ggroupMetadataObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_metadata_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_metadata_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Ggroup_metadata_obj_rel_insert_input.serializer, json);
}

abstract class Ggroup_metadata_on_conflict
    implements
        Built<Ggroup_metadata_on_conflict, Ggroup_metadata_on_conflictBuilder> {
  Ggroup_metadata_on_conflict._();

  factory Ggroup_metadata_on_conflict(
          [Function(Ggroup_metadata_on_conflictBuilder b) updates]) =
      _$Ggroup_metadata_on_conflict;

  Ggroup_metadata_constraint get constraint;
  BuiltList<Ggroup_metadata_update_column> get update_columns;
  Ggroup_metadata_bool_exp? get where;
  static Serializer<Ggroup_metadata_on_conflict> get serializer =>
      _$ggroupMetadataOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Ggroup_metadata_on_conflict.serializer, this) as Map<String, dynamic>);
  static Ggroup_metadata_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_on_conflict.serializer, json);
}

abstract class Ggroup_metadata_order_by
    implements
        Built<Ggroup_metadata_order_by, Ggroup_metadata_order_byBuilder> {
  Ggroup_metadata_order_by._();

  factory Ggroup_metadata_order_by(
          [Function(Ggroup_metadata_order_byBuilder b) updates]) =
      _$Ggroup_metadata_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get owner_id;
  Gusers_order_by? get user;
  static Serializer<Ggroup_metadata_order_by> get serializer =>
      _$ggroupMetadataOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_metadata_order_by.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_metadata_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_order_by.serializer, json);
}

abstract class Ggroup_metadata_pk_columns_input
    implements
        Built<Ggroup_metadata_pk_columns_input,
            Ggroup_metadata_pk_columns_inputBuilder> {
  Ggroup_metadata_pk_columns_input._();

  factory Ggroup_metadata_pk_columns_input(
          [Function(Ggroup_metadata_pk_columns_inputBuilder b) updates]) =
      _$Ggroup_metadata_pk_columns_input;

  _i2.UuidType get group_id;
  static Serializer<Ggroup_metadata_pk_columns_input> get serializer =>
      _$ggroupMetadataPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Ggroup_metadata_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Ggroup_metadata_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_pk_columns_input.serializer, json);
}

class Ggroup_metadata_select_column extends EnumClass {
  const Ggroup_metadata_select_column._(String name) : super(name);

  static const Ggroup_metadata_select_column group_id =
      _$ggroupMetadataSelectColumngroup_id;

  static const Ggroup_metadata_select_column owner_id =
      _$ggroupMetadataSelectColumnowner_id;

  static Serializer<Ggroup_metadata_select_column> get serializer =>
      _$ggroupMetadataSelectColumnSerializer;
  static BuiltSet<Ggroup_metadata_select_column> get values =>
      _$ggroupMetadataSelectColumnValues;
  static Ggroup_metadata_select_column valueOf(String name) =>
      _$ggroupMetadataSelectColumnValueOf(name);
}

abstract class Ggroup_metadata_set_input
    implements
        Built<Ggroup_metadata_set_input, Ggroup_metadata_set_inputBuilder> {
  Ggroup_metadata_set_input._();

  factory Ggroup_metadata_set_input(
          [Function(Ggroup_metadata_set_inputBuilder b) updates]) =
      _$Ggroup_metadata_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get owner_id;
  static Serializer<Ggroup_metadata_set_input> get serializer =>
      _$ggroupMetadataSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Ggroup_metadata_set_input.serializer, this)
          as Map<String, dynamic>);
  static Ggroup_metadata_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Ggroup_metadata_set_input.serializer, json);
}

class Ggroup_metadata_update_column extends EnumClass {
  const Ggroup_metadata_update_column._(String name) : super(name);

  static const Ggroup_metadata_update_column group_id =
      _$ggroupMetadataUpdateColumngroup_id;

  static const Ggroup_metadata_update_column owner_id =
      _$ggroupMetadataUpdateColumnowner_id;

  static Serializer<Ggroup_metadata_update_column> get serializer =>
      _$ggroupMetadataUpdateColumnSerializer;
  static BuiltSet<Ggroup_metadata_update_column> get values =>
      _$ggroupMetadataUpdateColumnValues;
  static Ggroup_metadata_update_column valueOf(String name) =>
      _$ggroupMetadataUpdateColumnValueOf(name);
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
  Ggroup_metadata_bool_exp? get group_metadatum;
  Guuid_comparison_exp? get id;
  GString_comparison_exp? get name;
  Groles_bool_exp? get roles;
  Gthreads_bool_exp? get threads;
  Guser_to_group_bool_exp? get users;
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

  Ggroup_metadata_obj_rel_insert_input? get group_metadatum;
  _i2.UuidType? get id;
  String? get name;
  Groles_arr_rel_insert_input? get roles;
  Gthreads_arr_rel_insert_input? get threads;
  Guser_to_group_arr_rel_insert_input? get users;
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

  Ggroup_metadata_order_by? get group_metadatum;
  Gorder_by? get id;
  Gorder_by? get name;
  Groles_aggregate_order_by? get roles_aggregate;
  Gthreads_aggregate_order_by? get threads_aggregate;
  Guser_to_group_aggregate_order_by? get users_aggregate;
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

  static const Ggroups_select_column id = _$ggroupsSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Ggroups_select_column Gname = _$ggroupsSelectColumnGname;

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

  _i2.UuidType? get id;
  String? get name;
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

  static const Ggroups_update_column id = _$ggroupsUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Ggroups_update_column Gname = _$ggroupsUpdateColumnGname;

  static Serializer<Ggroups_update_column> get serializer =>
      _$ggroupsUpdateColumnSerializer;
  static BuiltSet<Ggroups_update_column> get values =>
      _$ggroupsUpdateColumnValues;
  static Ggroups_update_column valueOf(String name) =>
      _$ggroupsUpdateColumnValueOf(name);
}

class GIdentityProvider extends EnumClass {
  const GIdentityProvider._(String name) : super(name);

  static const GIdentityProvider Debug = _$gIdentityProviderDebug;

  static const GIdentityProvider Google = _$gIdentityProviderGoogle;

  static Serializer<GIdentityProvider> get serializer =>
      _$gIdentityProviderSerializer;
  static BuiltSet<GIdentityProvider> get values => _$gIdentityProviderValues;
  static GIdentityProvider valueOf(String name) =>
      _$gIdentityProviderValueOf(name);
}

abstract class Gjoin_tokens_bool_exp
    implements Built<Gjoin_tokens_bool_exp, Gjoin_tokens_bool_expBuilder> {
  Gjoin_tokens_bool_exp._();

  factory Gjoin_tokens_bool_exp(
          [Function(Gjoin_tokens_bool_expBuilder b) updates]) =
      _$Gjoin_tokens_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gjoin_tokens_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gjoin_tokens_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gjoin_tokens_bool_exp>? get G_or;
  Groles_bool_exp? get role;
  Guuid_comparison_exp? get role_id;
  GString_comparison_exp? get token;
  static Serializer<Gjoin_tokens_bool_exp> get serializer =>
      _$gjoinTokensBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gjoin_tokens_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gjoin_tokens_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gjoin_tokens_bool_exp.serializer, json);
}

class Gjoin_tokens_constraint extends EnumClass {
  const Gjoin_tokens_constraint._(String name) : super(name);

  static const Gjoin_tokens_constraint join_tokens_pkey =
      _$gjoinTokensConstraintjoin_tokens_pkey;

  static Serializer<Gjoin_tokens_constraint> get serializer =>
      _$gjoinTokensConstraintSerializer;
  static BuiltSet<Gjoin_tokens_constraint> get values =>
      _$gjoinTokensConstraintValues;
  static Gjoin_tokens_constraint valueOf(String name) =>
      _$gjoinTokensConstraintValueOf(name);
}

abstract class Gjoin_tokens_insert_input
    implements
        Built<Gjoin_tokens_insert_input, Gjoin_tokens_insert_inputBuilder> {
  Gjoin_tokens_insert_input._();

  factory Gjoin_tokens_insert_input(
          [Function(Gjoin_tokens_insert_inputBuilder b) updates]) =
      _$Gjoin_tokens_insert_input;

  Groles_obj_rel_insert_input? get role;
  _i2.UuidType? get role_id;
  String? get token;
  static Serializer<Gjoin_tokens_insert_input> get serializer =>
      _$gjoinTokensInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gjoin_tokens_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gjoin_tokens_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gjoin_tokens_insert_input.serializer, json);
}

abstract class Gjoin_tokens_obj_rel_insert_input
    implements
        Built<Gjoin_tokens_obj_rel_insert_input,
            Gjoin_tokens_obj_rel_insert_inputBuilder> {
  Gjoin_tokens_obj_rel_insert_input._();

  factory Gjoin_tokens_obj_rel_insert_input(
          [Function(Gjoin_tokens_obj_rel_insert_inputBuilder b) updates]) =
      _$Gjoin_tokens_obj_rel_insert_input;

  Gjoin_tokens_insert_input get data;
  Gjoin_tokens_on_conflict? get on_conflict;
  static Serializer<Gjoin_tokens_obj_rel_insert_input> get serializer =>
      _$gjoinTokensObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gjoin_tokens_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Gjoin_tokens_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gjoin_tokens_obj_rel_insert_input.serializer, json);
}

abstract class Gjoin_tokens_on_conflict
    implements
        Built<Gjoin_tokens_on_conflict, Gjoin_tokens_on_conflictBuilder> {
  Gjoin_tokens_on_conflict._();

  factory Gjoin_tokens_on_conflict(
          [Function(Gjoin_tokens_on_conflictBuilder b) updates]) =
      _$Gjoin_tokens_on_conflict;

  Gjoin_tokens_constraint get constraint;
  BuiltList<Gjoin_tokens_update_column> get update_columns;
  Gjoin_tokens_bool_exp? get where;
  static Serializer<Gjoin_tokens_on_conflict> get serializer =>
      _$gjoinTokensOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gjoin_tokens_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Gjoin_tokens_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gjoin_tokens_on_conflict.serializer, json);
}

abstract class Gjoin_tokens_order_by
    implements Built<Gjoin_tokens_order_by, Gjoin_tokens_order_byBuilder> {
  Gjoin_tokens_order_by._();

  factory Gjoin_tokens_order_by(
          [Function(Gjoin_tokens_order_byBuilder b) updates]) =
      _$Gjoin_tokens_order_by;

  Groles_order_by? get role;
  Gorder_by? get role_id;
  Gorder_by? get token;
  static Serializer<Gjoin_tokens_order_by> get serializer =>
      _$gjoinTokensOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gjoin_tokens_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gjoin_tokens_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gjoin_tokens_order_by.serializer, json);
}

abstract class Gjoin_tokens_pk_columns_input
    implements
        Built<Gjoin_tokens_pk_columns_input,
            Gjoin_tokens_pk_columns_inputBuilder> {
  Gjoin_tokens_pk_columns_input._();

  factory Gjoin_tokens_pk_columns_input(
          [Function(Gjoin_tokens_pk_columns_inputBuilder b) updates]) =
      _$Gjoin_tokens_pk_columns_input;

  _i2.UuidType get role_id;
  static Serializer<Gjoin_tokens_pk_columns_input> get serializer =>
      _$gjoinTokensPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gjoin_tokens_pk_columns_input.serializer, this) as Map<String, dynamic>);
  static Gjoin_tokens_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gjoin_tokens_pk_columns_input.serializer, json);
}

class Gjoin_tokens_select_column extends EnumClass {
  const Gjoin_tokens_select_column._(String name) : super(name);

  static const Gjoin_tokens_select_column role_id =
      _$gjoinTokensSelectColumnrole_id;

  static const Gjoin_tokens_select_column token =
      _$gjoinTokensSelectColumntoken;

  static Serializer<Gjoin_tokens_select_column> get serializer =>
      _$gjoinTokensSelectColumnSerializer;
  static BuiltSet<Gjoin_tokens_select_column> get values =>
      _$gjoinTokensSelectColumnValues;
  static Gjoin_tokens_select_column valueOf(String name) =>
      _$gjoinTokensSelectColumnValueOf(name);
}

abstract class Gjoin_tokens_set_input
    implements Built<Gjoin_tokens_set_input, Gjoin_tokens_set_inputBuilder> {
  Gjoin_tokens_set_input._();

  factory Gjoin_tokens_set_input(
          [Function(Gjoin_tokens_set_inputBuilder b) updates]) =
      _$Gjoin_tokens_set_input;

  _i2.UuidType? get role_id;
  String? get token;
  static Serializer<Gjoin_tokens_set_input> get serializer =>
      _$gjoinTokensSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gjoin_tokens_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gjoin_tokens_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gjoin_tokens_set_input.serializer, json);
}

class Gjoin_tokens_update_column extends EnumClass {
  const Gjoin_tokens_update_column._(String name) : super(name);

  static const Gjoin_tokens_update_column role_id =
      _$gjoinTokensUpdateColumnrole_id;

  static const Gjoin_tokens_update_column token =
      _$gjoinTokensUpdateColumntoken;

  static Serializer<Gjoin_tokens_update_column> get serializer =>
      _$gjoinTokensUpdateColumnSerializer;
  static BuiltSet<Gjoin_tokens_update_column> get values =>
      _$gjoinTokensUpdateColumnValues;
  static Gjoin_tokens_update_column valueOf(String name) =>
      _$gjoinTokensUpdateColumnValueOf(name);
}

abstract class Gmessage_reaction_types_bool_exp
    implements
        Built<Gmessage_reaction_types_bool_exp,
            Gmessage_reaction_types_bool_expBuilder> {
  Gmessage_reaction_types_bool_exp._();

  factory Gmessage_reaction_types_bool_exp(
          [Function(Gmessage_reaction_types_bool_expBuilder b) updates]) =
      _$Gmessage_reaction_types_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gmessage_reaction_types_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gmessage_reaction_types_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gmessage_reaction_types_bool_exp>? get G_or;
  GString_comparison_exp? get description;
  Gmessage_reactions_bool_exp? get message_reactions;
  GString_comparison_exp? get reaction_type;
  static Serializer<Gmessage_reaction_types_bool_exp> get serializer =>
      _$gmessageReactionTypesBoolExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reaction_types_bool_exp.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_bool_exp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reaction_types_bool_exp.serializer, json);
}

class Gmessage_reaction_types_constraint extends EnumClass {
  const Gmessage_reaction_types_constraint._(String name) : super(name);

  static const Gmessage_reaction_types_constraint message_reaction_types_pkey =
      _$gmessageReactionTypesConstraintmessage_reaction_types_pkey;

  static Serializer<Gmessage_reaction_types_constraint> get serializer =>
      _$gmessageReactionTypesConstraintSerializer;
  static BuiltSet<Gmessage_reaction_types_constraint> get values =>
      _$gmessageReactionTypesConstraintValues;
  static Gmessage_reaction_types_constraint valueOf(String name) =>
      _$gmessageReactionTypesConstraintValueOf(name);
}

class Gmessage_reaction_types_enum extends EnumClass {
  const Gmessage_reaction_types_enum._(String name) : super(name);

  static const Gmessage_reaction_types_enum ANGRY =
      _$gmessageReactionTypesEnumANGRY;

  static const Gmessage_reaction_types_enum HEART =
      _$gmessageReactionTypesEnumHEART;

  static const Gmessage_reaction_types_enum LAUGH =
      _$gmessageReactionTypesEnumLAUGH;

  static const Gmessage_reaction_types_enum STRAIGHT =
      _$gmessageReactionTypesEnumSTRAIGHT;

  static const Gmessage_reaction_types_enum WOW =
      _$gmessageReactionTypesEnumWOW;

  static Serializer<Gmessage_reaction_types_enum> get serializer =>
      _$gmessageReactionTypesEnumSerializer;
  static BuiltSet<Gmessage_reaction_types_enum> get values =>
      _$gmessageReactionTypesEnumValues;
  static Gmessage_reaction_types_enum valueOf(String name) =>
      _$gmessageReactionTypesEnumValueOf(name);
}

abstract class Gmessage_reaction_types_enum_comparison_exp
    implements
        Built<Gmessage_reaction_types_enum_comparison_exp,
            Gmessage_reaction_types_enum_comparison_expBuilder> {
  Gmessage_reaction_types_enum_comparison_exp._();

  factory Gmessage_reaction_types_enum_comparison_exp(
      [Function(Gmessage_reaction_types_enum_comparison_expBuilder b)
          updates]) = _$Gmessage_reaction_types_enum_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  Gmessage_reaction_types_enum? get G_eq;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gmessage_reaction_types_enum>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_neq')
  Gmessage_reaction_types_enum? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gmessage_reaction_types_enum>? get G_nin;
  static Serializer<Gmessage_reaction_types_enum_comparison_exp>
      get serializer => _$gmessageReactionTypesEnumComparisonExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          Gmessage_reaction_types_enum_comparison_exp.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_enum_comparison_exp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reaction_types_enum_comparison_exp.serializer, json);
}

abstract class Gmessage_reaction_types_insert_input
    implements
        Built<Gmessage_reaction_types_insert_input,
            Gmessage_reaction_types_insert_inputBuilder> {
  Gmessage_reaction_types_insert_input._();

  factory Gmessage_reaction_types_insert_input(
          [Function(Gmessage_reaction_types_insert_inputBuilder b) updates]) =
      _$Gmessage_reaction_types_insert_input;

  String? get description;
  Gmessage_reactions_arr_rel_insert_input? get message_reactions;
  String? get reaction_type;
  static Serializer<Gmessage_reaction_types_insert_input> get serializer =>
      _$gmessageReactionTypesInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reaction_types_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reaction_types_insert_input.serializer, json);
}

abstract class Gmessage_reaction_types_obj_rel_insert_input
    implements
        Built<Gmessage_reaction_types_obj_rel_insert_input,
            Gmessage_reaction_types_obj_rel_insert_inputBuilder> {
  Gmessage_reaction_types_obj_rel_insert_input._();

  factory Gmessage_reaction_types_obj_rel_insert_input(
      [Function(Gmessage_reaction_types_obj_rel_insert_inputBuilder b)
          updates]) = _$Gmessage_reaction_types_obj_rel_insert_input;

  Gmessage_reaction_types_insert_input get data;
  Gmessage_reaction_types_on_conflict? get on_conflict;
  static Serializer<Gmessage_reaction_types_obj_rel_insert_input>
      get serializer => _$gmessageReactionTypesObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          Gmessage_reaction_types_obj_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_obj_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reaction_types_obj_rel_insert_input.serializer, json);
}

abstract class Gmessage_reaction_types_on_conflict
    implements
        Built<Gmessage_reaction_types_on_conflict,
            Gmessage_reaction_types_on_conflictBuilder> {
  Gmessage_reaction_types_on_conflict._();

  factory Gmessage_reaction_types_on_conflict(
          [Function(Gmessage_reaction_types_on_conflictBuilder b) updates]) =
      _$Gmessage_reaction_types_on_conflict;

  Gmessage_reaction_types_constraint get constraint;
  BuiltList<Gmessage_reaction_types_update_column> get update_columns;
  Gmessage_reaction_types_bool_exp? get where;
  static Serializer<Gmessage_reaction_types_on_conflict> get serializer =>
      _$gmessageReactionTypesOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reaction_types_on_conflict.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_on_conflict? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reaction_types_on_conflict.serializer, json);
}

abstract class Gmessage_reaction_types_order_by
    implements
        Built<Gmessage_reaction_types_order_by,
            Gmessage_reaction_types_order_byBuilder> {
  Gmessage_reaction_types_order_by._();

  factory Gmessage_reaction_types_order_by(
          [Function(Gmessage_reaction_types_order_byBuilder b) updates]) =
      _$Gmessage_reaction_types_order_by;

  Gorder_by? get description;
  Gmessage_reactions_aggregate_order_by? get message_reactions_aggregate;
  Gorder_by? get reaction_type;
  static Serializer<Gmessage_reaction_types_order_by> get serializer =>
      _$gmessageReactionTypesOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reaction_types_order_by.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reaction_types_order_by.serializer, json);
}

abstract class Gmessage_reaction_types_pk_columns_input
    implements
        Built<Gmessage_reaction_types_pk_columns_input,
            Gmessage_reaction_types_pk_columns_inputBuilder> {
  Gmessage_reaction_types_pk_columns_input._();

  factory Gmessage_reaction_types_pk_columns_input(
      [Function(Gmessage_reaction_types_pk_columns_inputBuilder b)
          updates]) = _$Gmessage_reaction_types_pk_columns_input;

  String get reaction_type;
  static Serializer<Gmessage_reaction_types_pk_columns_input> get serializer =>
      _$gmessageReactionTypesPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          Gmessage_reaction_types_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reaction_types_pk_columns_input.serializer, json);
}

class Gmessage_reaction_types_select_column extends EnumClass {
  const Gmessage_reaction_types_select_column._(String name) : super(name);

  static const Gmessage_reaction_types_select_column description =
      _$gmessageReactionTypesSelectColumndescription;

  static const Gmessage_reaction_types_select_column reaction_type =
      _$gmessageReactionTypesSelectColumnreaction_type;

  static Serializer<Gmessage_reaction_types_select_column> get serializer =>
      _$gmessageReactionTypesSelectColumnSerializer;
  static BuiltSet<Gmessage_reaction_types_select_column> get values =>
      _$gmessageReactionTypesSelectColumnValues;
  static Gmessage_reaction_types_select_column valueOf(String name) =>
      _$gmessageReactionTypesSelectColumnValueOf(name);
}

abstract class Gmessage_reaction_types_set_input
    implements
        Built<Gmessage_reaction_types_set_input,
            Gmessage_reaction_types_set_inputBuilder> {
  Gmessage_reaction_types_set_input._();

  factory Gmessage_reaction_types_set_input(
          [Function(Gmessage_reaction_types_set_inputBuilder b) updates]) =
      _$Gmessage_reaction_types_set_input;

  String? get description;
  String? get reaction_type;
  static Serializer<Gmessage_reaction_types_set_input> get serializer =>
      _$gmessageReactionTypesSetInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reaction_types_set_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reaction_types_set_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reaction_types_set_input.serializer, json);
}

class Gmessage_reaction_types_update_column extends EnumClass {
  const Gmessage_reaction_types_update_column._(String name) : super(name);

  static const Gmessage_reaction_types_update_column description =
      _$gmessageReactionTypesUpdateColumndescription;

  static const Gmessage_reaction_types_update_column reaction_type =
      _$gmessageReactionTypesUpdateColumnreaction_type;

  static Serializer<Gmessage_reaction_types_update_column> get serializer =>
      _$gmessageReactionTypesUpdateColumnSerializer;
  static BuiltSet<Gmessage_reaction_types_update_column> get values =>
      _$gmessageReactionTypesUpdateColumnValues;
  static Gmessage_reaction_types_update_column valueOf(String name) =>
      _$gmessageReactionTypesUpdateColumnValueOf(name);
}

abstract class Gmessage_reactions_aggregate_order_by
    implements
        Built<Gmessage_reactions_aggregate_order_by,
            Gmessage_reactions_aggregate_order_byBuilder> {
  Gmessage_reactions_aggregate_order_by._();

  factory Gmessage_reactions_aggregate_order_by(
          [Function(Gmessage_reactions_aggregate_order_byBuilder b) updates]) =
      _$Gmessage_reactions_aggregate_order_by;

  Gorder_by? get count;
  Gmessage_reactions_max_order_by? get max;
  Gmessage_reactions_min_order_by? get min;
  static Serializer<Gmessage_reactions_aggregate_order_by> get serializer =>
      _$gmessageReactionsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reactions_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reactions_aggregate_order_by.serializer, json);
}

abstract class Gmessage_reactions_arr_rel_insert_input
    implements
        Built<Gmessage_reactions_arr_rel_insert_input,
            Gmessage_reactions_arr_rel_insert_inputBuilder> {
  Gmessage_reactions_arr_rel_insert_input._();

  factory Gmessage_reactions_arr_rel_insert_input(
      [Function(Gmessage_reactions_arr_rel_insert_inputBuilder b)
          updates]) = _$Gmessage_reactions_arr_rel_insert_input;

  BuiltList<Gmessage_reactions_insert_input> get data;
  Gmessage_reactions_on_conflict? get on_conflict;
  static Serializer<Gmessage_reactions_arr_rel_insert_input> get serializer =>
      _$gmessageReactionsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
          Gmessage_reactions_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reactions_arr_rel_insert_input.serializer, json);
}

abstract class Gmessage_reactions_bool_exp
    implements
        Built<Gmessage_reactions_bool_exp, Gmessage_reactions_bool_expBuilder> {
  Gmessage_reactions_bool_exp._();

  factory Gmessage_reactions_bool_exp(
          [Function(Gmessage_reactions_bool_expBuilder b) updates]) =
      _$Gmessage_reactions_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gmessage_reactions_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gmessage_reactions_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gmessage_reactions_bool_exp>? get G_or;
  Gtimestamptz_comparison_exp? get created_at;
  GBoolean_comparison_exp? get deleted;
  Guuid_comparison_exp? get id;
  Gmessages_bool_exp? get message;
  Guuid_comparison_exp? get message_id;
  Gmessage_reaction_types_bool_exp? get message_reaction_type;
  Gmessage_reaction_types_enum_comparison_exp? get reaction_type;
  Gtimestamptz_comparison_exp? get updated_at;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Gmessage_reactions_bool_exp> get serializer =>
      _$gmessageReactionsBoolExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_reactions_bool_exp.serializer, this) as Map<String, dynamic>);
  static Gmessage_reactions_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_bool_exp.serializer, json);
}

class Gmessage_reactions_constraint extends EnumClass {
  const Gmessage_reactions_constraint._(String name) : super(name);

  static const Gmessage_reactions_constraint message_reactions_pkey =
      _$gmessageReactionsConstraintmessage_reactions_pkey;

  static Serializer<Gmessage_reactions_constraint> get serializer =>
      _$gmessageReactionsConstraintSerializer;
  static BuiltSet<Gmessage_reactions_constraint> get values =>
      _$gmessageReactionsConstraintValues;
  static Gmessage_reactions_constraint valueOf(String name) =>
      _$gmessageReactionsConstraintValueOf(name);
}

abstract class Gmessage_reactions_insert_input
    implements
        Built<Gmessage_reactions_insert_input,
            Gmessage_reactions_insert_inputBuilder> {
  Gmessage_reactions_insert_input._();

  factory Gmessage_reactions_insert_input(
          [Function(Gmessage_reactions_insert_inputBuilder b) updates]) =
      _$Gmessage_reactions_insert_input;

  DateTime? get created_at;
  bool? get deleted;
  _i2.UuidType? get id;
  Gmessages_obj_rel_insert_input? get message;
  _i2.UuidType? get message_id;
  Gmessage_reaction_types_obj_rel_insert_input? get message_reaction_type;
  Gmessage_reaction_types_enum? get reaction_type;
  DateTime? get updated_at;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Gmessage_reactions_insert_input> get serializer =>
      _$gmessageReactionsInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reactions_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_insert_input.serializer, json);
}

abstract class Gmessage_reactions_max_order_by
    implements
        Built<Gmessage_reactions_max_order_by,
            Gmessage_reactions_max_order_byBuilder> {
  Gmessage_reactions_max_order_by._();

  factory Gmessage_reactions_max_order_by(
          [Function(Gmessage_reactions_max_order_byBuilder b) updates]) =
      _$Gmessage_reactions_max_order_by;

  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get message_id;
  Gorder_by? get updated_at;
  Gorder_by? get user_id;
  static Serializer<Gmessage_reactions_max_order_by> get serializer =>
      _$gmessageReactionsMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reactions_max_order_by.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_max_order_by.serializer, json);
}

abstract class Gmessage_reactions_min_order_by
    implements
        Built<Gmessage_reactions_min_order_by,
            Gmessage_reactions_min_order_byBuilder> {
  Gmessage_reactions_min_order_by._();

  factory Gmessage_reactions_min_order_by(
          [Function(Gmessage_reactions_min_order_byBuilder b) updates]) =
      _$Gmessage_reactions_min_order_by;

  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get message_id;
  Gorder_by? get updated_at;
  Gorder_by? get user_id;
  static Serializer<Gmessage_reactions_min_order_by> get serializer =>
      _$gmessageReactionsMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reactions_min_order_by.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_min_order_by.serializer, json);
}

abstract class Gmessage_reactions_on_conflict
    implements
        Built<Gmessage_reactions_on_conflict,
            Gmessage_reactions_on_conflictBuilder> {
  Gmessage_reactions_on_conflict._();

  factory Gmessage_reactions_on_conflict(
          [Function(Gmessage_reactions_on_conflictBuilder b) updates]) =
      _$Gmessage_reactions_on_conflict;

  Gmessage_reactions_constraint get constraint;
  BuiltList<Gmessage_reactions_update_column> get update_columns;
  Gmessage_reactions_bool_exp? get where;
  static Serializer<Gmessage_reactions_on_conflict> get serializer =>
      _$gmessageReactionsOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_reactions_on_conflict.serializer, this) as Map<String, dynamic>);
  static Gmessage_reactions_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_on_conflict.serializer, json);
}

abstract class Gmessage_reactions_order_by
    implements
        Built<Gmessage_reactions_order_by, Gmessage_reactions_order_byBuilder> {
  Gmessage_reactions_order_by._();

  factory Gmessage_reactions_order_by(
          [Function(Gmessage_reactions_order_byBuilder b) updates]) =
      _$Gmessage_reactions_order_by;

  Gorder_by? get created_at;
  Gorder_by? get deleted;
  Gorder_by? get id;
  Gmessages_order_by? get message;
  Gorder_by? get message_id;
  Gmessage_reaction_types_order_by? get message_reaction_type;
  Gorder_by? get reaction_type;
  Gorder_by? get updated_at;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Gmessage_reactions_order_by> get serializer =>
      _$gmessageReactionsOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_reactions_order_by.serializer, this) as Map<String, dynamic>);
  static Gmessage_reactions_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_order_by.serializer, json);
}

abstract class Gmessage_reactions_pk_columns_input
    implements
        Built<Gmessage_reactions_pk_columns_input,
            Gmessage_reactions_pk_columns_inputBuilder> {
  Gmessage_reactions_pk_columns_input._();

  factory Gmessage_reactions_pk_columns_input(
          [Function(Gmessage_reactions_pk_columns_inputBuilder b) updates]) =
      _$Gmessage_reactions_pk_columns_input;

  _i2.UuidType get message_id;
  Gmessage_reaction_types_enum get reaction_type;
  _i2.UuidType get user_id;
  static Serializer<Gmessage_reactions_pk_columns_input> get serializer =>
      _$gmessageReactionsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_reactions_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_reactions_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Gmessage_reactions_pk_columns_input.serializer, json);
}

class Gmessage_reactions_select_column extends EnumClass {
  const Gmessage_reactions_select_column._(String name) : super(name);

  static const Gmessage_reactions_select_column created_at =
      _$gmessageReactionsSelectColumncreated_at;

  static const Gmessage_reactions_select_column deleted =
      _$gmessageReactionsSelectColumndeleted;

  static const Gmessage_reactions_select_column id =
      _$gmessageReactionsSelectColumnid;

  static const Gmessage_reactions_select_column message_id =
      _$gmessageReactionsSelectColumnmessage_id;

  static const Gmessage_reactions_select_column reaction_type =
      _$gmessageReactionsSelectColumnreaction_type;

  static const Gmessage_reactions_select_column updated_at =
      _$gmessageReactionsSelectColumnupdated_at;

  static const Gmessage_reactions_select_column user_id =
      _$gmessageReactionsSelectColumnuser_id;

  static Serializer<Gmessage_reactions_select_column> get serializer =>
      _$gmessageReactionsSelectColumnSerializer;
  static BuiltSet<Gmessage_reactions_select_column> get values =>
      _$gmessageReactionsSelectColumnValues;
  static Gmessage_reactions_select_column valueOf(String name) =>
      _$gmessageReactionsSelectColumnValueOf(name);
}

abstract class Gmessage_reactions_set_input
    implements
        Built<Gmessage_reactions_set_input,
            Gmessage_reactions_set_inputBuilder> {
  Gmessage_reactions_set_input._();

  factory Gmessage_reactions_set_input(
          [Function(Gmessage_reactions_set_inputBuilder b) updates]) =
      _$Gmessage_reactions_set_input;

  DateTime? get created_at;
  bool? get deleted;
  _i2.UuidType? get id;
  _i2.UuidType? get message_id;
  Gmessage_reaction_types_enum? get reaction_type;
  DateTime? get updated_at;
  _i2.UuidType? get user_id;
  static Serializer<Gmessage_reactions_set_input> get serializer =>
      _$gmessageReactionsSetInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_reactions_set_input.serializer, this) as Map<String, dynamic>);
  static Gmessage_reactions_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_reactions_set_input.serializer, json);
}

class Gmessage_reactions_update_column extends EnumClass {
  const Gmessage_reactions_update_column._(String name) : super(name);

  static const Gmessage_reactions_update_column created_at =
      _$gmessageReactionsUpdateColumncreated_at;

  static const Gmessage_reactions_update_column deleted =
      _$gmessageReactionsUpdateColumndeleted;

  static const Gmessage_reactions_update_column id =
      _$gmessageReactionsUpdateColumnid;

  static const Gmessage_reactions_update_column message_id =
      _$gmessageReactionsUpdateColumnmessage_id;

  static const Gmessage_reactions_update_column reaction_type =
      _$gmessageReactionsUpdateColumnreaction_type;

  static const Gmessage_reactions_update_column updated_at =
      _$gmessageReactionsUpdateColumnupdated_at;

  static const Gmessage_reactions_update_column user_id =
      _$gmessageReactionsUpdateColumnuser_id;

  static Serializer<Gmessage_reactions_update_column> get serializer =>
      _$gmessageReactionsUpdateColumnSerializer;
  static BuiltSet<Gmessage_reactions_update_column> get values =>
      _$gmessageReactionsUpdateColumnValues;
  static Gmessage_reactions_update_column valueOf(String name) =>
      _$gmessageReactionsUpdateColumnValueOf(name);
}

abstract class Gmessage_types_bool_exp
    implements Built<Gmessage_types_bool_exp, Gmessage_types_bool_expBuilder> {
  Gmessage_types_bool_exp._();

  factory Gmessage_types_bool_exp(
          [Function(Gmessage_types_bool_expBuilder b) updates]) =
      _$Gmessage_types_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gmessage_types_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gmessage_types_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gmessage_types_bool_exp>? get G_or;
  GString_comparison_exp? get description;
  GString_comparison_exp? get message_type;
  static Serializer<Gmessage_types_bool_exp> get serializer =>
      _$gmessageTypesBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessage_types_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gmessage_types_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessage_types_bool_exp.serializer, json);
}

class Gmessage_types_constraint extends EnumClass {
  const Gmessage_types_constraint._(String name) : super(name);

  static const Gmessage_types_constraint message_types_pkey =
      _$gmessageTypesConstraintmessage_types_pkey;

  static Serializer<Gmessage_types_constraint> get serializer =>
      _$gmessageTypesConstraintSerializer;
  static BuiltSet<Gmessage_types_constraint> get values =>
      _$gmessageTypesConstraintValues;
  static Gmessage_types_constraint valueOf(String name) =>
      _$gmessageTypesConstraintValueOf(name);
}

class Gmessage_types_enum extends EnumClass {
  const Gmessage_types_enum._(String name) : super(name);

  static const Gmessage_types_enum IMAGE = _$gmessageTypesEnumIMAGE;

  static const Gmessage_types_enum TEXT = _$gmessageTypesEnumTEXT;

  static Serializer<Gmessage_types_enum> get serializer =>
      _$gmessageTypesEnumSerializer;
  static BuiltSet<Gmessage_types_enum> get values => _$gmessageTypesEnumValues;
  static Gmessage_types_enum valueOf(String name) =>
      _$gmessageTypesEnumValueOf(name);
}

abstract class Gmessage_types_enum_comparison_exp
    implements
        Built<Gmessage_types_enum_comparison_exp,
            Gmessage_types_enum_comparison_expBuilder> {
  Gmessage_types_enum_comparison_exp._();

  factory Gmessage_types_enum_comparison_exp(
          [Function(Gmessage_types_enum_comparison_expBuilder b) updates]) =
      _$Gmessage_types_enum_comparison_exp;

  @BuiltValueField(wireName: '_eq')
  Gmessage_types_enum? get G_eq;
  @BuiltValueField(wireName: '_in')
  BuiltList<Gmessage_types_enum>? get G_in;
  @BuiltValueField(wireName: '_is_null')
  bool? get G_is_null;
  @BuiltValueField(wireName: '_neq')
  Gmessage_types_enum? get G_neq;
  @BuiltValueField(wireName: '_nin')
  BuiltList<Gmessage_types_enum>? get G_nin;
  static Serializer<Gmessage_types_enum_comparison_exp> get serializer =>
      _$gmessageTypesEnumComparisonExpSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_types_enum_comparison_exp.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_types_enum_comparison_exp? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_types_enum_comparison_exp.serializer, json);
}

abstract class Gmessage_types_insert_input
    implements
        Built<Gmessage_types_insert_input, Gmessage_types_insert_inputBuilder> {
  Gmessage_types_insert_input._();

  factory Gmessage_types_insert_input(
          [Function(Gmessage_types_insert_inputBuilder b) updates]) =
      _$Gmessage_types_insert_input;

  String? get description;
  String? get message_type;
  static Serializer<Gmessage_types_insert_input> get serializer =>
      _$gmessageTypesInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_types_insert_input.serializer, this) as Map<String, dynamic>);
  static Gmessage_types_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_types_insert_input.serializer, json);
}

abstract class Gmessage_types_on_conflict
    implements
        Built<Gmessage_types_on_conflict, Gmessage_types_on_conflictBuilder> {
  Gmessage_types_on_conflict._();

  factory Gmessage_types_on_conflict(
          [Function(Gmessage_types_on_conflictBuilder b) updates]) =
      _$Gmessage_types_on_conflict;

  Gmessage_types_constraint get constraint;
  BuiltList<Gmessage_types_update_column> get update_columns;
  Gmessage_types_bool_exp? get where;
  static Serializer<Gmessage_types_on_conflict> get serializer =>
      _$gmessageTypesOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessage_types_on_conflict.serializer, this) as Map<String, dynamic>);
  static Gmessage_types_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_types_on_conflict.serializer, json);
}

abstract class Gmessage_types_order_by
    implements Built<Gmessage_types_order_by, Gmessage_types_order_byBuilder> {
  Gmessage_types_order_by._();

  factory Gmessage_types_order_by(
          [Function(Gmessage_types_order_byBuilder b) updates]) =
      _$Gmessage_types_order_by;

  Gorder_by? get description;
  Gorder_by? get message_type;
  static Serializer<Gmessage_types_order_by> get serializer =>
      _$gmessageTypesOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessage_types_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gmessage_types_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gmessage_types_order_by.serializer, json);
}

abstract class Gmessage_types_pk_columns_input
    implements
        Built<Gmessage_types_pk_columns_input,
            Gmessage_types_pk_columns_inputBuilder> {
  Gmessage_types_pk_columns_input._();

  factory Gmessage_types_pk_columns_input(
          [Function(Gmessage_types_pk_columns_inputBuilder b) updates]) =
      _$Gmessage_types_pk_columns_input;

  String get message_type;
  static Serializer<Gmessage_types_pk_columns_input> get serializer =>
      _$gmessageTypesPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Gmessage_types_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Gmessage_types_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_types_pk_columns_input.serializer, json);
}

class Gmessage_types_select_column extends EnumClass {
  const Gmessage_types_select_column._(String name) : super(name);

  static const Gmessage_types_select_column description =
      _$gmessageTypesSelectColumndescription;

  static const Gmessage_types_select_column message_type =
      _$gmessageTypesSelectColumnmessage_type;

  static Serializer<Gmessage_types_select_column> get serializer =>
      _$gmessageTypesSelectColumnSerializer;
  static BuiltSet<Gmessage_types_select_column> get values =>
      _$gmessageTypesSelectColumnValues;
  static Gmessage_types_select_column valueOf(String name) =>
      _$gmessageTypesSelectColumnValueOf(name);
}

abstract class Gmessage_types_set_input
    implements
        Built<Gmessage_types_set_input, Gmessage_types_set_inputBuilder> {
  Gmessage_types_set_input._();

  factory Gmessage_types_set_input(
          [Function(Gmessage_types_set_inputBuilder b) updates]) =
      _$Gmessage_types_set_input;

  String? get description;
  String? get message_type;
  static Serializer<Gmessage_types_set_input> get serializer =>
      _$gmessageTypesSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gmessage_types_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gmessage_types_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessage_types_set_input.serializer, json);
}

class Gmessage_types_update_column extends EnumClass {
  const Gmessage_types_update_column._(String name) : super(name);

  static const Gmessage_types_update_column description =
      _$gmessageTypesUpdateColumndescription;

  static const Gmessage_types_update_column message_type =
      _$gmessageTypesUpdateColumnmessage_type;

  static Serializer<Gmessage_types_update_column> get serializer =>
      _$gmessageTypesUpdateColumnSerializer;
  static BuiltSet<Gmessage_types_update_column> get values =>
      _$gmessageTypesUpdateColumnValues;
  static Gmessage_types_update_column valueOf(String name) =>
      _$gmessageTypesUpdateColumnValueOf(name);
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
  GString_comparison_exp? get body;
  Gtimestamptz_comparison_exp? get created_at;
  GBoolean_comparison_exp? get deleted;
  Gdms_bool_exp? get dm;
  Guuid_comparison_exp? get id;
  Gmessage_reactions_bool_exp? get message_reactions;
  Gmessage_types_enum_comparison_exp? get message_type;
  Guuid_comparison_exp? get source_id;
  Gthreads_bool_exp? get thread;
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

  String? get body;
  DateTime? get created_at;
  bool? get deleted;
  Gdms_obj_rel_insert_input? get dm;
  _i2.UuidType? get id;
  Gmessage_reactions_arr_rel_insert_input? get message_reactions;
  Gmessage_types_enum? get message_type;
  _i2.UuidType? get source_id;
  Gthreads_obj_rel_insert_input? get thread;
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

  Gorder_by? get body;
  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get source_id;
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

  Gorder_by? get body;
  Gorder_by? get created_at;
  Gorder_by? get id;
  Gorder_by? get source_id;
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

abstract class Gmessages_obj_rel_insert_input
    implements
        Built<Gmessages_obj_rel_insert_input,
            Gmessages_obj_rel_insert_inputBuilder> {
  Gmessages_obj_rel_insert_input._();

  factory Gmessages_obj_rel_insert_input(
          [Function(Gmessages_obj_rel_insert_inputBuilder b) updates]) =
      _$Gmessages_obj_rel_insert_input;

  Gmessages_insert_input get data;
  Gmessages_on_conflict? get on_conflict;
  static Serializer<Gmessages_obj_rel_insert_input> get serializer =>
      _$gmessagesObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gmessages_obj_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gmessages_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gmessages_obj_rel_insert_input.serializer, json);
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

  Gorder_by? get body;
  Gorder_by? get created_at;
  Gorder_by? get deleted;
  Gdms_order_by? get dm;
  Gorder_by? get id;
  Gmessage_reactions_aggregate_order_by? get message_reactions_aggregate;
  Gorder_by? get message_type;
  Gorder_by? get source_id;
  Gthreads_order_by? get thread;
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

  static const Gmessages_select_column body = _$gmessagesSelectColumnbody;

  static const Gmessages_select_column created_at =
      _$gmessagesSelectColumncreated_at;

  static const Gmessages_select_column deleted = _$gmessagesSelectColumndeleted;

  static const Gmessages_select_column id = _$gmessagesSelectColumnid;

  static const Gmessages_select_column message_type =
      _$gmessagesSelectColumnmessage_type;

  static const Gmessages_select_column source_id =
      _$gmessagesSelectColumnsource_id;

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

  String? get body;
  DateTime? get created_at;
  bool? get deleted;
  _i2.UuidType? get id;
  Gmessage_types_enum? get message_type;
  _i2.UuidType? get source_id;
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

  static const Gmessages_update_column body = _$gmessagesUpdateColumnbody;

  static const Gmessages_update_column created_at =
      _$gmessagesUpdateColumncreated_at;

  static const Gmessages_update_column deleted = _$gmessagesUpdateColumndeleted;

  static const Gmessages_update_column id = _$gmessagesUpdateColumnid;

  static const Gmessages_update_column message_type =
      _$gmessagesUpdateColumnmessage_type;

  static const Gmessages_update_column source_id =
      _$gmessagesUpdateColumnsource_id;

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

abstract class Grole_to_threads_aggregate_order_by
    implements
        Built<Grole_to_threads_aggregate_order_by,
            Grole_to_threads_aggregate_order_byBuilder> {
  Grole_to_threads_aggregate_order_by._();

  factory Grole_to_threads_aggregate_order_by(
          [Function(Grole_to_threads_aggregate_order_byBuilder b) updates]) =
      _$Grole_to_threads_aggregate_order_by;

  Gorder_by? get count;
  Grole_to_threads_max_order_by? get max;
  Grole_to_threads_min_order_by? get min;
  static Serializer<Grole_to_threads_aggregate_order_by> get serializer =>
      _$groleToThreadsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grole_to_threads_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Grole_to_threads_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Grole_to_threads_aggregate_order_by.serializer, json);
}

abstract class Grole_to_threads_arr_rel_insert_input
    implements
        Built<Grole_to_threads_arr_rel_insert_input,
            Grole_to_threads_arr_rel_insert_inputBuilder> {
  Grole_to_threads_arr_rel_insert_input._();

  factory Grole_to_threads_arr_rel_insert_input(
          [Function(Grole_to_threads_arr_rel_insert_inputBuilder b) updates]) =
      _$Grole_to_threads_arr_rel_insert_input;

  BuiltList<Grole_to_threads_insert_input> get data;
  Grole_to_threads_on_conflict? get on_conflict;
  static Serializer<Grole_to_threads_arr_rel_insert_input> get serializer =>
      _$groleToThreadsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grole_to_threads_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Grole_to_threads_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
          Grole_to_threads_arr_rel_insert_input.serializer, json);
}

abstract class Grole_to_threads_bool_exp
    implements
        Built<Grole_to_threads_bool_exp, Grole_to_threads_bool_expBuilder> {
  Grole_to_threads_bool_exp._();

  factory Grole_to_threads_bool_exp(
          [Function(Grole_to_threads_bool_expBuilder b) updates]) =
      _$Grole_to_threads_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Grole_to_threads_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Grole_to_threads_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Grole_to_threads_bool_exp>? get G_or;
  Guuid_comparison_exp? get id;
  Groles_bool_exp? get role;
  Guuid_comparison_exp? get role_id;
  Gthreads_bool_exp? get thread;
  Guuid_comparison_exp? get thread_id;
  static Serializer<Grole_to_threads_bool_exp> get serializer =>
      _$groleToThreadsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Grole_to_threads_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Grole_to_threads_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_bool_exp.serializer, json);
}

class Grole_to_threads_constraint extends EnumClass {
  const Grole_to_threads_constraint._(String name) : super(name);

  static const Grole_to_threads_constraint role_to_threads_pkey =
      _$groleToThreadsConstraintrole_to_threads_pkey;

  static Serializer<Grole_to_threads_constraint> get serializer =>
      _$groleToThreadsConstraintSerializer;
  static BuiltSet<Grole_to_threads_constraint> get values =>
      _$groleToThreadsConstraintValues;
  static Grole_to_threads_constraint valueOf(String name) =>
      _$groleToThreadsConstraintValueOf(name);
}

abstract class Grole_to_threads_insert_input
    implements
        Built<Grole_to_threads_insert_input,
            Grole_to_threads_insert_inputBuilder> {
  Grole_to_threads_insert_input._();

  factory Grole_to_threads_insert_input(
          [Function(Grole_to_threads_insert_inputBuilder b) updates]) =
      _$Grole_to_threads_insert_input;

  _i2.UuidType? get id;
  Groles_obj_rel_insert_input? get role;
  _i2.UuidType? get role_id;
  Gthreads_obj_rel_insert_input? get thread;
  _i2.UuidType? get thread_id;
  static Serializer<Grole_to_threads_insert_input> get serializer =>
      _$groleToThreadsInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grole_to_threads_insert_input.serializer, this) as Map<String, dynamic>);
  static Grole_to_threads_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_insert_input.serializer, json);
}

abstract class Grole_to_threads_max_order_by
    implements
        Built<Grole_to_threads_max_order_by,
            Grole_to_threads_max_order_byBuilder> {
  Grole_to_threads_max_order_by._();

  factory Grole_to_threads_max_order_by(
          [Function(Grole_to_threads_max_order_byBuilder b) updates]) =
      _$Grole_to_threads_max_order_by;

  Gorder_by? get id;
  Gorder_by? get role_id;
  Gorder_by? get thread_id;
  static Serializer<Grole_to_threads_max_order_by> get serializer =>
      _$groleToThreadsMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grole_to_threads_max_order_by.serializer, this) as Map<String, dynamic>);
  static Grole_to_threads_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_max_order_by.serializer, json);
}

abstract class Grole_to_threads_min_order_by
    implements
        Built<Grole_to_threads_min_order_by,
            Grole_to_threads_min_order_byBuilder> {
  Grole_to_threads_min_order_by._();

  factory Grole_to_threads_min_order_by(
          [Function(Grole_to_threads_min_order_byBuilder b) updates]) =
      _$Grole_to_threads_min_order_by;

  Gorder_by? get id;
  Gorder_by? get role_id;
  Gorder_by? get thread_id;
  static Serializer<Grole_to_threads_min_order_by> get serializer =>
      _$groleToThreadsMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grole_to_threads_min_order_by.serializer, this) as Map<String, dynamic>);
  static Grole_to_threads_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_min_order_by.serializer, json);
}

abstract class Grole_to_threads_on_conflict
    implements
        Built<Grole_to_threads_on_conflict,
            Grole_to_threads_on_conflictBuilder> {
  Grole_to_threads_on_conflict._();

  factory Grole_to_threads_on_conflict(
          [Function(Grole_to_threads_on_conflictBuilder b) updates]) =
      _$Grole_to_threads_on_conflict;

  Grole_to_threads_constraint get constraint;
  BuiltList<Grole_to_threads_update_column> get update_columns;
  Grole_to_threads_bool_exp? get where;
  static Serializer<Grole_to_threads_on_conflict> get serializer =>
      _$groleToThreadsOnConflictSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grole_to_threads_on_conflict.serializer, this) as Map<String, dynamic>);
  static Grole_to_threads_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_on_conflict.serializer, json);
}

abstract class Grole_to_threads_order_by
    implements
        Built<Grole_to_threads_order_by, Grole_to_threads_order_byBuilder> {
  Grole_to_threads_order_by._();

  factory Grole_to_threads_order_by(
          [Function(Grole_to_threads_order_byBuilder b) updates]) =
      _$Grole_to_threads_order_by;

  Gorder_by? get id;
  Groles_order_by? get role;
  Gorder_by? get role_id;
  Gthreads_order_by? get thread;
  Gorder_by? get thread_id;
  static Serializer<Grole_to_threads_order_by> get serializer =>
      _$groleToThreadsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Grole_to_threads_order_by.serializer, this)
          as Map<String, dynamic>);
  static Grole_to_threads_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_order_by.serializer, json);
}

abstract class Grole_to_threads_pk_columns_input
    implements
        Built<Grole_to_threads_pk_columns_input,
            Grole_to_threads_pk_columns_inputBuilder> {
  Grole_to_threads_pk_columns_input._();

  factory Grole_to_threads_pk_columns_input(
          [Function(Grole_to_threads_pk_columns_inputBuilder b) updates]) =
      _$Grole_to_threads_pk_columns_input;

  _i2.UuidType get role_id;
  _i2.UuidType get thread_id;
  static Serializer<Grole_to_threads_pk_columns_input> get serializer =>
      _$groleToThreadsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Grole_to_threads_pk_columns_input.serializer, this)
      as Map<String, dynamic>);
  static Grole_to_threads_pk_columns_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_pk_columns_input.serializer, json);
}

class Grole_to_threads_select_column extends EnumClass {
  const Grole_to_threads_select_column._(String name) : super(name);

  static const Grole_to_threads_select_column id =
      _$groleToThreadsSelectColumnid;

  static const Grole_to_threads_select_column role_id =
      _$groleToThreadsSelectColumnrole_id;

  static const Grole_to_threads_select_column thread_id =
      _$groleToThreadsSelectColumnthread_id;

  static Serializer<Grole_to_threads_select_column> get serializer =>
      _$groleToThreadsSelectColumnSerializer;
  static BuiltSet<Grole_to_threads_select_column> get values =>
      _$groleToThreadsSelectColumnValues;
  static Grole_to_threads_select_column valueOf(String name) =>
      _$groleToThreadsSelectColumnValueOf(name);
}

abstract class Grole_to_threads_set_input
    implements
        Built<Grole_to_threads_set_input, Grole_to_threads_set_inputBuilder> {
  Grole_to_threads_set_input._();

  factory Grole_to_threads_set_input(
          [Function(Grole_to_threads_set_inputBuilder b) updates]) =
      _$Grole_to_threads_set_input;

  _i2.UuidType? get id;
  _i2.UuidType? get role_id;
  _i2.UuidType? get thread_id;
  static Serializer<Grole_to_threads_set_input> get serializer =>
      _$groleToThreadsSetInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Grole_to_threads_set_input.serializer, this) as Map<String, dynamic>);
  static Grole_to_threads_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Grole_to_threads_set_input.serializer, json);
}

class Grole_to_threads_update_column extends EnumClass {
  const Grole_to_threads_update_column._(String name) : super(name);

  static const Grole_to_threads_update_column id =
      _$groleToThreadsUpdateColumnid;

  static const Grole_to_threads_update_column role_id =
      _$groleToThreadsUpdateColumnrole_id;

  static const Grole_to_threads_update_column thread_id =
      _$groleToThreadsUpdateColumnthread_id;

  static Serializer<Grole_to_threads_update_column> get serializer =>
      _$groleToThreadsUpdateColumnSerializer;
  static BuiltSet<Grole_to_threads_update_column> get values =>
      _$groleToThreadsUpdateColumnValues;
  static Grole_to_threads_update_column valueOf(String name) =>
      _$groleToThreadsUpdateColumnValueOf(name);
}

abstract class Groles_aggregate_order_by
    implements
        Built<Groles_aggregate_order_by, Groles_aggregate_order_byBuilder> {
  Groles_aggregate_order_by._();

  factory Groles_aggregate_order_by(
          [Function(Groles_aggregate_order_byBuilder b) updates]) =
      _$Groles_aggregate_order_by;

  Gorder_by? get count;
  Groles_max_order_by? get max;
  Groles_min_order_by? get min;
  static Serializer<Groles_aggregate_order_by> get serializer =>
      _$grolesAggregateOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_aggregate_order_by.serializer, this)
          as Map<String, dynamic>);
  static Groles_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Groles_aggregate_order_by.serializer, json);
}

abstract class Groles_arr_rel_insert_input
    implements
        Built<Groles_arr_rel_insert_input, Groles_arr_rel_insert_inputBuilder> {
  Groles_arr_rel_insert_input._();

  factory Groles_arr_rel_insert_input(
          [Function(Groles_arr_rel_insert_inputBuilder b) updates]) =
      _$Groles_arr_rel_insert_input;

  BuiltList<Groles_insert_input> get data;
  Groles_on_conflict? get on_conflict;
  static Serializer<Groles_arr_rel_insert_input> get serializer =>
      _$grolesArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Groles_arr_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Groles_arr_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Groles_arr_rel_insert_input.serializer, json);
}

abstract class Groles_bool_exp
    implements Built<Groles_bool_exp, Groles_bool_expBuilder> {
  Groles_bool_exp._();

  factory Groles_bool_exp([Function(Groles_bool_expBuilder b) updates]) =
      _$Groles_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Groles_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Groles_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Groles_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  Gjoin_tokens_bool_exp? get join_token;
  GString_comparison_exp? get name;
  Grole_to_threads_bool_exp? get role_to_threads;
  Guser_to_role_bool_exp? get user_to_roles;
  static Serializer<Groles_bool_exp> get serializer =>
      _$grolesBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Groles_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_bool_exp.serializer, json);
}

class Groles_constraint extends EnumClass {
  const Groles_constraint._(String name) : super(name);

  static const Groles_constraint role_id_key = _$grolesConstraintrole_id_key;

  static const Groles_constraint role_pkey = _$grolesConstraintrole_pkey;

  static Serializer<Groles_constraint> get serializer =>
      _$grolesConstraintSerializer;
  static BuiltSet<Groles_constraint> get values => _$grolesConstraintValues;
  static Groles_constraint valueOf(String name) =>
      _$grolesConstraintValueOf(name);
}

abstract class Groles_insert_input
    implements Built<Groles_insert_input, Groles_insert_inputBuilder> {
  Groles_insert_input._();

  factory Groles_insert_input(
      [Function(Groles_insert_inputBuilder b) updates]) = _$Groles_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  Gjoin_tokens_obj_rel_insert_input? get join_token;
  String? get name;
  Grole_to_threads_arr_rel_insert_input? get role_to_threads;
  Guser_to_role_arr_rel_insert_input? get user_to_roles;
  static Serializer<Groles_insert_input> get serializer =>
      _$grolesInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Groles_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_insert_input.serializer, json);
}

abstract class Groles_max_order_by
    implements Built<Groles_max_order_by, Groles_max_order_byBuilder> {
  Groles_max_order_by._();

  factory Groles_max_order_by(
      [Function(Groles_max_order_byBuilder b) updates]) = _$Groles_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Groles_max_order_by> get serializer =>
      _$grolesMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Groles_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_max_order_by.serializer, json);
}

abstract class Groles_min_order_by
    implements Built<Groles_min_order_by, Groles_min_order_byBuilder> {
  Groles_min_order_by._();

  factory Groles_min_order_by(
      [Function(Groles_min_order_byBuilder b) updates]) = _$Groles_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Groles_min_order_by> get serializer =>
      _$grolesMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Groles_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_min_order_by.serializer, json);
}

abstract class Groles_obj_rel_insert_input
    implements
        Built<Groles_obj_rel_insert_input, Groles_obj_rel_insert_inputBuilder> {
  Groles_obj_rel_insert_input._();

  factory Groles_obj_rel_insert_input(
          [Function(Groles_obj_rel_insert_inputBuilder b) updates]) =
      _$Groles_obj_rel_insert_input;

  Groles_insert_input get data;
  Groles_on_conflict? get on_conflict;
  static Serializer<Groles_obj_rel_insert_input> get serializer =>
      _$grolesObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Groles_obj_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Groles_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Groles_obj_rel_insert_input.serializer, json);
}

abstract class Groles_on_conflict
    implements Built<Groles_on_conflict, Groles_on_conflictBuilder> {
  Groles_on_conflict._();

  factory Groles_on_conflict([Function(Groles_on_conflictBuilder b) updates]) =
      _$Groles_on_conflict;

  Groles_constraint get constraint;
  BuiltList<Groles_update_column> get update_columns;
  Groles_bool_exp? get where;
  static Serializer<Groles_on_conflict> get serializer =>
      _$grolesOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Groles_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_on_conflict.serializer, json);
}

abstract class Groles_order_by
    implements Built<Groles_order_by, Groles_order_byBuilder> {
  Groles_order_by._();

  factory Groles_order_by([Function(Groles_order_byBuilder b) updates]) =
      _$Groles_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gjoin_tokens_order_by? get join_token;
  Gorder_by? get name;
  Grole_to_threads_aggregate_order_by? get role_to_threads_aggregate;
  Guser_to_role_aggregate_order_by? get user_to_roles_aggregate;
  static Serializer<Groles_order_by> get serializer =>
      _$grolesOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_order_by.serializer, this)
          as Map<String, dynamic>);
  static Groles_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_order_by.serializer, json);
}

abstract class Groles_pk_columns_input
    implements Built<Groles_pk_columns_input, Groles_pk_columns_inputBuilder> {
  Groles_pk_columns_input._();

  factory Groles_pk_columns_input(
          [Function(Groles_pk_columns_inputBuilder b) updates]) =
      _$Groles_pk_columns_input;

  _i2.UuidType get group_id;
  String get name;
  static Serializer<Groles_pk_columns_input> get serializer =>
      _$grolesPkColumnsInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_pk_columns_input.serializer, this)
          as Map<String, dynamic>);
  static Groles_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_pk_columns_input.serializer, json);
}

class Groles_select_column extends EnumClass {
  const Groles_select_column._(String name) : super(name);

  static const Groles_select_column group_id = _$grolesSelectColumngroup_id;

  static const Groles_select_column id = _$grolesSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Groles_select_column Gname = _$grolesSelectColumnGname;

  static Serializer<Groles_select_column> get serializer =>
      _$grolesSelectColumnSerializer;
  static BuiltSet<Groles_select_column> get values =>
      _$grolesSelectColumnValues;
  static Groles_select_column valueOf(String name) =>
      _$grolesSelectColumnValueOf(name);
}

abstract class Groles_set_input
    implements Built<Groles_set_input, Groles_set_inputBuilder> {
  Groles_set_input._();

  factory Groles_set_input([Function(Groles_set_inputBuilder b) updates]) =
      _$Groles_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  String? get name;
  static Serializer<Groles_set_input> get serializer =>
      _$grolesSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Groles_set_input.serializer, this)
          as Map<String, dynamic>);
  static Groles_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Groles_set_input.serializer, json);
}

class Groles_update_column extends EnumClass {
  const Groles_update_column._(String name) : super(name);

  static const Groles_update_column group_id = _$grolesUpdateColumngroup_id;

  static const Groles_update_column id = _$grolesUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Groles_update_column Gname = _$grolesUpdateColumnGname;

  static Serializer<Groles_update_column> get serializer =>
      _$grolesUpdateColumnSerializer;
  static BuiltSet<Groles_update_column> get values =>
      _$grolesUpdateColumnValues;
  static Groles_update_column valueOf(String name) =>
      _$grolesUpdateColumnValueOf(name);
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

abstract class Gthreads_aggregate_order_by
    implements
        Built<Gthreads_aggregate_order_by, Gthreads_aggregate_order_byBuilder> {
  Gthreads_aggregate_order_by._();

  factory Gthreads_aggregate_order_by(
          [Function(Gthreads_aggregate_order_byBuilder b) updates]) =
      _$Gthreads_aggregate_order_by;

  Gorder_by? get count;
  Gthreads_max_order_by? get max;
  Gthreads_min_order_by? get min;
  static Serializer<Gthreads_aggregate_order_by> get serializer =>
      _$gthreadsAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gthreads_aggregate_order_by.serializer, this) as Map<String, dynamic>);
  static Gthreads_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gthreads_aggregate_order_by.serializer, json);
}

abstract class Gthreads_arr_rel_insert_input
    implements
        Built<Gthreads_arr_rel_insert_input,
            Gthreads_arr_rel_insert_inputBuilder> {
  Gthreads_arr_rel_insert_input._();

  factory Gthreads_arr_rel_insert_input(
          [Function(Gthreads_arr_rel_insert_inputBuilder b) updates]) =
      _$Gthreads_arr_rel_insert_input;

  BuiltList<Gthreads_insert_input> get data;
  Gthreads_on_conflict? get on_conflict;
  static Serializer<Gthreads_arr_rel_insert_input> get serializer =>
      _$gthreadsArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gthreads_arr_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gthreads_arr_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gthreads_arr_rel_insert_input.serializer, json);
}

abstract class Gthreads_bool_exp
    implements Built<Gthreads_bool_exp, Gthreads_bool_expBuilder> {
  Gthreads_bool_exp._();

  factory Gthreads_bool_exp([Function(Gthreads_bool_expBuilder b) updates]) =
      _$Gthreads_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Gthreads_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Gthreads_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Gthreads_bool_exp>? get G_or;
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  Guuid_comparison_exp? get id;
  Gmessages_bool_exp? get messages;
  GString_comparison_exp? get name;
  Grole_to_threads_bool_exp? get role_to_threads;
  Guser_to_thread_bool_exp? get users;
  static Serializer<Gthreads_bool_exp> get serializer =>
      _$gthreadsBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_bool_exp.serializer, json);
}

class Gthreads_constraint extends EnumClass {
  const Gthreads_constraint._(String name) : super(name);

  static const Gthreads_constraint group_threads_pkey =
      _$gthreadsConstraintgroup_threads_pkey;

  static Serializer<Gthreads_constraint> get serializer =>
      _$gthreadsConstraintSerializer;
  static BuiltSet<Gthreads_constraint> get values => _$gthreadsConstraintValues;
  static Gthreads_constraint valueOf(String name) =>
      _$gthreadsConstraintValueOf(name);
}

abstract class Gthreads_insert_input
    implements Built<Gthreads_insert_input, Gthreads_insert_inputBuilder> {
  Gthreads_insert_input._();

  factory Gthreads_insert_input(
          [Function(Gthreads_insert_inputBuilder b) updates]) =
      _$Gthreads_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  Gmessages_arr_rel_insert_input? get messages;
  String? get name;
  Grole_to_threads_arr_rel_insert_input? get role_to_threads;
  Guser_to_thread_arr_rel_insert_input? get users;
  static Serializer<Gthreads_insert_input> get serializer =>
      _$gthreadsInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_insert_input.serializer, json);
}

abstract class Gthreads_max_order_by
    implements Built<Gthreads_max_order_by, Gthreads_max_order_byBuilder> {
  Gthreads_max_order_by._();

  factory Gthreads_max_order_by(
          [Function(Gthreads_max_order_byBuilder b) updates]) =
      _$Gthreads_max_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Gthreads_max_order_by> get serializer =>
      _$gthreadsMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_max_order_by.serializer, json);
}

abstract class Gthreads_min_order_by
    implements Built<Gthreads_min_order_by, Gthreads_min_order_byBuilder> {
  Gthreads_min_order_by._();

  factory Gthreads_min_order_by(
          [Function(Gthreads_min_order_byBuilder b) updates]) =
      _$Gthreads_min_order_by;

  Gorder_by? get group_id;
  Gorder_by? get id;
  Gorder_by? get name;
  static Serializer<Gthreads_min_order_by> get serializer =>
      _$gthreadsMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_min_order_by.serializer, json);
}

abstract class Gthreads_obj_rel_insert_input
    implements
        Built<Gthreads_obj_rel_insert_input,
            Gthreads_obj_rel_insert_inputBuilder> {
  Gthreads_obj_rel_insert_input._();

  factory Gthreads_obj_rel_insert_input(
          [Function(Gthreads_obj_rel_insert_inputBuilder b) updates]) =
      _$Gthreads_obj_rel_insert_input;

  Gthreads_insert_input get data;
  Gthreads_on_conflict? get on_conflict;
  static Serializer<Gthreads_obj_rel_insert_input> get serializer =>
      _$gthreadsObjRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Gthreads_obj_rel_insert_input.serializer, this) as Map<String, dynamic>);
  static Gthreads_obj_rel_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gthreads_obj_rel_insert_input.serializer, json);
}

abstract class Gthreads_on_conflict
    implements Built<Gthreads_on_conflict, Gthreads_on_conflictBuilder> {
  Gthreads_on_conflict._();

  factory Gthreads_on_conflict(
          [Function(Gthreads_on_conflictBuilder b) updates]) =
      _$Gthreads_on_conflict;

  Gthreads_constraint get constraint;
  BuiltList<Gthreads_update_column> get update_columns;
  Gthreads_bool_exp? get where;
  static Serializer<Gthreads_on_conflict> get serializer =>
      _$gthreadsOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_on_conflict.serializer, json);
}

abstract class Gthreads_order_by
    implements Built<Gthreads_order_by, Gthreads_order_byBuilder> {
  Gthreads_order_by._();

  factory Gthreads_order_by([Function(Gthreads_order_byBuilder b) updates]) =
      _$Gthreads_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get id;
  Gmessages_aggregate_order_by? get messages_aggregate;
  Gorder_by? get name;
  Grole_to_threads_aggregate_order_by? get role_to_threads_aggregate;
  Guser_to_thread_aggregate_order_by? get users_aggregate;
  static Serializer<Gthreads_order_by> get serializer =>
      _$gthreadsOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_order_by.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_order_by.serializer, json);
}

abstract class Gthreads_pk_columns_input
    implements
        Built<Gthreads_pk_columns_input, Gthreads_pk_columns_inputBuilder> {
  Gthreads_pk_columns_input._();

  factory Gthreads_pk_columns_input(
          [Function(Gthreads_pk_columns_inputBuilder b) updates]) =
      _$Gthreads_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Gthreads_pk_columns_input> get serializer =>
      _$gthreadsPkColumnsInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_pk_columns_input.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Gthreads_pk_columns_input.serializer, json);
}

class Gthreads_select_column extends EnumClass {
  const Gthreads_select_column._(String name) : super(name);

  static const Gthreads_select_column group_id = _$gthreadsSelectColumngroup_id;

  static const Gthreads_select_column id = _$gthreadsSelectColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gthreads_select_column Gname = _$gthreadsSelectColumnGname;

  static Serializer<Gthreads_select_column> get serializer =>
      _$gthreadsSelectColumnSerializer;
  static BuiltSet<Gthreads_select_column> get values =>
      _$gthreadsSelectColumnValues;
  static Gthreads_select_column valueOf(String name) =>
      _$gthreadsSelectColumnValueOf(name);
}

abstract class Gthreads_set_input
    implements Built<Gthreads_set_input, Gthreads_set_inputBuilder> {
  Gthreads_set_input._();

  factory Gthreads_set_input([Function(Gthreads_set_inputBuilder b) updates]) =
      _$Gthreads_set_input;

  _i2.UuidType? get group_id;
  _i2.UuidType? get id;
  String? get name;
  static Serializer<Gthreads_set_input> get serializer =>
      _$gthreadsSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Gthreads_set_input.serializer, this)
          as Map<String, dynamic>);
  static Gthreads_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Gthreads_set_input.serializer, json);
}

class Gthreads_update_column extends EnumClass {
  const Gthreads_update_column._(String name) : super(name);

  static const Gthreads_update_column group_id = _$gthreadsUpdateColumngroup_id;

  static const Gthreads_update_column id = _$gthreadsUpdateColumnid;

  @BuiltValueEnumConst(wireName: 'name')
  static const Gthreads_update_column Gname = _$gthreadsUpdateColumnGname;

  static Serializer<Gthreads_update_column> get serializer =>
      _$gthreadsUpdateColumnSerializer;
  static BuiltSet<Gthreads_update_column> get values =>
      _$gthreadsUpdateColumnValues;
  static Gthreads_update_column valueOf(String name) =>
      _$gthreadsUpdateColumnValueOf(name);
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

class GUploadType extends EnumClass {
  const GUploadType._(String name) : super(name);

  static const GUploadType GroupAvatar = _$gUploadTypeGroupAvatar;

  static const GUploadType Message = _$gUploadTypeMessage;

  static const GUploadType UserAvatar = _$gUploadTypeUserAvatar;

  static Serializer<GUploadType> get serializer => _$gUploadTypeSerializer;
  static BuiltSet<GUploadType> get values => _$gUploadTypeValues;
  static GUploadType valueOf(String name) => _$gUploadTypeValueOf(name);
}

abstract class Guser_to_dm_aggregate_order_by
    implements
        Built<Guser_to_dm_aggregate_order_by,
            Guser_to_dm_aggregate_order_byBuilder> {
  Guser_to_dm_aggregate_order_by._();

  factory Guser_to_dm_aggregate_order_by(
          [Function(Guser_to_dm_aggregate_order_byBuilder b) updates]) =
      _$Guser_to_dm_aggregate_order_by;

  Gorder_by? get count;
  Guser_to_dm_max_order_by? get max;
  Guser_to_dm_min_order_by? get min;
  static Serializer<Guser_to_dm_aggregate_order_by> get serializer =>
      _$guserToDmAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_dm_aggregate_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_dm_aggregate_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_aggregate_order_by.serializer, json);
}

abstract class Guser_to_dm_arr_rel_insert_input
    implements
        Built<Guser_to_dm_arr_rel_insert_input,
            Guser_to_dm_arr_rel_insert_inputBuilder> {
  Guser_to_dm_arr_rel_insert_input._();

  factory Guser_to_dm_arr_rel_insert_input(
          [Function(Guser_to_dm_arr_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_dm_arr_rel_insert_input;

  BuiltList<Guser_to_dm_insert_input> get data;
  Guser_to_dm_on_conflict? get on_conflict;
  static Serializer<Guser_to_dm_arr_rel_insert_input> get serializer =>
      _$guserToDmArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_dm_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_dm_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_arr_rel_insert_input.serializer, json);
}

abstract class Guser_to_dm_bool_exp
    implements Built<Guser_to_dm_bool_exp, Guser_to_dm_bool_expBuilder> {
  Guser_to_dm_bool_exp._();

  factory Guser_to_dm_bool_exp(
          [Function(Guser_to_dm_bool_expBuilder b) updates]) =
      _$Guser_to_dm_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Guser_to_dm_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Guser_to_dm_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Guser_to_dm_bool_exp>? get G_or;
  Gdms_bool_exp? get dm;
  Guuid_comparison_exp? get dm_id;
  Guuid_comparison_exp? get id;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Guser_to_dm_bool_exp> get serializer =>
      _$guserToDmBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_dm_bool_exp.serializer, json);
}

class Guser_to_dm_constraint extends EnumClass {
  const Guser_to_dm_constraint._(String name) : super(name);

  static const Guser_to_dm_constraint user_to_dm_pkey =
      _$guserToDmConstraintuser_to_dm_pkey;

  static Serializer<Guser_to_dm_constraint> get serializer =>
      _$guserToDmConstraintSerializer;
  static BuiltSet<Guser_to_dm_constraint> get values =>
      _$guserToDmConstraintValues;
  static Guser_to_dm_constraint valueOf(String name) =>
      _$guserToDmConstraintValueOf(name);
}

abstract class Guser_to_dm_insert_input
    implements
        Built<Guser_to_dm_insert_input, Guser_to_dm_insert_inputBuilder> {
  Guser_to_dm_insert_input._();

  factory Guser_to_dm_insert_input(
          [Function(Guser_to_dm_insert_inputBuilder b) updates]) =
      _$Guser_to_dm_insert_input;

  Gdms_obj_rel_insert_input? get dm;
  _i2.UuidType? get dm_id;
  _i2.UuidType? get id;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_dm_insert_input> get serializer =>
      _$guserToDmInsertInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_insert_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_insert_input.serializer, json);
}

abstract class Guser_to_dm_max_order_by
    implements
        Built<Guser_to_dm_max_order_by, Guser_to_dm_max_order_byBuilder> {
  Guser_to_dm_max_order_by._();

  factory Guser_to_dm_max_order_by(
          [Function(Guser_to_dm_max_order_byBuilder b) updates]) =
      _$Guser_to_dm_max_order_by;

  Gorder_by? get dm_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_dm_max_order_by> get serializer =>
      _$guserToDmMaxOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_max_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_max_order_by.serializer, json);
}

abstract class Guser_to_dm_min_order_by
    implements
        Built<Guser_to_dm_min_order_by, Guser_to_dm_min_order_byBuilder> {
  Guser_to_dm_min_order_by._();

  factory Guser_to_dm_min_order_by(
          [Function(Guser_to_dm_min_order_byBuilder b) updates]) =
      _$Guser_to_dm_min_order_by;

  Gorder_by? get dm_id;
  Gorder_by? get id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_dm_min_order_by> get serializer =>
      _$guserToDmMinOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_min_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_min_order_by.serializer, json);
}

abstract class Guser_to_dm_on_conflict
    implements Built<Guser_to_dm_on_conflict, Guser_to_dm_on_conflictBuilder> {
  Guser_to_dm_on_conflict._();

  factory Guser_to_dm_on_conflict(
          [Function(Guser_to_dm_on_conflictBuilder b) updates]) =
      _$Guser_to_dm_on_conflict;

  Guser_to_dm_constraint get constraint;
  BuiltList<Guser_to_dm_update_column> get update_columns;
  Guser_to_dm_bool_exp? get where;
  static Serializer<Guser_to_dm_on_conflict> get serializer =>
      _$guserToDmOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_dm_on_conflict.serializer, json);
}

abstract class Guser_to_dm_order_by
    implements Built<Guser_to_dm_order_by, Guser_to_dm_order_byBuilder> {
  Guser_to_dm_order_by._();

  factory Guser_to_dm_order_by(
          [Function(Guser_to_dm_order_byBuilder b) updates]) =
      _$Guser_to_dm_order_by;

  Gdms_order_by? get dm;
  Gorder_by? get dm_id;
  Gorder_by? get id;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Guser_to_dm_order_by> get serializer =>
      _$guserToDmOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_dm_order_by.serializer, json);
}

abstract class Guser_to_dm_pk_columns_input
    implements
        Built<Guser_to_dm_pk_columns_input,
            Guser_to_dm_pk_columns_inputBuilder> {
  Guser_to_dm_pk_columns_input._();

  factory Guser_to_dm_pk_columns_input(
          [Function(Guser_to_dm_pk_columns_inputBuilder b) updates]) =
      _$Guser_to_dm_pk_columns_input;

  _i2.UuidType get id;
  static Serializer<Guser_to_dm_pk_columns_input> get serializer =>
      _$guserToDmPkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_dm_pk_columns_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_dm_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_dm_pk_columns_input.serializer, json);
}

class Guser_to_dm_select_column extends EnumClass {
  const Guser_to_dm_select_column._(String name) : super(name);

  static const Guser_to_dm_select_column dm_id = _$guserToDmSelectColumndm_id;

  static const Guser_to_dm_select_column id = _$guserToDmSelectColumnid;

  static const Guser_to_dm_select_column user_id =
      _$guserToDmSelectColumnuser_id;

  static Serializer<Guser_to_dm_select_column> get serializer =>
      _$guserToDmSelectColumnSerializer;
  static BuiltSet<Guser_to_dm_select_column> get values =>
      _$guserToDmSelectColumnValues;
  static Guser_to_dm_select_column valueOf(String name) =>
      _$guserToDmSelectColumnValueOf(name);
}

abstract class Guser_to_dm_set_input
    implements Built<Guser_to_dm_set_input, Guser_to_dm_set_inputBuilder> {
  Guser_to_dm_set_input._();

  factory Guser_to_dm_set_input(
          [Function(Guser_to_dm_set_inputBuilder b) updates]) =
      _$Guser_to_dm_set_input;

  _i2.UuidType? get dm_id;
  _i2.UuidType? get id;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_dm_set_input> get serializer =>
      _$guserToDmSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_dm_set_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_dm_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_dm_set_input.serializer, json);
}

class Guser_to_dm_update_column extends EnumClass {
  const Guser_to_dm_update_column._(String name) : super(name);

  static const Guser_to_dm_update_column dm_id = _$guserToDmUpdateColumndm_id;

  static const Guser_to_dm_update_column id = _$guserToDmUpdateColumnid;

  static const Guser_to_dm_update_column user_id =
      _$guserToDmUpdateColumnuser_id;

  static Serializer<Guser_to_dm_update_column> get serializer =>
      _$guserToDmUpdateColumnSerializer;
  static BuiltSet<Guser_to_dm_update_column> get values =>
      _$guserToDmUpdateColumnValues;
  static Guser_to_dm_update_column valueOf(String name) =>
      _$guserToDmUpdateColumnValueOf(name);
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
  Ggroups_bool_exp? get group;
  Guuid_comparison_exp? get group_id;
  GBoolean_comparison_exp? get owner;
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

abstract class Guser_to_group_insert_input
    implements
        Built<Guser_to_group_insert_input, Guser_to_group_insert_inputBuilder> {
  Guser_to_group_insert_input._();

  factory Guser_to_group_insert_input(
          [Function(Guser_to_group_insert_inputBuilder b) updates]) =
      _$Guser_to_group_insert_input;

  Ggroups_obj_rel_insert_input? get group;
  _i2.UuidType? get group_id;
  bool? get owner;
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
  Gorder_by? get user_id;
  static Serializer<Guser_to_group_min_order_by> get serializer =>
      _$guserToGroupMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_group_min_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_group_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_group_min_order_by.serializer, json);
}

abstract class Guser_to_group_order_by
    implements Built<Guser_to_group_order_by, Guser_to_group_order_byBuilder> {
  Guser_to_group_order_by._();

  factory Guser_to_group_order_by(
          [Function(Guser_to_group_order_byBuilder b) updates]) =
      _$Guser_to_group_order_by;

  Ggroups_order_by? get group;
  Gorder_by? get group_id;
  Gorder_by? get owner;
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

class Guser_to_group_select_column extends EnumClass {
  const Guser_to_group_select_column._(String name) : super(name);

  static const Guser_to_group_select_column group_id =
      _$guserToGroupSelectColumngroup_id;

  static const Guser_to_group_select_column owner =
      _$guserToGroupSelectColumnowner;

  static const Guser_to_group_select_column user_id =
      _$guserToGroupSelectColumnuser_id;

  static Serializer<Guser_to_group_select_column> get serializer =>
      _$guserToGroupSelectColumnSerializer;
  static BuiltSet<Guser_to_group_select_column> get values =>
      _$guserToGroupSelectColumnValues;
  static Guser_to_group_select_column valueOf(String name) =>
      _$guserToGroupSelectColumnValueOf(name);
}

abstract class Guser_to_role_aggregate_order_by
    implements
        Built<Guser_to_role_aggregate_order_by,
            Guser_to_role_aggregate_order_byBuilder> {
  Guser_to_role_aggregate_order_by._();

  factory Guser_to_role_aggregate_order_by(
          [Function(Guser_to_role_aggregate_order_byBuilder b) updates]) =
      _$Guser_to_role_aggregate_order_by;

  Gorder_by? get count;
  Guser_to_role_max_order_by? get max;
  Guser_to_role_min_order_by? get min;
  static Serializer<Guser_to_role_aggregate_order_by> get serializer =>
      _$guserToRoleAggregateOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_role_aggregate_order_by.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_role_aggregate_order_by? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_aggregate_order_by.serializer, json);
}

abstract class Guser_to_role_arr_rel_insert_input
    implements
        Built<Guser_to_role_arr_rel_insert_input,
            Guser_to_role_arr_rel_insert_inputBuilder> {
  Guser_to_role_arr_rel_insert_input._();

  factory Guser_to_role_arr_rel_insert_input(
          [Function(Guser_to_role_arr_rel_insert_inputBuilder b) updates]) =
      _$Guser_to_role_arr_rel_insert_input;

  BuiltList<Guser_to_role_insert_input> get data;
  Guser_to_role_on_conflict? get on_conflict;
  static Serializer<Guser_to_role_arr_rel_insert_input> get serializer =>
      _$guserToRoleArrRelInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers
          .serializeWith(Guser_to_role_arr_rel_insert_input.serializer, this)
      as Map<String, dynamic>);
  static Guser_to_role_arr_rel_insert_input? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_arr_rel_insert_input.serializer, json);
}

abstract class Guser_to_role_bool_exp
    implements Built<Guser_to_role_bool_exp, Guser_to_role_bool_expBuilder> {
  Guser_to_role_bool_exp._();

  factory Guser_to_role_bool_exp(
          [Function(Guser_to_role_bool_expBuilder b) updates]) =
      _$Guser_to_role_bool_exp;

  @BuiltValueField(wireName: '_and')
  BuiltList<Guser_to_role_bool_exp>? get G_and;
  @BuiltValueField(wireName: '_not')
  Guser_to_role_bool_exp? get G_not;
  @BuiltValueField(wireName: '_or')
  BuiltList<Guser_to_role_bool_exp>? get G_or;
  Guuid_comparison_exp? get id;
  Groles_bool_exp? get role;
  Guuid_comparison_exp? get role_id;
  Gusers_bool_exp? get user;
  Guuid_comparison_exp? get user_id;
  static Serializer<Guser_to_role_bool_exp> get serializer =>
      _$guserToRoleBoolExpSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_role_bool_exp.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_role_bool_exp? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_role_bool_exp.serializer, json);
}

class Guser_to_role_constraint extends EnumClass {
  const Guser_to_role_constraint._(String name) : super(name);

  static const Guser_to_role_constraint user_to_role_id_key =
      _$guserToRoleConstraintuser_to_role_id_key;

  static const Guser_to_role_constraint user_to_role_pkey =
      _$guserToRoleConstraintuser_to_role_pkey;

  static Serializer<Guser_to_role_constraint> get serializer =>
      _$guserToRoleConstraintSerializer;
  static BuiltSet<Guser_to_role_constraint> get values =>
      _$guserToRoleConstraintValues;
  static Guser_to_role_constraint valueOf(String name) =>
      _$guserToRoleConstraintValueOf(name);
}

abstract class Guser_to_role_insert_input
    implements
        Built<Guser_to_role_insert_input, Guser_to_role_insert_inputBuilder> {
  Guser_to_role_insert_input._();

  factory Guser_to_role_insert_input(
          [Function(Guser_to_role_insert_inputBuilder b) updates]) =
      _$Guser_to_role_insert_input;

  _i2.UuidType? get id;
  Groles_obj_rel_insert_input? get role;
  _i2.UuidType? get role_id;
  Gusers_obj_rel_insert_input? get user;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_role_insert_input> get serializer =>
      _$guserToRoleInsertInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_role_insert_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_role_insert_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_insert_input.serializer, json);
}

abstract class Guser_to_role_max_order_by
    implements
        Built<Guser_to_role_max_order_by, Guser_to_role_max_order_byBuilder> {
  Guser_to_role_max_order_by._();

  factory Guser_to_role_max_order_by(
          [Function(Guser_to_role_max_order_byBuilder b) updates]) =
      _$Guser_to_role_max_order_by;

  Gorder_by? get id;
  Gorder_by? get role_id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_role_max_order_by> get serializer =>
      _$guserToRoleMaxOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_role_max_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_role_max_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_max_order_by.serializer, json);
}

abstract class Guser_to_role_min_order_by
    implements
        Built<Guser_to_role_min_order_by, Guser_to_role_min_order_byBuilder> {
  Guser_to_role_min_order_by._();

  factory Guser_to_role_min_order_by(
          [Function(Guser_to_role_min_order_byBuilder b) updates]) =
      _$Guser_to_role_min_order_by;

  Gorder_by? get id;
  Gorder_by? get role_id;
  Gorder_by? get user_id;
  static Serializer<Guser_to_role_min_order_by> get serializer =>
      _$guserToRoleMinOrderBySerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_role_min_order_by.serializer, this) as Map<String, dynamic>);
  static Guser_to_role_min_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_min_order_by.serializer, json);
}

abstract class Guser_to_role_on_conflict
    implements
        Built<Guser_to_role_on_conflict, Guser_to_role_on_conflictBuilder> {
  Guser_to_role_on_conflict._();

  factory Guser_to_role_on_conflict(
          [Function(Guser_to_role_on_conflictBuilder b) updates]) =
      _$Guser_to_role_on_conflict;

  Guser_to_role_constraint get constraint;
  BuiltList<Guser_to_role_update_column> get update_columns;
  Guser_to_role_bool_exp? get where;
  static Serializer<Guser_to_role_on_conflict> get serializer =>
      _$guserToRoleOnConflictSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_role_on_conflict.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_role_on_conflict? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_on_conflict.serializer, json);
}

abstract class Guser_to_role_order_by
    implements Built<Guser_to_role_order_by, Guser_to_role_order_byBuilder> {
  Guser_to_role_order_by._();

  factory Guser_to_role_order_by(
          [Function(Guser_to_role_order_byBuilder b) updates]) =
      _$Guser_to_role_order_by;

  Gorder_by? get id;
  Groles_order_by? get role;
  Gorder_by? get role_id;
  Gusers_order_by? get user;
  Gorder_by? get user_id;
  static Serializer<Guser_to_role_order_by> get serializer =>
      _$guserToRoleOrderBySerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_role_order_by.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_role_order_by? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_role_order_by.serializer, json);
}

abstract class Guser_to_role_pk_columns_input
    implements
        Built<Guser_to_role_pk_columns_input,
            Guser_to_role_pk_columns_inputBuilder> {
  Guser_to_role_pk_columns_input._();

  factory Guser_to_role_pk_columns_input(
          [Function(Guser_to_role_pk_columns_inputBuilder b) updates]) =
      _$Guser_to_role_pk_columns_input;

  _i2.UuidType get role_id;
  _i2.UuidType get user_id;
  static Serializer<Guser_to_role_pk_columns_input> get serializer =>
      _$guserToRolePkColumnsInputSerializer;
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
      Guser_to_role_pk_columns_input.serializer, this) as Map<String, dynamic>);
  static Guser_to_role_pk_columns_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers
          .deserializeWith(Guser_to_role_pk_columns_input.serializer, json);
}

class Guser_to_role_select_column extends EnumClass {
  const Guser_to_role_select_column._(String name) : super(name);

  static const Guser_to_role_select_column id = _$guserToRoleSelectColumnid;

  static const Guser_to_role_select_column role_id =
      _$guserToRoleSelectColumnrole_id;

  static const Guser_to_role_select_column user_id =
      _$guserToRoleSelectColumnuser_id;

  static Serializer<Guser_to_role_select_column> get serializer =>
      _$guserToRoleSelectColumnSerializer;
  static BuiltSet<Guser_to_role_select_column> get values =>
      _$guserToRoleSelectColumnValues;
  static Guser_to_role_select_column valueOf(String name) =>
      _$guserToRoleSelectColumnValueOf(name);
}

abstract class Guser_to_role_set_input
    implements Built<Guser_to_role_set_input, Guser_to_role_set_inputBuilder> {
  Guser_to_role_set_input._();

  factory Guser_to_role_set_input(
          [Function(Guser_to_role_set_inputBuilder b) updates]) =
      _$Guser_to_role_set_input;

  _i2.UuidType? get id;
  _i2.UuidType? get role_id;
  _i2.UuidType? get user_id;
  static Serializer<Guser_to_role_set_input> get serializer =>
      _$guserToRoleSetInputSerializer;
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(Guser_to_role_set_input.serializer, this)
          as Map<String, dynamic>);
  static Guser_to_role_set_input? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(Guser_to_role_set_input.serializer, json);
}

class Guser_to_role_update_column extends EnumClass {
  const Guser_to_role_update_column._(String name) : super(name);

  static const Guser_to_role_update_column id = _$guserToRoleUpdateColumnid;

  static const Guser_to_role_update_column role_id =
      _$guserToRoleUpdateColumnrole_id;

  static const Guser_to_role_update_column user_id =
      _$guserToRoleUpdateColumnuser_id;

  static Serializer<Guser_to_role_update_column> get serializer =>
      _$guserToRoleUpdateColumnSerializer;
  static BuiltSet<Guser_to_role_update_column> get values =>
      _$guserToRoleUpdateColumnValues;
  static Guser_to_role_update_column valueOf(String name) =>
      _$guserToRoleUpdateColumnValueOf(name);
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
  Gthreads_bool_exp? get thread;
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

abstract class Guser_to_thread_insert_input
    implements
        Built<Guser_to_thread_insert_input,
            Guser_to_thread_insert_inputBuilder> {
  Guser_to_thread_insert_input._();

  factory Guser_to_thread_insert_input(
          [Function(Guser_to_thread_insert_inputBuilder b) updates]) =
      _$Guser_to_thread_insert_input;

  Gthreads_obj_rel_insert_input? get thread;
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

abstract class Guser_to_thread_order_by
    implements
        Built<Guser_to_thread_order_by, Guser_to_thread_order_byBuilder> {
  Guser_to_thread_order_by._();

  factory Guser_to_thread_order_by(
          [Function(Guser_to_thread_order_byBuilder b) updates]) =
      _$Guser_to_thread_order_by;

  Gthreads_order_by? get thread;
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

class Guser_to_thread_select_column extends EnumClass {
  const Guser_to_thread_select_column._(String name) : super(name);

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
  Guser_to_group_bool_exp? get groups;
  Guuid_comparison_exp? get id;
  Gmessage_reactions_bool_exp? get message_reactions;
  Gmessages_bool_exp? get messages;
  GString_comparison_exp? get name;
  GString_comparison_exp? get sub;
  Guser_to_dm_bool_exp? get user_to_dms;
  Guser_to_role_bool_exp? get user_to_roles;
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
  Guser_to_group_arr_rel_insert_input? get groups;
  _i2.UuidType? get id;
  Gmessage_reactions_arr_rel_insert_input? get message_reactions;
  Gmessages_arr_rel_insert_input? get messages;
  String? get name;
  String? get sub;
  Guser_to_dm_arr_rel_insert_input? get user_to_dms;
  Guser_to_role_arr_rel_insert_input? get user_to_roles;
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
  Guser_to_group_aggregate_order_by? get groups_aggregate;
  Gorder_by? get id;
  Gmessage_reactions_aggregate_order_by? get message_reactions_aggregate;
  Gmessages_aggregate_order_by? get messages_aggregate;
  Gorder_by? get name;
  Gorder_by? get sub;
  Guser_to_dm_aggregate_order_by? get user_to_dms_aggregate;
  Guser_to_role_aggregate_order_by? get user_to_roles_aggregate;
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
