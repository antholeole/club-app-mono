/* eslint-disable */

import { AllTypesProps, ReturnTypes } from './const';
type ZEUS_INTERFACES = never
type ZEUS_UNIONS = never

export type ValueTypes = {
    /** expression to compare columns of type String. All fields are combined with logical 'AND'. */
["String_comparison_exp"]: {
	_eq?:string,
	_gt?:string,
	_gte?:string,
	_ilike?:string,
	_in?:string[],
	_is_null?:boolean,
	_like?:string,
	_lt?:string,
	_lte?:string,
	_neq?:string,
	_nilike?:string,
	_nin?:string[],
	_nlike?:string,
	_nsimilar?:string,
	_similar?:string
};
	/** mutation root */
["mutation_root"]: AliasType<{
delete_refresh_tokens?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens_mutation_response"]],
delete_refresh_tokens_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["refresh_tokens"]],
delete_users?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["users_bool_exp"]},ValueTypes["users_mutation_response"]],
delete_users_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["users"]],
insert_refresh_tokens?: [{	/** the rows to be inserted */
	objects:ValueTypes["refresh_tokens_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["refresh_tokens_on_conflict"]},ValueTypes["refresh_tokens_mutation_response"]],
insert_refresh_tokens_one?: [{	/** the row to be inserted */
	object:ValueTypes["refresh_tokens_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["refresh_tokens_on_conflict"]},ValueTypes["refresh_tokens"]],
insert_users?: [{	/** the rows to be inserted */
	objects:ValueTypes["users_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["users_on_conflict"]},ValueTypes["users_mutation_response"]],
insert_users_one?: [{	/** the row to be inserted */
	object:ValueTypes["users_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["users_on_conflict"]},ValueTypes["users"]],
update_refresh_tokens?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["refresh_tokens_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens_mutation_response"]],
update_refresh_tokens_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["refresh_tokens_set_input"],	pk_columns:ValueTypes["refresh_tokens_pk_columns_input"]},ValueTypes["refresh_tokens"]],
update_users?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["users_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["users_bool_exp"]},ValueTypes["users_mutation_response"]],
update_users_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["users_set_input"],	pk_columns:ValueTypes["users_pk_columns_input"]},ValueTypes["users"]],
		__typename?: true
}>;
	/** column ordering options */
["order_by"]:order_by;
	/** query root */
["query_root"]: AliasType<{
refresh_tokens?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["refresh_tokens_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["refresh_tokens_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens"]],
refresh_tokens_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["refresh_tokens_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["refresh_tokens_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens_aggregate"]],
refresh_tokens_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["refresh_tokens"]],
users?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["users_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["users_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["users_bool_exp"]},ValueTypes["users"]],
users_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["users_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["users_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["users_bool_exp"]},ValueTypes["users_aggregate"]],
users_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["users"]],
		__typename?: true
}>;
	/** columns and relationships of "refresh_tokens" */
["refresh_tokens"]: AliasType<{
	id?:true,
	refresh_token?:true,
	user_id?:true,
		__typename?: true
}>;
	/** aggregated selection of "refresh_tokens" */
["refresh_tokens_aggregate"]: AliasType<{
	aggregate?:ValueTypes["refresh_tokens_aggregate_fields"],
	nodes?:ValueTypes["refresh_tokens"],
		__typename?: true
}>;
	/** aggregate fields of "refresh_tokens" */
["refresh_tokens_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["refresh_tokens_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["refresh_tokens_max_fields"],
	min?:ValueTypes["refresh_tokens_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "refresh_tokens" */
["refresh_tokens_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["refresh_tokens_max_order_by"],
	min?:ValueTypes["refresh_tokens_min_order_by"]
};
	/** input type for inserting array relation for remote table "refresh_tokens" */
["refresh_tokens_arr_rel_insert_input"]: {
	data:ValueTypes["refresh_tokens_insert_input"][],
	on_conflict?:ValueTypes["refresh_tokens_on_conflict"]
};
	/** Boolean expression to filter rows from the table "refresh_tokens". All fields are combined with a logical 'AND'. */
["refresh_tokens_bool_exp"]: {
	_and?:(ValueTypes["refresh_tokens_bool_exp"] | undefined)[],
	_not?:ValueTypes["refresh_tokens_bool_exp"],
	_or?:(ValueTypes["refresh_tokens_bool_exp"] | undefined)[],
	id?:ValueTypes["uuid_comparison_exp"],
	refresh_token?:ValueTypes["String_comparison_exp"],
	user_id?:ValueTypes["uuid_comparison_exp"]
};
	/** unique or primary key constraints on table "refresh_tokens" */
["refresh_tokens_constraint"]:refresh_tokens_constraint;
	/** input type for inserting data into table "refresh_tokens" */
["refresh_tokens_insert_input"]: {
	id?:ValueTypes["uuid"],
	refresh_token?:string,
	user_id?:ValueTypes["uuid"]
};
	/** aggregate max on columns */
["refresh_tokens_max_fields"]: AliasType<{
	id?:true,
	refresh_token?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "refresh_tokens" */
["refresh_tokens_max_order_by"]: {
	id?:ValueTypes["order_by"],
	refresh_token?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["refresh_tokens_min_fields"]: AliasType<{
	id?:true,
	refresh_token?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "refresh_tokens" */
["refresh_tokens_min_order_by"]: {
	id?:ValueTypes["order_by"],
	refresh_token?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "refresh_tokens" */
["refresh_tokens_mutation_response"]: AliasType<{
	/** number of affected rows by the mutation */
	affected_rows?:true,
	/** data of the affected rows by the mutation */
	returning?:ValueTypes["refresh_tokens"],
		__typename?: true
}>;
	/** input type for inserting object relation for remote table "refresh_tokens" */
["refresh_tokens_obj_rel_insert_input"]: {
	data:ValueTypes["refresh_tokens_insert_input"],
	on_conflict?:ValueTypes["refresh_tokens_on_conflict"]
};
	/** on conflict condition type for table "refresh_tokens" */
["refresh_tokens_on_conflict"]: {
	constraint:ValueTypes["refresh_tokens_constraint"],
	update_columns:ValueTypes["refresh_tokens_update_column"][],
	where?:ValueTypes["refresh_tokens_bool_exp"]
};
	/** ordering options when selecting data from "refresh_tokens" */
["refresh_tokens_order_by"]: {
	id?:ValueTypes["order_by"],
	refresh_token?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** primary key columns input for table: "refresh_tokens" */
["refresh_tokens_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "refresh_tokens" */
["refresh_tokens_select_column"]:refresh_tokens_select_column;
	/** input type for updating data in table "refresh_tokens" */
["refresh_tokens_set_input"]: {
	id?:ValueTypes["uuid"],
	refresh_token?:string,
	user_id?:ValueTypes["uuid"]
};
	/** update columns of table "refresh_tokens" */
["refresh_tokens_update_column"]:refresh_tokens_update_column;
	/** subscription root */
["subscription_root"]: AliasType<{
refresh_tokens?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["refresh_tokens_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["refresh_tokens_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens"]],
refresh_tokens_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["refresh_tokens_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["refresh_tokens_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["refresh_tokens_bool_exp"]},ValueTypes["refresh_tokens_aggregate"]],
refresh_tokens_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["refresh_tokens"]],
users?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["users_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["users_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["users_bool_exp"]},ValueTypes["users"]],
users_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["users_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["users_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["users_bool_exp"]},ValueTypes["users_aggregate"]],
users_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["users"]],
		__typename?: true
}>;
	/** columns and relationships of "users" */
["users"]: AliasType<{
	id?:true,
	is_online?:true,
	name?:true,
	sub?:true,
		__typename?: true
}>;
	/** aggregated selection of "users" */
["users_aggregate"]: AliasType<{
	aggregate?:ValueTypes["users_aggregate_fields"],
	nodes?:ValueTypes["users"],
		__typename?: true
}>;
	/** aggregate fields of "users" */
["users_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["users_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["users_max_fields"],
	min?:ValueTypes["users_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "users" */
["users_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["users_max_order_by"],
	min?:ValueTypes["users_min_order_by"]
};
	/** input type for inserting array relation for remote table "users" */
["users_arr_rel_insert_input"]: {
	data:ValueTypes["users_insert_input"][],
	on_conflict?:ValueTypes["users_on_conflict"]
};
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: {
	_and?:(ValueTypes["users_bool_exp"] | undefined)[],
	_not?:ValueTypes["users_bool_exp"],
	_or?:(ValueTypes["users_bool_exp"] | undefined)[],
	id?:ValueTypes["uuid_comparison_exp"],
	is_online?:ValueTypes["String_comparison_exp"],
	name?:ValueTypes["String_comparison_exp"],
	sub?:ValueTypes["String_comparison_exp"]
};
	/** unique or primary key constraints on table "users" */
["users_constraint"]:users_constraint;
	/** input type for inserting data into table "users" */
["users_insert_input"]: {
	id?:ValueTypes["uuid"],
	is_online?:string,
	name?:string,
	sub?:string
};
	/** aggregate max on columns */
["users_max_fields"]: AliasType<{
	id?:true,
	is_online?:true,
	name?:true,
	sub?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "users" */
["users_max_order_by"]: {
	id?:ValueTypes["order_by"],
	is_online?:ValueTypes["order_by"],
	name?:ValueTypes["order_by"],
	sub?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["users_min_fields"]: AliasType<{
	id?:true,
	is_online?:true,
	name?:true,
	sub?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "users" */
["users_min_order_by"]: {
	id?:ValueTypes["order_by"],
	is_online?:ValueTypes["order_by"],
	name?:ValueTypes["order_by"],
	sub?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "users" */
["users_mutation_response"]: AliasType<{
	/** number of affected rows by the mutation */
	affected_rows?:true,
	/** data of the affected rows by the mutation */
	returning?:ValueTypes["users"],
		__typename?: true
}>;
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: {
	data:ValueTypes["users_insert_input"],
	on_conflict?:ValueTypes["users_on_conflict"]
};
	/** on conflict condition type for table "users" */
["users_on_conflict"]: {
	constraint:ValueTypes["users_constraint"],
	update_columns:ValueTypes["users_update_column"][],
	where?:ValueTypes["users_bool_exp"]
};
	/** ordering options when selecting data from "users" */
["users_order_by"]: {
	id?:ValueTypes["order_by"],
	is_online?:ValueTypes["order_by"],
	name?:ValueTypes["order_by"],
	sub?:ValueTypes["order_by"]
};
	/** primary key columns input for table: "users" */
["users_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "users" */
["users_select_column"]:users_select_column;
	/** input type for updating data in table "users" */
["users_set_input"]: {
	id?:ValueTypes["uuid"],
	is_online?:string,
	name?:string,
	sub?:string
};
	/** update columns of table "users" */
["users_update_column"]:users_update_column;
	["uuid"]:unknown;
	/** expression to compare columns of type uuid. All fields are combined with logical 'AND'. */
["uuid_comparison_exp"]: {
	_eq?:ValueTypes["uuid"],
	_gt?:ValueTypes["uuid"],
	_gte?:ValueTypes["uuid"],
	_in?:ValueTypes["uuid"][],
	_is_null?:boolean,
	_lt?:ValueTypes["uuid"],
	_lte?:ValueTypes["uuid"],
	_neq?:ValueTypes["uuid"],
	_nin?:ValueTypes["uuid"][]
}
  }

export type ModelTypes = {
    /** expression to compare columns of type String. All fields are combined with logical 'AND'. */
["String_comparison_exp"]: GraphQLTypes["String_comparison_exp"];
	/** mutation root */
["mutation_root"]: {
		/** delete data from the table: "refresh_tokens" */
	delete_refresh_tokens?:ModelTypes["refresh_tokens_mutation_response"],
	/** delete single row from the table: "refresh_tokens" */
	delete_refresh_tokens_by_pk?:ModelTypes["refresh_tokens"],
	/** delete data from the table: "users" */
	delete_users?:ModelTypes["users_mutation_response"],
	/** delete single row from the table: "users" */
	delete_users_by_pk?:ModelTypes["users"],
	/** insert data into the table: "refresh_tokens" */
	insert_refresh_tokens?:ModelTypes["refresh_tokens_mutation_response"],
	/** insert a single row into the table: "refresh_tokens" */
	insert_refresh_tokens_one?:ModelTypes["refresh_tokens"],
	/** insert data into the table: "users" */
	insert_users?:ModelTypes["users_mutation_response"],
	/** insert a single row into the table: "users" */
	insert_users_one?:ModelTypes["users"],
	/** update data of the table: "refresh_tokens" */
	update_refresh_tokens?:ModelTypes["refresh_tokens_mutation_response"],
	/** update single row of the table: "refresh_tokens" */
	update_refresh_tokens_by_pk?:ModelTypes["refresh_tokens"],
	/** update data of the table: "users" */
	update_users?:ModelTypes["users_mutation_response"],
	/** update single row of the table: "users" */
	update_users_by_pk?:ModelTypes["users"]
};
	/** column ordering options */
["order_by"]: GraphQLTypes["order_by"];
	/** query root */
["query_root"]: {
		/** fetch data from the table: "refresh_tokens" */
	refresh_tokens:ModelTypes["refresh_tokens"][],
	/** fetch aggregated fields from the table: "refresh_tokens" */
	refresh_tokens_aggregate:ModelTypes["refresh_tokens_aggregate"],
	/** fetch data from the table: "refresh_tokens" using primary key columns */
	refresh_tokens_by_pk?:ModelTypes["refresh_tokens"],
	/** fetch data from the table: "users" */
	users:ModelTypes["users"][],
	/** fetch aggregated fields from the table: "users" */
	users_aggregate:ModelTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk?:ModelTypes["users"]
};
	/** columns and relationships of "refresh_tokens" */
["refresh_tokens"]: {
		id:ModelTypes["uuid"],
	refresh_token:string,
	user_id:ModelTypes["uuid"]
};
	/** aggregated selection of "refresh_tokens" */
["refresh_tokens_aggregate"]: {
		aggregate?:ModelTypes["refresh_tokens_aggregate_fields"],
	nodes:ModelTypes["refresh_tokens"][]
};
	/** aggregate fields of "refresh_tokens" */
["refresh_tokens_aggregate_fields"]: {
		count?:number,
	max?:ModelTypes["refresh_tokens_max_fields"],
	min?:ModelTypes["refresh_tokens_min_fields"]
};
	/** order by aggregate values of table "refresh_tokens" */
["refresh_tokens_aggregate_order_by"]: GraphQLTypes["refresh_tokens_aggregate_order_by"];
	/** input type for inserting array relation for remote table "refresh_tokens" */
["refresh_tokens_arr_rel_insert_input"]: GraphQLTypes["refresh_tokens_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "refresh_tokens". All fields are combined with a logical 'AND'. */
["refresh_tokens_bool_exp"]: GraphQLTypes["refresh_tokens_bool_exp"];
	/** unique or primary key constraints on table "refresh_tokens" */
["refresh_tokens_constraint"]: GraphQLTypes["refresh_tokens_constraint"];
	/** input type for inserting data into table "refresh_tokens" */
["refresh_tokens_insert_input"]: GraphQLTypes["refresh_tokens_insert_input"];
	/** aggregate max on columns */
["refresh_tokens_max_fields"]: {
		id?:ModelTypes["uuid"],
	refresh_token?:string,
	user_id?:ModelTypes["uuid"]
};
	/** order by max() on columns of table "refresh_tokens" */
["refresh_tokens_max_order_by"]: GraphQLTypes["refresh_tokens_max_order_by"];
	/** aggregate min on columns */
["refresh_tokens_min_fields"]: {
		id?:ModelTypes["uuid"],
	refresh_token?:string,
	user_id?:ModelTypes["uuid"]
};
	/** order by min() on columns of table "refresh_tokens" */
["refresh_tokens_min_order_by"]: GraphQLTypes["refresh_tokens_min_order_by"];
	/** response of any mutation on the table "refresh_tokens" */
["refresh_tokens_mutation_response"]: {
		/** number of affected rows by the mutation */
	affected_rows:number,
	/** data of the affected rows by the mutation */
	returning:ModelTypes["refresh_tokens"][]
};
	/** input type for inserting object relation for remote table "refresh_tokens" */
["refresh_tokens_obj_rel_insert_input"]: GraphQLTypes["refresh_tokens_obj_rel_insert_input"];
	/** on conflict condition type for table "refresh_tokens" */
["refresh_tokens_on_conflict"]: GraphQLTypes["refresh_tokens_on_conflict"];
	/** ordering options when selecting data from "refresh_tokens" */
["refresh_tokens_order_by"]: GraphQLTypes["refresh_tokens_order_by"];
	/** primary key columns input for table: "refresh_tokens" */
["refresh_tokens_pk_columns_input"]: GraphQLTypes["refresh_tokens_pk_columns_input"];
	/** select columns of table "refresh_tokens" */
["refresh_tokens_select_column"]: GraphQLTypes["refresh_tokens_select_column"];
	/** input type for updating data in table "refresh_tokens" */
["refresh_tokens_set_input"]: GraphQLTypes["refresh_tokens_set_input"];
	/** update columns of table "refresh_tokens" */
["refresh_tokens_update_column"]: GraphQLTypes["refresh_tokens_update_column"];
	/** subscription root */
["subscription_root"]: {
		/** fetch data from the table: "refresh_tokens" */
	refresh_tokens:ModelTypes["refresh_tokens"][],
	/** fetch aggregated fields from the table: "refresh_tokens" */
	refresh_tokens_aggregate:ModelTypes["refresh_tokens_aggregate"],
	/** fetch data from the table: "refresh_tokens" using primary key columns */
	refresh_tokens_by_pk?:ModelTypes["refresh_tokens"],
	/** fetch data from the table: "users" */
	users:ModelTypes["users"][],
	/** fetch aggregated fields from the table: "users" */
	users_aggregate:ModelTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk?:ModelTypes["users"]
};
	/** columns and relationships of "users" */
["users"]: {
		id:ModelTypes["uuid"],
	is_online?:string,
	name:string,
	sub:string
};
	/** aggregated selection of "users" */
["users_aggregate"]: {
		aggregate?:ModelTypes["users_aggregate_fields"],
	nodes:ModelTypes["users"][]
};
	/** aggregate fields of "users" */
["users_aggregate_fields"]: {
		count?:number,
	max?:ModelTypes["users_max_fields"],
	min?:ModelTypes["users_min_fields"]
};
	/** order by aggregate values of table "users" */
["users_aggregate_order_by"]: GraphQLTypes["users_aggregate_order_by"];
	/** input type for inserting array relation for remote table "users" */
["users_arr_rel_insert_input"]: GraphQLTypes["users_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: GraphQLTypes["users_bool_exp"];
	/** unique or primary key constraints on table "users" */
["users_constraint"]: GraphQLTypes["users_constraint"];
	/** input type for inserting data into table "users" */
["users_insert_input"]: GraphQLTypes["users_insert_input"];
	/** aggregate max on columns */
["users_max_fields"]: {
		id?:ModelTypes["uuid"],
	is_online?:string,
	name?:string,
	sub?:string
};
	/** order by max() on columns of table "users" */
["users_max_order_by"]: GraphQLTypes["users_max_order_by"];
	/** aggregate min on columns */
["users_min_fields"]: {
		id?:ModelTypes["uuid"],
	is_online?:string,
	name?:string,
	sub?:string
};
	/** order by min() on columns of table "users" */
["users_min_order_by"]: GraphQLTypes["users_min_order_by"];
	/** response of any mutation on the table "users" */
["users_mutation_response"]: {
		/** number of affected rows by the mutation */
	affected_rows:number,
	/** data of the affected rows by the mutation */
	returning:ModelTypes["users"][]
};
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: GraphQLTypes["users_obj_rel_insert_input"];
	/** on conflict condition type for table "users" */
["users_on_conflict"]: GraphQLTypes["users_on_conflict"];
	/** ordering options when selecting data from "users" */
["users_order_by"]: GraphQLTypes["users_order_by"];
	/** primary key columns input for table: "users" */
["users_pk_columns_input"]: GraphQLTypes["users_pk_columns_input"];
	/** select columns of table "users" */
["users_select_column"]: GraphQLTypes["users_select_column"];
	/** input type for updating data in table "users" */
["users_set_input"]: GraphQLTypes["users_set_input"];
	/** update columns of table "users" */
["users_update_column"]: GraphQLTypes["users_update_column"];
	["uuid"]:any;
	/** expression to compare columns of type uuid. All fields are combined with logical 'AND'. */
["uuid_comparison_exp"]: GraphQLTypes["uuid_comparison_exp"]
    }

export type GraphQLTypes = {
    /** expression to compare columns of type String. All fields are combined with logical 'AND'. */
["String_comparison_exp"]: {
		_eq: string | null,
	_gt: string | null,
	_gte: string | null,
	_ilike: string | null,
	_in: Array<string> | null,
	_is_null: boolean | null,
	_like: string | null,
	_lt: string | null,
	_lte: string | null,
	_neq: string | null,
	_nilike: string | null,
	_nin: Array<string> | null,
	_nlike: string | null,
	_nsimilar: string | null,
	_similar: string | null
};
	/** mutation root */
["mutation_root"]: {
	__typename: "mutation_root",
	/** delete data from the table: "refresh_tokens" */
	delete_refresh_tokens: GraphQLTypes["refresh_tokens_mutation_response"] | null,
	/** delete single row from the table: "refresh_tokens" */
	delete_refresh_tokens_by_pk: GraphQLTypes["refresh_tokens"] | null,
	/** delete data from the table: "users" */
	delete_users: GraphQLTypes["users_mutation_response"] | null,
	/** delete single row from the table: "users" */
	delete_users_by_pk: GraphQLTypes["users"] | null,
	/** insert data into the table: "refresh_tokens" */
	insert_refresh_tokens: GraphQLTypes["refresh_tokens_mutation_response"] | null,
	/** insert a single row into the table: "refresh_tokens" */
	insert_refresh_tokens_one: GraphQLTypes["refresh_tokens"] | null,
	/** insert data into the table: "users" */
	insert_users: GraphQLTypes["users_mutation_response"] | null,
	/** insert a single row into the table: "users" */
	insert_users_one: GraphQLTypes["users"] | null,
	/** update data of the table: "refresh_tokens" */
	update_refresh_tokens: GraphQLTypes["refresh_tokens_mutation_response"] | null,
	/** update single row of the table: "refresh_tokens" */
	update_refresh_tokens_by_pk: GraphQLTypes["refresh_tokens"] | null,
	/** update data of the table: "users" */
	update_users: GraphQLTypes["users_mutation_response"] | null,
	/** update single row of the table: "users" */
	update_users_by_pk: GraphQLTypes["users"] | null
};
	/** column ordering options */
["order_by"]: order_by;
	/** query root */
["query_root"]: {
	__typename: "query_root",
	/** fetch data from the table: "refresh_tokens" */
	refresh_tokens: Array<GraphQLTypes["refresh_tokens"]>,
	/** fetch aggregated fields from the table: "refresh_tokens" */
	refresh_tokens_aggregate: GraphQLTypes["refresh_tokens_aggregate"],
	/** fetch data from the table: "refresh_tokens" using primary key columns */
	refresh_tokens_by_pk: GraphQLTypes["refresh_tokens"] | null,
	/** fetch data from the table: "users" */
	users: Array<GraphQLTypes["users"]>,
	/** fetch aggregated fields from the table: "users" */
	users_aggregate: GraphQLTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk: GraphQLTypes["users"] | null
};
	/** columns and relationships of "refresh_tokens" */
["refresh_tokens"]: {
	__typename: "refresh_tokens",
	id: GraphQLTypes["uuid"],
	refresh_token: string,
	user_id: GraphQLTypes["uuid"]
};
	/** aggregated selection of "refresh_tokens" */
["refresh_tokens_aggregate"]: {
	__typename: "refresh_tokens_aggregate",
	aggregate: GraphQLTypes["refresh_tokens_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["refresh_tokens"]>
};
	/** aggregate fields of "refresh_tokens" */
["refresh_tokens_aggregate_fields"]: {
	__typename: "refresh_tokens_aggregate_fields",
	count: number | null,
	max: GraphQLTypes["refresh_tokens_max_fields"] | null,
	min: GraphQLTypes["refresh_tokens_min_fields"] | null
};
	/** order by aggregate values of table "refresh_tokens" */
["refresh_tokens_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["refresh_tokens_max_order_by"] | null,
	min: GraphQLTypes["refresh_tokens_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "refresh_tokens" */
["refresh_tokens_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["refresh_tokens_insert_input"]>,
	on_conflict: GraphQLTypes["refresh_tokens_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "refresh_tokens". All fields are combined with a logical 'AND'. */
["refresh_tokens_bool_exp"]: {
		_and: Array<GraphQLTypes["refresh_tokens_bool_exp"] | null> | null,
	_not: GraphQLTypes["refresh_tokens_bool_exp"] | null,
	_or: Array<GraphQLTypes["refresh_tokens_bool_exp"] | null> | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	refresh_token: GraphQLTypes["String_comparison_exp"] | null,
	user_id: GraphQLTypes["uuid_comparison_exp"] | null
};
	/** unique or primary key constraints on table "refresh_tokens" */
["refresh_tokens_constraint"]: refresh_tokens_constraint;
	/** input type for inserting data into table "refresh_tokens" */
["refresh_tokens_insert_input"]: {
		id: GraphQLTypes["uuid"] | null,
	refresh_token: string | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** aggregate max on columns */
["refresh_tokens_max_fields"]: {
	__typename: "refresh_tokens_max_fields",
	id: GraphQLTypes["uuid"] | null,
	refresh_token: string | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by max() on columns of table "refresh_tokens" */
["refresh_tokens_max_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	refresh_token: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["refresh_tokens_min_fields"]: {
	__typename: "refresh_tokens_min_fields",
	id: GraphQLTypes["uuid"] | null,
	refresh_token: string | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by min() on columns of table "refresh_tokens" */
["refresh_tokens_min_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	refresh_token: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "refresh_tokens" */
["refresh_tokens_mutation_response"]: {
	__typename: "refresh_tokens_mutation_response",
	/** number of affected rows by the mutation */
	affected_rows: number,
	/** data of the affected rows by the mutation */
	returning: Array<GraphQLTypes["refresh_tokens"]>
};
	/** input type for inserting object relation for remote table "refresh_tokens" */
["refresh_tokens_obj_rel_insert_input"]: {
		data: GraphQLTypes["refresh_tokens_insert_input"],
	on_conflict: GraphQLTypes["refresh_tokens_on_conflict"] | null
};
	/** on conflict condition type for table "refresh_tokens" */
["refresh_tokens_on_conflict"]: {
		constraint: GraphQLTypes["refresh_tokens_constraint"],
	update_columns: Array<GraphQLTypes["refresh_tokens_update_column"]>,
	where: GraphQLTypes["refresh_tokens_bool_exp"] | null
};
	/** ordering options when selecting data from "refresh_tokens" */
["refresh_tokens_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	refresh_token: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** primary key columns input for table: "refresh_tokens" */
["refresh_tokens_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "refresh_tokens" */
["refresh_tokens_select_column"]: refresh_tokens_select_column;
	/** input type for updating data in table "refresh_tokens" */
["refresh_tokens_set_input"]: {
		id: GraphQLTypes["uuid"] | null,
	refresh_token: string | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** update columns of table "refresh_tokens" */
["refresh_tokens_update_column"]: refresh_tokens_update_column;
	/** subscription root */
["subscription_root"]: {
	__typename: "subscription_root",
	/** fetch data from the table: "refresh_tokens" */
	refresh_tokens: Array<GraphQLTypes["refresh_tokens"]>,
	/** fetch aggregated fields from the table: "refresh_tokens" */
	refresh_tokens_aggregate: GraphQLTypes["refresh_tokens_aggregate"],
	/** fetch data from the table: "refresh_tokens" using primary key columns */
	refresh_tokens_by_pk: GraphQLTypes["refresh_tokens"] | null,
	/** fetch data from the table: "users" */
	users: Array<GraphQLTypes["users"]>,
	/** fetch aggregated fields from the table: "users" */
	users_aggregate: GraphQLTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk: GraphQLTypes["users"] | null
};
	/** columns and relationships of "users" */
["users"]: {
	__typename: "users",
	id: GraphQLTypes["uuid"],
	is_online: string | null,
	name: string,
	sub: string
};
	/** aggregated selection of "users" */
["users_aggregate"]: {
	__typename: "users_aggregate",
	aggregate: GraphQLTypes["users_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["users"]>
};
	/** aggregate fields of "users" */
["users_aggregate_fields"]: {
	__typename: "users_aggregate_fields",
	count: number | null,
	max: GraphQLTypes["users_max_fields"] | null,
	min: GraphQLTypes["users_min_fields"] | null
};
	/** order by aggregate values of table "users" */
["users_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["users_max_order_by"] | null,
	min: GraphQLTypes["users_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "users" */
["users_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["users_insert_input"]>,
	on_conflict: GraphQLTypes["users_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: {
		_and: Array<GraphQLTypes["users_bool_exp"] | null> | null,
	_not: GraphQLTypes["users_bool_exp"] | null,
	_or: Array<GraphQLTypes["users_bool_exp"] | null> | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	is_online: GraphQLTypes["String_comparison_exp"] | null,
	name: GraphQLTypes["String_comparison_exp"] | null,
	sub: GraphQLTypes["String_comparison_exp"] | null
};
	/** unique or primary key constraints on table "users" */
["users_constraint"]: users_constraint;
	/** input type for inserting data into table "users" */
["users_insert_input"]: {
		id: GraphQLTypes["uuid"] | null,
	is_online: string | null,
	name: string | null,
	sub: string | null
};
	/** aggregate max on columns */
["users_max_fields"]: {
	__typename: "users_max_fields",
	id: GraphQLTypes["uuid"] | null,
	is_online: string | null,
	name: string | null,
	sub: string | null
};
	/** order by max() on columns of table "users" */
["users_max_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	is_online: GraphQLTypes["order_by"] | null,
	name: GraphQLTypes["order_by"] | null,
	sub: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["users_min_fields"]: {
	__typename: "users_min_fields",
	id: GraphQLTypes["uuid"] | null,
	is_online: string | null,
	name: string | null,
	sub: string | null
};
	/** order by min() on columns of table "users" */
["users_min_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	is_online: GraphQLTypes["order_by"] | null,
	name: GraphQLTypes["order_by"] | null,
	sub: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "users" */
["users_mutation_response"]: {
	__typename: "users_mutation_response",
	/** number of affected rows by the mutation */
	affected_rows: number,
	/** data of the affected rows by the mutation */
	returning: Array<GraphQLTypes["users"]>
};
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: {
		data: GraphQLTypes["users_insert_input"],
	on_conflict: GraphQLTypes["users_on_conflict"] | null
};
	/** on conflict condition type for table "users" */
["users_on_conflict"]: {
		constraint: GraphQLTypes["users_constraint"],
	update_columns: Array<GraphQLTypes["users_update_column"]>,
	where: GraphQLTypes["users_bool_exp"] | null
};
	/** ordering options when selecting data from "users" */
["users_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	is_online: GraphQLTypes["order_by"] | null,
	name: GraphQLTypes["order_by"] | null,
	sub: GraphQLTypes["order_by"] | null
};
	/** primary key columns input for table: "users" */
["users_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "users" */
["users_select_column"]: users_select_column;
	/** input type for updating data in table "users" */
["users_set_input"]: {
		id: GraphQLTypes["uuid"] | null,
	is_online: string | null,
	name: string | null,
	sub: string | null
};
	/** update columns of table "users" */
["users_update_column"]: users_update_column;
	["uuid"]:any;
	/** expression to compare columns of type uuid. All fields are combined with logical 'AND'. */
["uuid_comparison_exp"]: {
		_eq: GraphQLTypes["uuid"] | null,
	_gt: GraphQLTypes["uuid"] | null,
	_gte: GraphQLTypes["uuid"] | null,
	_in: Array<GraphQLTypes["uuid"]> | null,
	_is_null: boolean | null,
	_lt: GraphQLTypes["uuid"] | null,
	_lte: GraphQLTypes["uuid"] | null,
	_neq: GraphQLTypes["uuid"] | null,
	_nin: Array<GraphQLTypes["uuid"]> | null
}
    }
/** column ordering options */
export enum order_by {
	asc = "asc",
	asc_nulls_first = "asc_nulls_first",
	asc_nulls_last = "asc_nulls_last",
	desc = "desc",
	desc_nulls_first = "desc_nulls_first",
	desc_nulls_last = "desc_nulls_last"
}
/** unique or primary key constraints on table "refresh_tokens" */
export enum refresh_tokens_constraint {
	refresh_tokens_pkey = "refresh_tokens_pkey",
	refresh_tokens_user_id_key = "refresh_tokens_user_id_key"
}
/** select columns of table "refresh_tokens" */
export enum refresh_tokens_select_column {
	id = "id",
	refresh_token = "refresh_token",
	user_id = "user_id"
}
/** update columns of table "refresh_tokens" */
export enum refresh_tokens_update_column {
	id = "id",
	refresh_token = "refresh_token",
	user_id = "user_id"
}
/** unique or primary key constraints on table "users" */
export enum users_constraint {
	users_pkey = "users_pkey",
	users_sub_key = "users_sub_key"
}
/** select columns of table "users" */
export enum users_select_column {
	id = "id",
	is_online = "is_online",
	name = "name",
	sub = "sub"
}
/** update columns of table "users" */
export enum users_update_column {
	id = "id",
	is_online = "is_online",
	name = "name",
	sub = "sub"
}
export class GraphQLError extends Error {
    constructor(public response: GraphQLResponse) {
      super("");
      console.error(response);
    }
    toString() {
      return "GraphQL Response Error";
    }
  }


export type UnwrapPromise<T> = T extends Promise<infer R> ? R : T;
export type ZeusState<T extends (...args: any[]) => Promise<any>> = NonNullable<
  UnwrapPromise<ReturnType<T>>
>;
export type ZeusHook<
  T extends (
    ...args: any[]
  ) => Record<string, (...args: any[]) => Promise<any>>,
  N extends keyof ReturnType<T>
> = ZeusState<ReturnType<T>[N]>;

type WithTypeNameValue<T> = T & {
  __typename?: true;
};
type AliasType<T> = WithTypeNameValue<T> & {
  __alias?: Record<string, WithTypeNameValue<T>>;
};
export interface GraphQLResponse {
  data?: Record<string, any>;
  errors?: Array<{
    message: string;
  }>;
}
type DeepAnify<T> = {
  [P in keyof T]?: any;
};
type IsPayLoad<T> = T extends [any, infer PayLoad] ? PayLoad : T;
type IsArray<T, U> = T extends Array<infer R> ? InputType<R, U>[] : InputType<T, U>;
type FlattenArray<T> = T extends Array<infer R> ? R : T;

type NotUnionTypes<SRC extends DeepAnify<DST>, DST> = {
  [P in keyof DST]: SRC[P] extends '__union' & infer R ? never : P;
}[keyof DST];

type ExtractUnions<SRC extends DeepAnify<DST>, DST> = {
  [P in keyof SRC]: SRC[P] extends '__union' & infer R
    ? P extends keyof DST
      ? IsArray<R, DST[P] & { __typename: true }>
      : {}
    : never;
}[keyof SRC];

type IsInterfaced<SRC extends DeepAnify<DST>, DST> = FlattenArray<SRC> extends ZEUS_INTERFACES | ZEUS_UNIONS
  ? ExtractUnions<SRC, DST> &
      {
        [P in keyof Omit<Pick<SRC, NotUnionTypes<SRC, DST>>, '__typename'>]: DST[P] extends true
          ? SRC[P]
          : IsArray<SRC[P], DST[P]>;
      }
  : {
      [P in keyof Pick<SRC, keyof DST>]: DST[P] extends true ? SRC[P] : IsArray<SRC[P], DST[P]>;
    };



export type MapType<SRC, DST> = SRC extends DeepAnify<DST> ? IsInterfaced<SRC, DST> : never;
type InputType<SRC, DST> = IsPayLoad<DST> extends { __alias: infer R }
  ? {
      [P in keyof R]: MapType<SRC, R[P]>;
    } &
      MapType<SRC, Omit<IsPayLoad<DST>, '__alias'>>
  : MapType<SRC, IsPayLoad<DST>>;
type Func<P extends any[], R> = (...args: P) => R;
type AnyFunc = Func<any, any>;
export type ArgsType<F extends AnyFunc> = F extends Func<infer P, any> ? P : never;
export type OperationToGraphQL<V, T> = <Z extends V>(o: Z | V, variables?: Record<string, any>) => Promise<InputType<T, Z>>;
export type SubscriptionToGraphQL<V, T> = <Z extends V>(
  o: Z | V,
  variables?: Record<string, any>,
) => {
  ws: WebSocket;
  on: (fn: (args: InputType<T, Z>) => void) => void;
  off: (e: { data?: InputType<T, Z>; code?: number; reason?: string; message?: string }) => void;
  error: (e: { data?: InputType<T, Z>; message?: string }) => void;
  open: () => void;
};
export type CastToGraphQL<V, T> = (resultOfYourQuery: any) => <Z extends V>(o: Z | V) => InputType<T, Z>;
export type SelectionFunction<V> = <T>(t: T | V) => T;
export type fetchOptions = ArgsType<typeof fetch>;
type websocketOptions = typeof WebSocket extends new (
  ...args: infer R
) => WebSocket
  ? R
  : never;
export type chainOptions =
  | [fetchOptions[0], fetchOptions[1] & {websocket?: websocketOptions}]
  | [fetchOptions[0]];
export type FetchFunction = (
  query: string,
  variables?: Record<string, any>,
) => Promise<any>;
export type SubscriptionFunction = (
  query: string,
  variables?: Record<string, any>,
) => void;
type NotUndefined<T> = T extends undefined ? never : T;
export type ResolverType<F> = NotUndefined<F extends [infer ARGS, any] ? ARGS : undefined>;



export const ZeusSelect = <T>() => ((t: any) => t) as SelectionFunction<T>;

export const ScalarResolver = (scalar: string, value: any) => {
  switch (scalar) {
    case 'String':
      return  `${JSON.stringify(value)}`;
    case 'Int':
      return `${value}`;
    case 'Float':
      return `${value}`;
    case 'Boolean':
      return `${value}`;
    case 'ID':
      return `"${value}"`;
    case 'enum':
      return `${value}`;
    case 'scalar':
      return `${value}`;
    default:
      return false;
  }
};


export const TypesPropsResolver = ({
    value,
    type,
    name,
    key,
    blockArrays
}: {
    value: any;
    type: string;
    name: string;
    key?: string;
    blockArrays?: boolean;
}): string => {
    if (value === null) {
        return `null`;
    }
    let resolvedValue = AllTypesProps[type][name];
    if (key) {
        resolvedValue = resolvedValue[key];
    }
    if (!resolvedValue) {
        throw new Error(`Cannot resolve ${type} ${name}${key ? ` ${key}` : ''}`)
    }
    const typeResolved = resolvedValue.type;
    const isArray = resolvedValue.array;
    const isArrayRequired = resolvedValue.arrayRequired;
    if (typeof value === 'string' && value.startsWith(`ZEUS_VAR$`)) {
        const isRequired = resolvedValue.required ? '!' : '';
        let t = `${typeResolved}`;
        if (isArray) {
          if (isRequired) {
              t = `${t}!`;
          }
          t = `[${t}]`;
          if(isArrayRequired){
            t = `${t}!`;
          }
        }else{
          if (isRequired) {
                t = `${t}!`;
          }
        }
        return `\$${value.split(`ZEUS_VAR$`)[1]}__ZEUS_VAR__${t}`;
    }
    if (isArray && !blockArrays) {
        return `[${value
        .map((v: any) => TypesPropsResolver({ value: v, type, name, key, blockArrays: true }))
        .join(',')}]`;
    }
    const reslovedScalar = ScalarResolver(typeResolved, value);
    if (!reslovedScalar) {
        const resolvedType = AllTypesProps[typeResolved];
        if (typeof resolvedType === 'object') {
        const argsKeys = Object.keys(resolvedType);
        return `{${argsKeys
            .filter((ak) => value[ak] !== undefined)
            .map(
            (ak) => `${ak}:${TypesPropsResolver({ value: value[ak], type: typeResolved, name: ak })}`
            )}}`;
        }
        return ScalarResolver(AllTypesProps[typeResolved], value) as string;
    }
    return reslovedScalar;
};


const isArrayFunction = (
  parent: string[],
  a: any[]
) => {
  const [values, r] = a;
  const [mainKey, key, ...keys] = parent;
  const keyValues = Object.keys(values).filter((k) => typeof values[k] !== 'undefined');

  if (!keys.length) {
      return keyValues.length > 0
        ? `(${keyValues
            .map(
              (v) =>
                `${v}:${TypesPropsResolver({
                  value: values[v],
                  type: mainKey,
                  name: key,
                  key: v
                })}`
            )
            .join(',')})${r ? traverseToSeekArrays(parent, r) : ''}`
        : traverseToSeekArrays(parent, r);
    }

  const [typeResolverKey] = keys.splice(keys.length - 1, 1);
  let valueToResolve = ReturnTypes[mainKey][key];
  for (const k of keys) {
    valueToResolve = ReturnTypes[valueToResolve][k];
  }

  const argumentString =
    keyValues.length > 0
      ? `(${keyValues
          .map(
            (v) =>
              `${v}:${TypesPropsResolver({
                value: values[v],
                type: valueToResolve,
                name: typeResolverKey,
                key: v
              })}`
          )
          .join(',')})${r ? traverseToSeekArrays(parent, r) : ''}`
      : traverseToSeekArrays(parent, r);
  return argumentString;
};


const resolveKV = (k: string, v: boolean | string | { [x: string]: boolean | string }) =>
  typeof v === 'boolean' ? k : typeof v === 'object' ? `${k}{${objectToTree(v)}}` : `${k}${v}`;


const objectToTree = (o: { [x: string]: boolean | string }): string =>
  `{${Object.keys(o).map((k) => `${resolveKV(k, o[k])}`).join(' ')}}`;


const traverseToSeekArrays = (parent: string[], a?: any): string => {
  if (!a) return '';
  if (Object.keys(a).length === 0) {
    return '';
  }
  let b: Record<string, any> = {};
  if (Array.isArray(a)) {
    return isArrayFunction([...parent], a);
  } else {
    if (typeof a === 'object') {
      Object.keys(a)
        .filter((k) => typeof a[k] !== 'undefined')
        .map((k) => {
        if (k === '__alias') {
          Object.keys(a[k]).map((aliasKey) => {
            const aliasOperations = a[k][aliasKey];
            const aliasOperationName = Object.keys(aliasOperations)[0];
            const aliasOperation = aliasOperations[aliasOperationName];
            b[
              `${aliasOperationName}__alias__${aliasKey}: ${aliasOperationName}`
            ] = traverseToSeekArrays([...parent, aliasOperationName], aliasOperation);
          });
        } else {
          b[k] = traverseToSeekArrays([...parent, k], a[k]);
        }
      });
    } else {
      return '';
    }
  }
  return objectToTree(b);
};  


const buildQuery = (type: string, a?: Record<any, any>) => 
  traverseToSeekArrays([type], a);


const inspectVariables = (query: string) => {
  const regex = /\$\b\w*__ZEUS_VAR__\[?[^!^\]^\s^,^\)^\}]*[!]?[\]]?[!]?/g;
  let result;
  const AllVariables: string[] = [];
  while ((result = regex.exec(query))) {
    if (AllVariables.includes(result[0])) {
      continue;
    }
    AllVariables.push(result[0]);
  }
  if (!AllVariables.length) {
    return query;
  }
  let filteredQuery = query;
  AllVariables.forEach((variable) => {
    while (filteredQuery.includes(variable)) {
      filteredQuery = filteredQuery.replace(variable, variable.split('__ZEUS_VAR__')[0]);
    }
  });
  return `(${AllVariables.map((a) => a.split('__ZEUS_VAR__'))
    .map(([variableName, variableType]) => `${variableName}:${variableType}`)
    .join(', ')})${filteredQuery}`;
};


export const queryConstruct = (t: 'query' | 'mutation' | 'subscription', tName: string) => (o: Record<any, any>) =>
  `${t.toLowerCase()}${inspectVariables(buildQuery(tName, o))}`;
  

const fullChainConstruct = (fn: FetchFunction) => (t: 'query' | 'mutation' | 'subscription', tName: string) => (
  o: Record<any, any>,
  variables?: Record<string, any>,
) => fn(queryConstruct(t, tName)(o), variables).then((r:any) => { 
  seekForAliases(r)
  return r
});

export const fullChainConstructor = <F extends FetchFunction, R extends keyof ValueTypes>(
  fn: F,
  operation: 'query' | 'mutation' | 'subscription',
  key: R,
) =>
  ((o, variables) => fullChainConstruct(fn)(operation, key)(o as any, variables)) as OperationToGraphQL<
    ValueTypes[R],
    GraphQLTypes[R]
  >;


const fullSubscriptionConstruct = (fn: SubscriptionFunction) => (
  t: 'query' | 'mutation' | 'subscription',
  tName: string,
) => (o: Record<any, any>, variables?: Record<string, any>) =>
  fn(queryConstruct(t, tName)(o), variables);

export const fullSubscriptionConstructor = <F extends SubscriptionFunction, R extends keyof ValueTypes>(
  fn: F,
  operation: 'query' | 'mutation' | 'subscription',
  key: R,
) =>
  ((o, variables) => fullSubscriptionConstruct(fn)(operation, key)(o as any, variables)) as SubscriptionToGraphQL<
    ValueTypes[R],
    GraphQLTypes[R]
  >;


const seekForAliases = (response: any) => {
  const traverseAlias = (value: any) => {
    if (Array.isArray(value)) {
      value.forEach(seekForAliases);
    } else {
      if (typeof value === 'object') {
        seekForAliases(value);
      }
    }
  };
  if (typeof response === 'object' && response) {
    const keys = Object.keys(response);
    if (keys.length < 1) {
      return;
    }
    keys.forEach((k) => {
      const value = response[k];
      if (k.indexOf('__alias__') !== -1) {
        const [operation, alias] = k.split('__alias__');
        response[alias] = {
          [operation]: value,
        };
        delete response[k];
      }
      traverseAlias(value);
    });
  }
};


export const $ = (t: TemplateStringsArray): any => `ZEUS_VAR$${t.join('')}`;


export const resolverFor = <
  T extends keyof ValueTypes,
  Z extends keyof ValueTypes[T],
  Y extends (
    args: Required<ValueTypes[T]>[Z] extends [infer Input, any] ? Input : any,
    source: any,
  ) => Z extends keyof ModelTypes[T] ? ModelTypes[T][Z] | Promise<ModelTypes[T][Z]> : any
>(
  type: T,
  field: Z,
  fn: Y,
) => fn as (args?: any,source?: any) => any;


const handleFetchResponse = (
  response: Parameters<Extract<Parameters<ReturnType<typeof fetch>['then']>[0], Function>>[0]
): Promise<GraphQLResponse> => {
  if (!response.ok) {
    return new Promise((_, reject) => {
      response.text().then(text => {
        try { reject(JSON.parse(text)); }
        catch (err) { reject(text); }
      }).catch(reject);
    });
  }
  return response.json();
};

export const apiFetch = (options: fetchOptions) => (query: string, variables: Record<string, any> = {}) => {
    let fetchFunction = fetch;
    let queryString = query;
    let fetchOptions = options[1] || {};
    if (fetchOptions.method && fetchOptions.method === 'GET') {
      queryString = encodeURIComponent(query);
      return fetchFunction(`${options[0]}?query=${queryString}`, fetchOptions)
        .then(handleFetchResponse)
        .then((response: GraphQLResponse) => {
          if (response.errors) {
            throw new GraphQLError(response);
          }
          return response.data;
        });
    }
    return fetchFunction(`${options[0]}`, {
      body: JSON.stringify({ query: queryString, variables }),
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      ...fetchOptions
    })
      .then(handleFetchResponse)
      .then((response: GraphQLResponse) => {
        if (response.errors) {
          throw new GraphQLError(response);
        }
        return response.data;
      });
  };
  

export const apiSubscription = (options: chainOptions) => (
    query: string,
    variables: Record<string, any> = {},
  ) => {
    try {
      const queryString = options[0] + '?query=' + encodeURIComponent(query);
      const wsString = queryString.replace('http', 'ws');
      const host = (options.length > 1 && options[1]?.websocket?.[0]) || wsString;
      const webSocketOptions = options[1]?.websocket || [host];
      const ws = new WebSocket(...webSocketOptions);
      return {
        ws,
        on: (e: (args: any) => void) => {
          ws.onmessage = (event:any) => {
            if(event.data){
              const parsed = JSON.parse(event.data)
              const data = parsed.data
              if (data) {
                seekForAliases(data);
              }
              return e(data);
            }
          };
        },
        off: (e: (args: any) => void) => {
          ws.onclose = e;
        },
        error: (e: (args: any) => void) => {
          ws.onerror = e;
        },
        open: (e: () => void) => {
          ws.onopen = e;
        },
      };
    } catch {
      throw new Error('No websockets implemented');
    }
  };


export const Thunder = (fn: FetchFunction, subscriptionFn: SubscriptionFunction) => ({
  query: fullChainConstructor(fn,'query', 'query_root'),
mutation: fullChainConstructor(fn,'mutation', 'mutation_root'),
subscription: fullSubscriptionConstructor(subscriptionFn,'subscription', 'subscription_root')
});

export const Chain = (...options: chainOptions) => ({
  query: fullChainConstructor(apiFetch(options),'query', 'query_root'),
mutation: fullChainConstructor(apiFetch(options),'mutation', 'mutation_root'),
subscription: fullSubscriptionConstructor(apiSubscription(options),'subscription', 'subscription_root')
});
export const Zeus = {
  query: (o:ValueTypes["query_root"]) => queryConstruct('query', 'query_root')(o),
mutation: (o:ValueTypes["mutation_root"]) => queryConstruct('mutation', 'mutation_root')(o),
subscription: (o:ValueTypes["subscription_root"]) => queryConstruct('subscription', 'subscription_root')(o)
};
export const Cast = {
  query: ((o: any) => (_: any) => o) as CastToGraphQL<
  ValueTypes["query_root"],
  GraphQLTypes["query_root"]
>,
mutation: ((o: any) => (_: any) => o) as CastToGraphQL<
  ValueTypes["mutation_root"],
  GraphQLTypes["mutation_root"]
>,
subscription: ((o: any) => (_: any) => o) as CastToGraphQL<
  ValueTypes["subscription_root"],
  GraphQLTypes["subscription_root"]
>
};
export const Selectors = {
  query: ZeusSelect<ValueTypes["query_root"]>(),
mutation: ZeusSelect<ValueTypes["mutation_root"]>(),
subscription: ZeusSelect<ValueTypes["subscription_root"]>()
};
  

export const Gql = Chain('https://club-app-db.herokuapp.com/v1/graphql')