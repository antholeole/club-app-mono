/* eslint-disable */

import { AllTypesProps, ReturnTypes } from './const';
type ZEUS_INTERFACES = never
type ZEUS_UNIONS = never

export type ValueTypes = {
    /** Boolean expression to compare columns of type "Boolean". All fields are combined with logical 'AND'. */
["Boolean_comparison_exp"]: {
	_eq?:boolean,
	_gt?:boolean,
	_gte?:boolean,
	_in?:boolean[],
	_is_null?:boolean,
	_lt?:boolean,
	_lte?:boolean,
	_neq?:boolean,
	_nin?:boolean[]
};
	/** Boolean expression to compare columns of type "String". All fields are combined with logical 'AND'. */
["String_comparison_exp"]: {
	_eq?:string,
	_gt?:string,
	_gte?:string,
	/** does the column match the given case-insensitive pattern */
	_ilike?:string,
	_in?:string[],
	/** does the column match the given POSIX regular expression, case insensitive */
	_iregex?:string,
	_is_null?:boolean,
	/** does the column match the given pattern */
	_like?:string,
	_lt?:string,
	_lte?:string,
	_neq?:string,
	/** does the column NOT match the given case-insensitive pattern */
	_nilike?:string,
	_nin?:string[],
	/** does the column NOT match the given POSIX regular expression, case insensitive */
	_niregex?:string,
	/** does the column NOT match the given pattern */
	_nlike?:string,
	/** does the column NOT match the given POSIX regular expression, case sensitive */
	_nregex?:string,
	/** does the column NOT match the given SQL regular expression */
	_nsimilar?:string,
	/** does the column match the given POSIX regular expression, case sensitive */
	_regex?:string,
	/** does the column match the given SQL regular expression */
	_similar?:string
};
	/** columns and relationships of "group_threads" */
["group_threads"]: AliasType<{
	group_id?:true,
	id?:true,
messages?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages"]],
messages_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages_aggregate"]],
	name?:true,
user_to_threads?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread"]],
user_to_threads_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_aggregate"]],
		__typename?: true
}>;
	/** aggregated selection of "group_threads" */
["group_threads_aggregate"]: AliasType<{
	aggregate?:ValueTypes["group_threads_aggregate_fields"],
	nodes?:ValueTypes["group_threads"],
		__typename?: true
}>;
	/** aggregate fields of "group_threads" */
["group_threads_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["group_threads_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["group_threads_max_fields"],
	min?:ValueTypes["group_threads_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "group_threads" */
["group_threads_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["group_threads_max_order_by"],
	min?:ValueTypes["group_threads_min_order_by"]
};
	/** input type for inserting array relation for remote table "group_threads" */
["group_threads_arr_rel_insert_input"]: {
	data:ValueTypes["group_threads_insert_input"][],
	/** on conflict condition */
	on_conflict?:ValueTypes["group_threads_on_conflict"]
};
	/** Boolean expression to filter rows from the table "group_threads". All fields are combined with a logical 'AND'. */
["group_threads_bool_exp"]: {
	_and?:ValueTypes["group_threads_bool_exp"][],
	_not?:ValueTypes["group_threads_bool_exp"],
	_or?:ValueTypes["group_threads_bool_exp"][],
	group_id?:ValueTypes["uuid_comparison_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	messages?:ValueTypes["messages_bool_exp"],
	name?:ValueTypes["String_comparison_exp"],
	user_to_threads?:ValueTypes["user_to_thread_bool_exp"]
};
	/** unique or primary key constraints on table "group_threads" */
["group_threads_constraint"]:group_threads_constraint;
	/** input type for inserting data into table "group_threads" */
["group_threads_insert_input"]: {
	group_id?:ValueTypes["uuid"],
	id?:ValueTypes["uuid"],
	messages?:ValueTypes["messages_arr_rel_insert_input"],
	name?:string,
	user_to_threads?:ValueTypes["user_to_thread_arr_rel_insert_input"]
};
	/** aggregate max on columns */
["group_threads_max_fields"]: AliasType<{
	group_id?:true,
	id?:true,
	name?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "group_threads" */
["group_threads_max_order_by"]: {
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	name?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["group_threads_min_fields"]: AliasType<{
	group_id?:true,
	id?:true,
	name?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "group_threads" */
["group_threads_min_order_by"]: {
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	name?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "group_threads" */
["group_threads_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["group_threads"],
		__typename?: true
}>;
	/** input type for inserting object relation for remote table "group_threads" */
["group_threads_obj_rel_insert_input"]: {
	data:ValueTypes["group_threads_insert_input"],
	/** on conflict condition */
	on_conflict?:ValueTypes["group_threads_on_conflict"]
};
	/** on conflict condition type for table "group_threads" */
["group_threads_on_conflict"]: {
	constraint:ValueTypes["group_threads_constraint"],
	update_columns:ValueTypes["group_threads_update_column"][],
	where?:ValueTypes["group_threads_bool_exp"]
};
	/** Ordering options when selecting data from "group_threads". */
["group_threads_order_by"]: {
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	messages_aggregate?:ValueTypes["messages_aggregate_order_by"],
	name?:ValueTypes["order_by"],
	user_to_threads_aggregate?:ValueTypes["user_to_thread_aggregate_order_by"]
};
	/** primary key columns input for table: group_threads */
["group_threads_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "group_threads" */
["group_threads_select_column"]:group_threads_select_column;
	/** input type for updating data in table "group_threads" */
["group_threads_set_input"]: {
	group_id?:ValueTypes["uuid"],
	id?:ValueTypes["uuid"],
	name?:string
};
	/** update columns of table "group_threads" */
["group_threads_update_column"]:group_threads_update_column;
	/** columns and relationships of "groups" */
["groups"]: AliasType<{
	group_name?:true,
group_threads?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads"]],
group_threads_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads_aggregate"]],
	id?:true,
user_to_groups?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group"]],
user_to_groups_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_aggregate"]],
		__typename?: true
}>;
	/** aggregated selection of "groups" */
["groups_aggregate"]: AliasType<{
	aggregate?:ValueTypes["groups_aggregate_fields"],
	nodes?:ValueTypes["groups"],
		__typename?: true
}>;
	/** aggregate fields of "groups" */
["groups_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["groups_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["groups_max_fields"],
	min?:ValueTypes["groups_min_fields"],
		__typename?: true
}>;
	/** Boolean expression to filter rows from the table "groups". All fields are combined with a logical 'AND'. */
["groups_bool_exp"]: {
	_and?:ValueTypes["groups_bool_exp"][],
	_not?:ValueTypes["groups_bool_exp"],
	_or?:ValueTypes["groups_bool_exp"][],
	group_name?:ValueTypes["String_comparison_exp"],
	group_threads?:ValueTypes["group_threads_bool_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	user_to_groups?:ValueTypes["user_to_group_bool_exp"]
};
	/** unique or primary key constraints on table "groups" */
["groups_constraint"]:groups_constraint;
	/** input type for inserting data into table "groups" */
["groups_insert_input"]: {
	group_name?:string,
	group_threads?:ValueTypes["group_threads_arr_rel_insert_input"],
	id?:ValueTypes["uuid"],
	user_to_groups?:ValueTypes["user_to_group_arr_rel_insert_input"]
};
	/** aggregate max on columns */
["groups_max_fields"]: AliasType<{
	group_name?:true,
	id?:true,
		__typename?: true
}>;
	/** aggregate min on columns */
["groups_min_fields"]: AliasType<{
	group_name?:true,
	id?:true,
		__typename?: true
}>;
	/** response of any mutation on the table "groups" */
["groups_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["groups"],
		__typename?: true
}>;
	/** input type for inserting object relation for remote table "groups" */
["groups_obj_rel_insert_input"]: {
	data:ValueTypes["groups_insert_input"],
	/** on conflict condition */
	on_conflict?:ValueTypes["groups_on_conflict"]
};
	/** on conflict condition type for table "groups" */
["groups_on_conflict"]: {
	constraint:ValueTypes["groups_constraint"],
	update_columns:ValueTypes["groups_update_column"][],
	where?:ValueTypes["groups_bool_exp"]
};
	/** Ordering options when selecting data from "groups". */
["groups_order_by"]: {
	group_name?:ValueTypes["order_by"],
	group_threads_aggregate?:ValueTypes["group_threads_aggregate_order_by"],
	id?:ValueTypes["order_by"],
	user_to_groups_aggregate?:ValueTypes["user_to_group_aggregate_order_by"]
};
	/** primary key columns input for table: groups */
["groups_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "groups" */
["groups_select_column"]:groups_select_column;
	/** input type for updating data in table "groups" */
["groups_set_input"]: {
	group_name?:string,
	id?:ValueTypes["uuid"]
};
	/** update columns of table "groups" */
["groups_update_column"]:groups_update_column;
	/** columns and relationships of "messages" */
["messages"]: AliasType<{
	created_at?:true,
	deleted?:true,
	edited?:true,
	/** An object relationship */
	group_thread?:ValueTypes["group_threads"],
	id?:true,
	is_image?:true,
	message?:true,
	thread_id?:true,
	/** An object relationship */
	user?:ValueTypes["users"],
	user_sent?:true,
		__typename?: true
}>;
	/** aggregated selection of "messages" */
["messages_aggregate"]: AliasType<{
	aggregate?:ValueTypes["messages_aggregate_fields"],
	nodes?:ValueTypes["messages"],
		__typename?: true
}>;
	/** aggregate fields of "messages" */
["messages_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["messages_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["messages_max_fields"],
	min?:ValueTypes["messages_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "messages" */
["messages_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["messages_max_order_by"],
	min?:ValueTypes["messages_min_order_by"]
};
	/** input type for inserting array relation for remote table "messages" */
["messages_arr_rel_insert_input"]: {
	data:ValueTypes["messages_insert_input"][],
	/** on conflict condition */
	on_conflict?:ValueTypes["messages_on_conflict"]
};
	/** Boolean expression to filter rows from the table "messages". All fields are combined with a logical 'AND'. */
["messages_bool_exp"]: {
	_and?:ValueTypes["messages_bool_exp"][],
	_not?:ValueTypes["messages_bool_exp"],
	_or?:ValueTypes["messages_bool_exp"][],
	created_at?:ValueTypes["timestamptz_comparison_exp"],
	deleted?:ValueTypes["Boolean_comparison_exp"],
	edited?:ValueTypes["Boolean_comparison_exp"],
	group_thread?:ValueTypes["group_threads_bool_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	is_image?:ValueTypes["Boolean_comparison_exp"],
	message?:ValueTypes["String_comparison_exp"],
	thread_id?:ValueTypes["uuid_comparison_exp"],
	user?:ValueTypes["users_bool_exp"],
	user_sent?:ValueTypes["uuid_comparison_exp"]
};
	/** unique or primary key constraints on table "messages" */
["messages_constraint"]:messages_constraint;
	/** input type for inserting data into table "messages" */
["messages_insert_input"]: {
	created_at?:ValueTypes["timestamptz"],
	deleted?:boolean,
	edited?:boolean,
	group_thread?:ValueTypes["group_threads_obj_rel_insert_input"],
	id?:ValueTypes["uuid"],
	is_image?:boolean,
	message?:string,
	thread_id?:ValueTypes["uuid"],
	user?:ValueTypes["users_obj_rel_insert_input"],
	user_sent?:ValueTypes["uuid"]
};
	/** aggregate max on columns */
["messages_max_fields"]: AliasType<{
	created_at?:true,
	id?:true,
	message?:true,
	thread_id?:true,
	user_sent?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "messages" */
["messages_max_order_by"]: {
	created_at?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	message?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user_sent?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["messages_min_fields"]: AliasType<{
	created_at?:true,
	id?:true,
	message?:true,
	thread_id?:true,
	user_sent?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "messages" */
["messages_min_order_by"]: {
	created_at?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	message?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user_sent?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "messages" */
["messages_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["messages"],
		__typename?: true
}>;
	/** on conflict condition type for table "messages" */
["messages_on_conflict"]: {
	constraint:ValueTypes["messages_constraint"],
	update_columns:ValueTypes["messages_update_column"][],
	where?:ValueTypes["messages_bool_exp"]
};
	/** Ordering options when selecting data from "messages". */
["messages_order_by"]: {
	created_at?:ValueTypes["order_by"],
	deleted?:ValueTypes["order_by"],
	edited?:ValueTypes["order_by"],
	group_thread?:ValueTypes["group_threads_order_by"],
	id?:ValueTypes["order_by"],
	is_image?:ValueTypes["order_by"],
	message?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user?:ValueTypes["users_order_by"],
	user_sent?:ValueTypes["order_by"]
};
	/** primary key columns input for table: messages */
["messages_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "messages" */
["messages_select_column"]:messages_select_column;
	/** input type for updating data in table "messages" */
["messages_set_input"]: {
	created_at?:ValueTypes["timestamptz"],
	deleted?:boolean,
	edited?:boolean,
	id?:ValueTypes["uuid"],
	is_image?:boolean,
	message?:string,
	thread_id?:ValueTypes["uuid"],
	user_sent?:ValueTypes["uuid"]
};
	/** update columns of table "messages" */
["messages_update_column"]:messages_update_column;
	/** mutation root */
["mutation_root"]: AliasType<{
delete_group_threads?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads_mutation_response"]],
delete_group_threads_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["group_threads"]],
delete_groups?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["groups_bool_exp"]},ValueTypes["groups_mutation_response"]],
delete_groups_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["groups"]],
delete_messages?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["messages_bool_exp"]},ValueTypes["messages_mutation_response"]],
delete_messages_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["messages"]],
delete_user_to_group?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_mutation_response"]],
delete_user_to_group_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_group"]],
delete_user_to_thread?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_mutation_response"]],
delete_user_to_thread_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_thread"]],
delete_users?: [{	/** filter the rows which have to be deleted */
	where:ValueTypes["users_bool_exp"]},ValueTypes["users_mutation_response"]],
delete_users_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["users"]],
insert_group_threads?: [{	/** the rows to be inserted */
	objects:ValueTypes["group_threads_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["group_threads_on_conflict"]},ValueTypes["group_threads_mutation_response"]],
insert_group_threads_one?: [{	/** the row to be inserted */
	object:ValueTypes["group_threads_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["group_threads_on_conflict"]},ValueTypes["group_threads"]],
insert_groups?: [{	/** the rows to be inserted */
	objects:ValueTypes["groups_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["groups_on_conflict"]},ValueTypes["groups_mutation_response"]],
insert_groups_one?: [{	/** the row to be inserted */
	object:ValueTypes["groups_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["groups_on_conflict"]},ValueTypes["groups"]],
insert_messages?: [{	/** the rows to be inserted */
	objects:ValueTypes["messages_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["messages_on_conflict"]},ValueTypes["messages_mutation_response"]],
insert_messages_one?: [{	/** the row to be inserted */
	object:ValueTypes["messages_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["messages_on_conflict"]},ValueTypes["messages"]],
insert_user_to_group?: [{	/** the rows to be inserted */
	objects:ValueTypes["user_to_group_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_group_on_conflict"]},ValueTypes["user_to_group_mutation_response"]],
insert_user_to_group_one?: [{	/** the row to be inserted */
	object:ValueTypes["user_to_group_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_group_on_conflict"]},ValueTypes["user_to_group"]],
insert_user_to_thread?: [{	/** the rows to be inserted */
	objects:ValueTypes["user_to_thread_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_thread_on_conflict"]},ValueTypes["user_to_thread_mutation_response"]],
insert_user_to_thread_one?: [{	/** the row to be inserted */
	object:ValueTypes["user_to_thread_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_thread_on_conflict"]},ValueTypes["user_to_thread"]],
insert_users?: [{	/** the rows to be inserted */
	objects:ValueTypes["users_insert_input"][],	/** on conflict condition */
	on_conflict?:ValueTypes["users_on_conflict"]},ValueTypes["users_mutation_response"]],
insert_users_one?: [{	/** the row to be inserted */
	object:ValueTypes["users_insert_input"],	/** on conflict condition */
	on_conflict?:ValueTypes["users_on_conflict"]},ValueTypes["users"]],
update_group_threads?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["group_threads_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads_mutation_response"]],
update_group_threads_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["group_threads_set_input"],	pk_columns:ValueTypes["group_threads_pk_columns_input"]},ValueTypes["group_threads"]],
update_groups?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["groups_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["groups_bool_exp"]},ValueTypes["groups_mutation_response"]],
update_groups_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["groups_set_input"],	pk_columns:ValueTypes["groups_pk_columns_input"]},ValueTypes["groups"]],
update_messages?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["messages_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["messages_bool_exp"]},ValueTypes["messages_mutation_response"]],
update_messages_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["messages_set_input"],	pk_columns:ValueTypes["messages_pk_columns_input"]},ValueTypes["messages"]],
update_user_to_group?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["user_to_group_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_mutation_response"]],
update_user_to_group_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["user_to_group_set_input"],	pk_columns:ValueTypes["user_to_group_pk_columns_input"]},ValueTypes["user_to_group"]],
update_user_to_thread?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["user_to_thread_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_mutation_response"]],
update_user_to_thread_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["user_to_thread_set_input"],	pk_columns:ValueTypes["user_to_thread_pk_columns_input"]},ValueTypes["user_to_thread"]],
update_users?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["users_set_input"],	/** filter the rows which have to be updated */
	where:ValueTypes["users_bool_exp"]},ValueTypes["users_mutation_response"]],
update_users_by_pk?: [{	/** sets the columns of the filtered rows to the given values */
	_set?:ValueTypes["users_set_input"],	pk_columns:ValueTypes["users_pk_columns_input"]},ValueTypes["users"]],
		__typename?: true
}>;
	/** column ordering options */
["order_by"]:order_by;
	["query_root"]: AliasType<{
group_threads?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads"]],
group_threads_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads_aggregate"]],
group_threads_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["group_threads"]],
groups?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["groups_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["groups_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["groups_bool_exp"]},ValueTypes["groups"]],
groups_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["groups_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["groups_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["groups_bool_exp"]},ValueTypes["groups_aggregate"]],
groups_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["groups"]],
messages?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages"]],
messages_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages_aggregate"]],
messages_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["messages"]],
user_to_group?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group"]],
user_to_group_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_aggregate"]],
user_to_group_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_group"]],
user_to_thread?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread"]],
user_to_thread_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_aggregate"]],
user_to_thread_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_thread"]],
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
	["subscription_root"]: AliasType<{
group_threads?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads"]],
group_threads_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["group_threads_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["group_threads_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["group_threads_bool_exp"]},ValueTypes["group_threads_aggregate"]],
group_threads_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["group_threads"]],
groups?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["groups_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["groups_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["groups_bool_exp"]},ValueTypes["groups"]],
groups_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["groups_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["groups_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["groups_bool_exp"]},ValueTypes["groups_aggregate"]],
groups_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["groups"]],
messages?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages"]],
messages_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages_aggregate"]],
messages_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["messages"]],
user_to_group?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group"]],
user_to_group_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_aggregate"]],
user_to_group_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_group"]],
user_to_thread?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread"]],
user_to_thread_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_aggregate"]],
user_to_thread_by_pk?: [{	id:ValueTypes["uuid"]},ValueTypes["user_to_thread"]],
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
	["timestamptz"]:unknown;
	/** Boolean expression to compare columns of type "timestamptz". All fields are combined with logical 'AND'. */
["timestamptz_comparison_exp"]: {
	_eq?:ValueTypes["timestamptz"],
	_gt?:ValueTypes["timestamptz"],
	_gte?:ValueTypes["timestamptz"],
	_in?:ValueTypes["timestamptz"][],
	_is_null?:boolean,
	_lt?:ValueTypes["timestamptz"],
	_lte?:ValueTypes["timestamptz"],
	_neq?:ValueTypes["timestamptz"],
	_nin?:ValueTypes["timestamptz"][]
};
	/** columns and relationships of "user_to_group" */
["user_to_group"]: AliasType<{
	admin?:true,
	/** An object relationship */
	group?:ValueTypes["groups"],
	group_id?:true,
	id?:true,
	/** An object relationship */
	user?:ValueTypes["users"],
	user_id?:true,
		__typename?: true
}>;
	/** aggregated selection of "user_to_group" */
["user_to_group_aggregate"]: AliasType<{
	aggregate?:ValueTypes["user_to_group_aggregate_fields"],
	nodes?:ValueTypes["user_to_group"],
		__typename?: true
}>;
	/** aggregate fields of "user_to_group" */
["user_to_group_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["user_to_group_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["user_to_group_max_fields"],
	min?:ValueTypes["user_to_group_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "user_to_group" */
["user_to_group_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["user_to_group_max_order_by"],
	min?:ValueTypes["user_to_group_min_order_by"]
};
	/** input type for inserting array relation for remote table "user_to_group" */
["user_to_group_arr_rel_insert_input"]: {
	data:ValueTypes["user_to_group_insert_input"][],
	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_group_on_conflict"]
};
	/** Boolean expression to filter rows from the table "user_to_group". All fields are combined with a logical 'AND'. */
["user_to_group_bool_exp"]: {
	_and?:ValueTypes["user_to_group_bool_exp"][],
	_not?:ValueTypes["user_to_group_bool_exp"],
	_or?:ValueTypes["user_to_group_bool_exp"][],
	admin?:ValueTypes["Boolean_comparison_exp"],
	group?:ValueTypes["groups_bool_exp"],
	group_id?:ValueTypes["uuid_comparison_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	user?:ValueTypes["users_bool_exp"],
	user_id?:ValueTypes["uuid_comparison_exp"]
};
	/** unique or primary key constraints on table "user_to_group" */
["user_to_group_constraint"]:user_to_group_constraint;
	/** input type for inserting data into table "user_to_group" */
["user_to_group_insert_input"]: {
	admin?:boolean,
	group?:ValueTypes["groups_obj_rel_insert_input"],
	group_id?:ValueTypes["uuid"],
	id?:ValueTypes["uuid"],
	user?:ValueTypes["users_obj_rel_insert_input"],
	user_id?:ValueTypes["uuid"]
};
	/** aggregate max on columns */
["user_to_group_max_fields"]: AliasType<{
	group_id?:true,
	id?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "user_to_group" */
["user_to_group_max_order_by"]: {
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["user_to_group_min_fields"]: AliasType<{
	group_id?:true,
	id?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "user_to_group" */
["user_to_group_min_order_by"]: {
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "user_to_group" */
["user_to_group_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["user_to_group"],
		__typename?: true
}>;
	/** on conflict condition type for table "user_to_group" */
["user_to_group_on_conflict"]: {
	constraint:ValueTypes["user_to_group_constraint"],
	update_columns:ValueTypes["user_to_group_update_column"][],
	where?:ValueTypes["user_to_group_bool_exp"]
};
	/** Ordering options when selecting data from "user_to_group". */
["user_to_group_order_by"]: {
	admin?:ValueTypes["order_by"],
	group?:ValueTypes["groups_order_by"],
	group_id?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	user?:ValueTypes["users_order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** primary key columns input for table: user_to_group */
["user_to_group_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "user_to_group" */
["user_to_group_select_column"]:user_to_group_select_column;
	/** input type for updating data in table "user_to_group" */
["user_to_group_set_input"]: {
	admin?:boolean,
	group_id?:ValueTypes["uuid"],
	id?:ValueTypes["uuid"],
	user_id?:ValueTypes["uuid"]
};
	/** update columns of table "user_to_group" */
["user_to_group_update_column"]:user_to_group_update_column;
	/** columns and relationships of "user_to_thread" */
["user_to_thread"]: AliasType<{
	/** An object relationship */
	group_thread?:ValueTypes["group_threads"],
	id?:true,
	thread_id?:true,
	/** An object relationship */
	user?:ValueTypes["users"],
	user_id?:true,
		__typename?: true
}>;
	/** aggregated selection of "user_to_thread" */
["user_to_thread_aggregate"]: AliasType<{
	aggregate?:ValueTypes["user_to_thread_aggregate_fields"],
	nodes?:ValueTypes["user_to_thread"],
		__typename?: true
}>;
	/** aggregate fields of "user_to_thread" */
["user_to_thread_aggregate_fields"]: AliasType<{
count?: [{	columns?:ValueTypes["user_to_thread_select_column"][],	distinct?:boolean},true],
	max?:ValueTypes["user_to_thread_max_fields"],
	min?:ValueTypes["user_to_thread_min_fields"],
		__typename?: true
}>;
	/** order by aggregate values of table "user_to_thread" */
["user_to_thread_aggregate_order_by"]: {
	count?:ValueTypes["order_by"],
	max?:ValueTypes["user_to_thread_max_order_by"],
	min?:ValueTypes["user_to_thread_min_order_by"]
};
	/** input type for inserting array relation for remote table "user_to_thread" */
["user_to_thread_arr_rel_insert_input"]: {
	data:ValueTypes["user_to_thread_insert_input"][],
	/** on conflict condition */
	on_conflict?:ValueTypes["user_to_thread_on_conflict"]
};
	/** Boolean expression to filter rows from the table "user_to_thread". All fields are combined with a logical 'AND'. */
["user_to_thread_bool_exp"]: {
	_and?:ValueTypes["user_to_thread_bool_exp"][],
	_not?:ValueTypes["user_to_thread_bool_exp"],
	_or?:ValueTypes["user_to_thread_bool_exp"][],
	group_thread?:ValueTypes["group_threads_bool_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	thread_id?:ValueTypes["uuid_comparison_exp"],
	user?:ValueTypes["users_bool_exp"],
	user_id?:ValueTypes["uuid_comparison_exp"]
};
	/** unique or primary key constraints on table "user_to_thread" */
["user_to_thread_constraint"]:user_to_thread_constraint;
	/** input type for inserting data into table "user_to_thread" */
["user_to_thread_insert_input"]: {
	group_thread?:ValueTypes["group_threads_obj_rel_insert_input"],
	id?:ValueTypes["uuid"],
	thread_id?:ValueTypes["uuid"],
	user?:ValueTypes["users_obj_rel_insert_input"],
	user_id?:ValueTypes["uuid"]
};
	/** aggregate max on columns */
["user_to_thread_max_fields"]: AliasType<{
	id?:true,
	thread_id?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by max() on columns of table "user_to_thread" */
["user_to_thread_max_order_by"]: {
	id?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** aggregate min on columns */
["user_to_thread_min_fields"]: AliasType<{
	id?:true,
	thread_id?:true,
	user_id?:true,
		__typename?: true
}>;
	/** order by min() on columns of table "user_to_thread" */
["user_to_thread_min_order_by"]: {
	id?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** response of any mutation on the table "user_to_thread" */
["user_to_thread_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["user_to_thread"],
		__typename?: true
}>;
	/** on conflict condition type for table "user_to_thread" */
["user_to_thread_on_conflict"]: {
	constraint:ValueTypes["user_to_thread_constraint"],
	update_columns:ValueTypes["user_to_thread_update_column"][],
	where?:ValueTypes["user_to_thread_bool_exp"]
};
	/** Ordering options when selecting data from "user_to_thread". */
["user_to_thread_order_by"]: {
	group_thread?:ValueTypes["group_threads_order_by"],
	id?:ValueTypes["order_by"],
	thread_id?:ValueTypes["order_by"],
	user?:ValueTypes["users_order_by"],
	user_id?:ValueTypes["order_by"]
};
	/** primary key columns input for table: user_to_thread */
["user_to_thread_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "user_to_thread" */
["user_to_thread_select_column"]:user_to_thread_select_column;
	/** input type for updating data in table "user_to_thread" */
["user_to_thread_set_input"]: {
	id?:ValueTypes["uuid"],
	thread_id?:ValueTypes["uuid"],
	user_id?:ValueTypes["uuid"]
};
	/** update columns of table "user_to_thread" */
["user_to_thread_update_column"]:user_to_thread_update_column;
	/** columns and relationships of "users" */
["users"]: AliasType<{
	email?:true,
	id?:true,
messages?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages"]],
messages_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["messages_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["messages_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["messages_bool_exp"]},ValueTypes["messages_aggregate"]],
	name?:true,
	profile_picture?:true,
	socket_id?:true,
	sub?:true,
user_to_groups?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group"]],
user_to_groups_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_group_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_group_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_group_bool_exp"]},ValueTypes["user_to_group_aggregate"]],
user_to_threads?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread"]],
user_to_threads_aggregate?: [{	/** distinct select on columns */
	distinct_on?:ValueTypes["user_to_thread_select_column"][],	/** limit the number of rows returned */
	limit?:number,	/** skip the first n rows. Use only with order_by */
	offset?:number,	/** sort the rows by one or more columns */
	order_by?:ValueTypes["user_to_thread_order_by"][],	/** filter the rows returned */
	where?:ValueTypes["user_to_thread_bool_exp"]},ValueTypes["user_to_thread_aggregate"]],
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
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: {
	_and?:ValueTypes["users_bool_exp"][],
	_not?:ValueTypes["users_bool_exp"],
	_or?:ValueTypes["users_bool_exp"][],
	email?:ValueTypes["String_comparison_exp"],
	id?:ValueTypes["uuid_comparison_exp"],
	messages?:ValueTypes["messages_bool_exp"],
	name?:ValueTypes["String_comparison_exp"],
	profile_picture?:ValueTypes["String_comparison_exp"],
	socket_id?:ValueTypes["String_comparison_exp"],
	sub?:ValueTypes["String_comparison_exp"],
	user_to_groups?:ValueTypes["user_to_group_bool_exp"],
	user_to_threads?:ValueTypes["user_to_thread_bool_exp"]
};
	/** unique or primary key constraints on table "users" */
["users_constraint"]:users_constraint;
	/** input type for inserting data into table "users" */
["users_insert_input"]: {
	email?:string,
	id?:ValueTypes["uuid"],
	messages?:ValueTypes["messages_arr_rel_insert_input"],
	name?:string,
	profile_picture?:string,
	socket_id?:string,
	sub?:string,
	user_to_groups?:ValueTypes["user_to_group_arr_rel_insert_input"],
	user_to_threads?:ValueTypes["user_to_thread_arr_rel_insert_input"]
};
	/** aggregate max on columns */
["users_max_fields"]: AliasType<{
	email?:true,
	id?:true,
	name?:true,
	profile_picture?:true,
	socket_id?:true,
	sub?:true,
		__typename?: true
}>;
	/** aggregate min on columns */
["users_min_fields"]: AliasType<{
	email?:true,
	id?:true,
	name?:true,
	profile_picture?:true,
	socket_id?:true,
	sub?:true,
		__typename?: true
}>;
	/** response of any mutation on the table "users" */
["users_mutation_response"]: AliasType<{
	/** number of rows affected by the mutation */
	affected_rows?:true,
	/** data from the rows affected by the mutation */
	returning?:ValueTypes["users"],
		__typename?: true
}>;
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: {
	data:ValueTypes["users_insert_input"],
	/** on conflict condition */
	on_conflict?:ValueTypes["users_on_conflict"]
};
	/** on conflict condition type for table "users" */
["users_on_conflict"]: {
	constraint:ValueTypes["users_constraint"],
	update_columns:ValueTypes["users_update_column"][],
	where?:ValueTypes["users_bool_exp"]
};
	/** Ordering options when selecting data from "users". */
["users_order_by"]: {
	email?:ValueTypes["order_by"],
	id?:ValueTypes["order_by"],
	messages_aggregate?:ValueTypes["messages_aggregate_order_by"],
	name?:ValueTypes["order_by"],
	profile_picture?:ValueTypes["order_by"],
	socket_id?:ValueTypes["order_by"],
	sub?:ValueTypes["order_by"],
	user_to_groups_aggregate?:ValueTypes["user_to_group_aggregate_order_by"],
	user_to_threads_aggregate?:ValueTypes["user_to_thread_aggregate_order_by"]
};
	/** primary key columns input for table: users */
["users_pk_columns_input"]: {
	id:ValueTypes["uuid"]
};
	/** select columns of table "users" */
["users_select_column"]:users_select_column;
	/** input type for updating data in table "users" */
["users_set_input"]: {
	email?:string,
	id?:ValueTypes["uuid"],
	name?:string,
	profile_picture?:string,
	socket_id?:string,
	sub?:string
};
	/** update columns of table "users" */
["users_update_column"]:users_update_column;
	["uuid"]:unknown;
	/** Boolean expression to compare columns of type "uuid". All fields are combined with logical 'AND'. */
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
    /** Boolean expression to compare columns of type "Boolean". All fields are combined with logical 'AND'. */
["Boolean_comparison_exp"]: GraphQLTypes["Boolean_comparison_exp"];
	/** Boolean expression to compare columns of type "String". All fields are combined with logical 'AND'. */
["String_comparison_exp"]: GraphQLTypes["String_comparison_exp"];
	/** columns and relationships of "group_threads" */
["group_threads"]: {
		group_id:ModelTypes["uuid"],
	id:ModelTypes["uuid"],
	/** An array relationship */
	messages:ModelTypes["messages"][],
	/** An aggregate relationship */
	messages_aggregate:ModelTypes["messages_aggregate"],
	name:string,
	/** An array relationship */
	user_to_threads:ModelTypes["user_to_thread"][],
	/** An aggregate relationship */
	user_to_threads_aggregate:ModelTypes["user_to_thread_aggregate"]
};
	/** aggregated selection of "group_threads" */
["group_threads_aggregate"]: {
		aggregate?:ModelTypes["group_threads_aggregate_fields"],
	nodes:ModelTypes["group_threads"][]
};
	/** aggregate fields of "group_threads" */
["group_threads_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["group_threads_max_fields"],
	min?:ModelTypes["group_threads_min_fields"]
};
	/** order by aggregate values of table "group_threads" */
["group_threads_aggregate_order_by"]: GraphQLTypes["group_threads_aggregate_order_by"];
	/** input type for inserting array relation for remote table "group_threads" */
["group_threads_arr_rel_insert_input"]: GraphQLTypes["group_threads_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "group_threads". All fields are combined with a logical 'AND'. */
["group_threads_bool_exp"]: GraphQLTypes["group_threads_bool_exp"];
	/** unique or primary key constraints on table "group_threads" */
["group_threads_constraint"]: GraphQLTypes["group_threads_constraint"];
	/** input type for inserting data into table "group_threads" */
["group_threads_insert_input"]: GraphQLTypes["group_threads_insert_input"];
	/** aggregate max on columns */
["group_threads_max_fields"]: {
		group_id?:ModelTypes["uuid"],
	id?:ModelTypes["uuid"],
	name?:string
};
	/** order by max() on columns of table "group_threads" */
["group_threads_max_order_by"]: GraphQLTypes["group_threads_max_order_by"];
	/** aggregate min on columns */
["group_threads_min_fields"]: {
		group_id?:ModelTypes["uuid"],
	id?:ModelTypes["uuid"],
	name?:string
};
	/** order by min() on columns of table "group_threads" */
["group_threads_min_order_by"]: GraphQLTypes["group_threads_min_order_by"];
	/** response of any mutation on the table "group_threads" */
["group_threads_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["group_threads"][]
};
	/** input type for inserting object relation for remote table "group_threads" */
["group_threads_obj_rel_insert_input"]: GraphQLTypes["group_threads_obj_rel_insert_input"];
	/** on conflict condition type for table "group_threads" */
["group_threads_on_conflict"]: GraphQLTypes["group_threads_on_conflict"];
	/** Ordering options when selecting data from "group_threads". */
["group_threads_order_by"]: GraphQLTypes["group_threads_order_by"];
	/** primary key columns input for table: group_threads */
["group_threads_pk_columns_input"]: GraphQLTypes["group_threads_pk_columns_input"];
	/** select columns of table "group_threads" */
["group_threads_select_column"]: GraphQLTypes["group_threads_select_column"];
	/** input type for updating data in table "group_threads" */
["group_threads_set_input"]: GraphQLTypes["group_threads_set_input"];
	/** update columns of table "group_threads" */
["group_threads_update_column"]: GraphQLTypes["group_threads_update_column"];
	/** columns and relationships of "groups" */
["groups"]: {
		group_name:string,
	/** An array relationship */
	group_threads:ModelTypes["group_threads"][],
	/** An aggregate relationship */
	group_threads_aggregate:ModelTypes["group_threads_aggregate"],
	id:ModelTypes["uuid"],
	/** An array relationship */
	user_to_groups:ModelTypes["user_to_group"][],
	/** An aggregate relationship */
	user_to_groups_aggregate:ModelTypes["user_to_group_aggregate"]
};
	/** aggregated selection of "groups" */
["groups_aggregate"]: {
		aggregate?:ModelTypes["groups_aggregate_fields"],
	nodes:ModelTypes["groups"][]
};
	/** aggregate fields of "groups" */
["groups_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["groups_max_fields"],
	min?:ModelTypes["groups_min_fields"]
};
	/** Boolean expression to filter rows from the table "groups". All fields are combined with a logical 'AND'. */
["groups_bool_exp"]: GraphQLTypes["groups_bool_exp"];
	/** unique or primary key constraints on table "groups" */
["groups_constraint"]: GraphQLTypes["groups_constraint"];
	/** input type for inserting data into table "groups" */
["groups_insert_input"]: GraphQLTypes["groups_insert_input"];
	/** aggregate max on columns */
["groups_max_fields"]: {
		group_name?:string,
	id?:ModelTypes["uuid"]
};
	/** aggregate min on columns */
["groups_min_fields"]: {
		group_name?:string,
	id?:ModelTypes["uuid"]
};
	/** response of any mutation on the table "groups" */
["groups_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["groups"][]
};
	/** input type for inserting object relation for remote table "groups" */
["groups_obj_rel_insert_input"]: GraphQLTypes["groups_obj_rel_insert_input"];
	/** on conflict condition type for table "groups" */
["groups_on_conflict"]: GraphQLTypes["groups_on_conflict"];
	/** Ordering options when selecting data from "groups". */
["groups_order_by"]: GraphQLTypes["groups_order_by"];
	/** primary key columns input for table: groups */
["groups_pk_columns_input"]: GraphQLTypes["groups_pk_columns_input"];
	/** select columns of table "groups" */
["groups_select_column"]: GraphQLTypes["groups_select_column"];
	/** input type for updating data in table "groups" */
["groups_set_input"]: GraphQLTypes["groups_set_input"];
	/** update columns of table "groups" */
["groups_update_column"]: GraphQLTypes["groups_update_column"];
	/** columns and relationships of "messages" */
["messages"]: {
		created_at:ModelTypes["timestamptz"],
	deleted:boolean,
	edited:boolean,
	/** An object relationship */
	group_thread:ModelTypes["group_threads"],
	id:ModelTypes["uuid"],
	is_image:boolean,
	message:string,
	thread_id:ModelTypes["uuid"],
	/** An object relationship */
	user:ModelTypes["users"],
	user_sent:ModelTypes["uuid"]
};
	/** aggregated selection of "messages" */
["messages_aggregate"]: {
		aggregate?:ModelTypes["messages_aggregate_fields"],
	nodes:ModelTypes["messages"][]
};
	/** aggregate fields of "messages" */
["messages_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["messages_max_fields"],
	min?:ModelTypes["messages_min_fields"]
};
	/** order by aggregate values of table "messages" */
["messages_aggregate_order_by"]: GraphQLTypes["messages_aggregate_order_by"];
	/** input type for inserting array relation for remote table "messages" */
["messages_arr_rel_insert_input"]: GraphQLTypes["messages_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "messages". All fields are combined with a logical 'AND'. */
["messages_bool_exp"]: GraphQLTypes["messages_bool_exp"];
	/** unique or primary key constraints on table "messages" */
["messages_constraint"]: GraphQLTypes["messages_constraint"];
	/** input type for inserting data into table "messages" */
["messages_insert_input"]: GraphQLTypes["messages_insert_input"];
	/** aggregate max on columns */
["messages_max_fields"]: {
		created_at?:ModelTypes["timestamptz"],
	id?:ModelTypes["uuid"],
	message?:string,
	thread_id?:ModelTypes["uuid"],
	user_sent?:ModelTypes["uuid"]
};
	/** order by max() on columns of table "messages" */
["messages_max_order_by"]: GraphQLTypes["messages_max_order_by"];
	/** aggregate min on columns */
["messages_min_fields"]: {
		created_at?:ModelTypes["timestamptz"],
	id?:ModelTypes["uuid"],
	message?:string,
	thread_id?:ModelTypes["uuid"],
	user_sent?:ModelTypes["uuid"]
};
	/** order by min() on columns of table "messages" */
["messages_min_order_by"]: GraphQLTypes["messages_min_order_by"];
	/** response of any mutation on the table "messages" */
["messages_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["messages"][]
};
	/** on conflict condition type for table "messages" */
["messages_on_conflict"]: GraphQLTypes["messages_on_conflict"];
	/** Ordering options when selecting data from "messages". */
["messages_order_by"]: GraphQLTypes["messages_order_by"];
	/** primary key columns input for table: messages */
["messages_pk_columns_input"]: GraphQLTypes["messages_pk_columns_input"];
	/** select columns of table "messages" */
["messages_select_column"]: GraphQLTypes["messages_select_column"];
	/** input type for updating data in table "messages" */
["messages_set_input"]: GraphQLTypes["messages_set_input"];
	/** update columns of table "messages" */
["messages_update_column"]: GraphQLTypes["messages_update_column"];
	/** mutation root */
["mutation_root"]: {
		/** delete data from the table: "group_threads" */
	delete_group_threads?:ModelTypes["group_threads_mutation_response"],
	/** delete single row from the table: "group_threads" */
	delete_group_threads_by_pk?:ModelTypes["group_threads"],
	/** delete data from the table: "groups" */
	delete_groups?:ModelTypes["groups_mutation_response"],
	/** delete single row from the table: "groups" */
	delete_groups_by_pk?:ModelTypes["groups"],
	/** delete data from the table: "messages" */
	delete_messages?:ModelTypes["messages_mutation_response"],
	/** delete single row from the table: "messages" */
	delete_messages_by_pk?:ModelTypes["messages"],
	/** delete data from the table: "user_to_group" */
	delete_user_to_group?:ModelTypes["user_to_group_mutation_response"],
	/** delete single row from the table: "user_to_group" */
	delete_user_to_group_by_pk?:ModelTypes["user_to_group"],
	/** delete data from the table: "user_to_thread" */
	delete_user_to_thread?:ModelTypes["user_to_thread_mutation_response"],
	/** delete single row from the table: "user_to_thread" */
	delete_user_to_thread_by_pk?:ModelTypes["user_to_thread"],
	/** delete data from the table: "users" */
	delete_users?:ModelTypes["users_mutation_response"],
	/** delete single row from the table: "users" */
	delete_users_by_pk?:ModelTypes["users"],
	/** insert data into the table: "group_threads" */
	insert_group_threads?:ModelTypes["group_threads_mutation_response"],
	/** insert a single row into the table: "group_threads" */
	insert_group_threads_one?:ModelTypes["group_threads"],
	/** insert data into the table: "groups" */
	insert_groups?:ModelTypes["groups_mutation_response"],
	/** insert a single row into the table: "groups" */
	insert_groups_one?:ModelTypes["groups"],
	/** insert data into the table: "messages" */
	insert_messages?:ModelTypes["messages_mutation_response"],
	/** insert a single row into the table: "messages" */
	insert_messages_one?:ModelTypes["messages"],
	/** insert data into the table: "user_to_group" */
	insert_user_to_group?:ModelTypes["user_to_group_mutation_response"],
	/** insert a single row into the table: "user_to_group" */
	insert_user_to_group_one?:ModelTypes["user_to_group"],
	/** insert data into the table: "user_to_thread" */
	insert_user_to_thread?:ModelTypes["user_to_thread_mutation_response"],
	/** insert a single row into the table: "user_to_thread" */
	insert_user_to_thread_one?:ModelTypes["user_to_thread"],
	/** insert data into the table: "users" */
	insert_users?:ModelTypes["users_mutation_response"],
	/** insert a single row into the table: "users" */
	insert_users_one?:ModelTypes["users"],
	/** update data of the table: "group_threads" */
	update_group_threads?:ModelTypes["group_threads_mutation_response"],
	/** update single row of the table: "group_threads" */
	update_group_threads_by_pk?:ModelTypes["group_threads"],
	/** update data of the table: "groups" */
	update_groups?:ModelTypes["groups_mutation_response"],
	/** update single row of the table: "groups" */
	update_groups_by_pk?:ModelTypes["groups"],
	/** update data of the table: "messages" */
	update_messages?:ModelTypes["messages_mutation_response"],
	/** update single row of the table: "messages" */
	update_messages_by_pk?:ModelTypes["messages"],
	/** update data of the table: "user_to_group" */
	update_user_to_group?:ModelTypes["user_to_group_mutation_response"],
	/** update single row of the table: "user_to_group" */
	update_user_to_group_by_pk?:ModelTypes["user_to_group"],
	/** update data of the table: "user_to_thread" */
	update_user_to_thread?:ModelTypes["user_to_thread_mutation_response"],
	/** update single row of the table: "user_to_thread" */
	update_user_to_thread_by_pk?:ModelTypes["user_to_thread"],
	/** update data of the table: "users" */
	update_users?:ModelTypes["users_mutation_response"],
	/** update single row of the table: "users" */
	update_users_by_pk?:ModelTypes["users"]
};
	/** column ordering options */
["order_by"]: GraphQLTypes["order_by"];
	["query_root"]: {
		/** An array relationship */
	group_threads:ModelTypes["group_threads"][],
	/** An aggregate relationship */
	group_threads_aggregate:ModelTypes["group_threads_aggregate"],
	/** fetch data from the table: "group_threads" using primary key columns */
	group_threads_by_pk?:ModelTypes["group_threads"],
	/** fetch data from the table: "groups" */
	groups:ModelTypes["groups"][],
	/** fetch aggregated fields from the table: "groups" */
	groups_aggregate:ModelTypes["groups_aggregate"],
	/** fetch data from the table: "groups" using primary key columns */
	groups_by_pk?:ModelTypes["groups"],
	/** An array relationship */
	messages:ModelTypes["messages"][],
	/** An aggregate relationship */
	messages_aggregate:ModelTypes["messages_aggregate"],
	/** fetch data from the table: "messages" using primary key columns */
	messages_by_pk?:ModelTypes["messages"],
	/** fetch data from the table: "user_to_group" */
	user_to_group:ModelTypes["user_to_group"][],
	/** fetch aggregated fields from the table: "user_to_group" */
	user_to_group_aggregate:ModelTypes["user_to_group_aggregate"],
	/** fetch data from the table: "user_to_group" using primary key columns */
	user_to_group_by_pk?:ModelTypes["user_to_group"],
	/** fetch data from the table: "user_to_thread" */
	user_to_thread:ModelTypes["user_to_thread"][],
	/** fetch aggregated fields from the table: "user_to_thread" */
	user_to_thread_aggregate:ModelTypes["user_to_thread_aggregate"],
	/** fetch data from the table: "user_to_thread" using primary key columns */
	user_to_thread_by_pk?:ModelTypes["user_to_thread"],
	/** fetch data from the table: "users" */
	users:ModelTypes["users"][],
	/** fetch aggregated fields from the table: "users" */
	users_aggregate:ModelTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk?:ModelTypes["users"]
};
	["subscription_root"]: {
		/** An array relationship */
	group_threads:ModelTypes["group_threads"][],
	/** An aggregate relationship */
	group_threads_aggregate:ModelTypes["group_threads_aggregate"],
	/** fetch data from the table: "group_threads" using primary key columns */
	group_threads_by_pk?:ModelTypes["group_threads"],
	/** fetch data from the table: "groups" */
	groups:ModelTypes["groups"][],
	/** fetch aggregated fields from the table: "groups" */
	groups_aggregate:ModelTypes["groups_aggregate"],
	/** fetch data from the table: "groups" using primary key columns */
	groups_by_pk?:ModelTypes["groups"],
	/** An array relationship */
	messages:ModelTypes["messages"][],
	/** An aggregate relationship */
	messages_aggregate:ModelTypes["messages_aggregate"],
	/** fetch data from the table: "messages" using primary key columns */
	messages_by_pk?:ModelTypes["messages"],
	/** fetch data from the table: "user_to_group" */
	user_to_group:ModelTypes["user_to_group"][],
	/** fetch aggregated fields from the table: "user_to_group" */
	user_to_group_aggregate:ModelTypes["user_to_group_aggregate"],
	/** fetch data from the table: "user_to_group" using primary key columns */
	user_to_group_by_pk?:ModelTypes["user_to_group"],
	/** fetch data from the table: "user_to_thread" */
	user_to_thread:ModelTypes["user_to_thread"][],
	/** fetch aggregated fields from the table: "user_to_thread" */
	user_to_thread_aggregate:ModelTypes["user_to_thread_aggregate"],
	/** fetch data from the table: "user_to_thread" using primary key columns */
	user_to_thread_by_pk?:ModelTypes["user_to_thread"],
	/** fetch data from the table: "users" */
	users:ModelTypes["users"][],
	/** fetch aggregated fields from the table: "users" */
	users_aggregate:ModelTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk?:ModelTypes["users"]
};
	["timestamptz"]:any;
	/** Boolean expression to compare columns of type "timestamptz". All fields are combined with logical 'AND'. */
["timestamptz_comparison_exp"]: GraphQLTypes["timestamptz_comparison_exp"];
	/** columns and relationships of "user_to_group" */
["user_to_group"]: {
		admin:boolean,
	/** An object relationship */
	group:ModelTypes["groups"],
	group_id:ModelTypes["uuid"],
	id:ModelTypes["uuid"],
	/** An object relationship */
	user:ModelTypes["users"],
	user_id:ModelTypes["uuid"]
};
	/** aggregated selection of "user_to_group" */
["user_to_group_aggregate"]: {
		aggregate?:ModelTypes["user_to_group_aggregate_fields"],
	nodes:ModelTypes["user_to_group"][]
};
	/** aggregate fields of "user_to_group" */
["user_to_group_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["user_to_group_max_fields"],
	min?:ModelTypes["user_to_group_min_fields"]
};
	/** order by aggregate values of table "user_to_group" */
["user_to_group_aggregate_order_by"]: GraphQLTypes["user_to_group_aggregate_order_by"];
	/** input type for inserting array relation for remote table "user_to_group" */
["user_to_group_arr_rel_insert_input"]: GraphQLTypes["user_to_group_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "user_to_group". All fields are combined with a logical 'AND'. */
["user_to_group_bool_exp"]: GraphQLTypes["user_to_group_bool_exp"];
	/** unique or primary key constraints on table "user_to_group" */
["user_to_group_constraint"]: GraphQLTypes["user_to_group_constraint"];
	/** input type for inserting data into table "user_to_group" */
["user_to_group_insert_input"]: GraphQLTypes["user_to_group_insert_input"];
	/** aggregate max on columns */
["user_to_group_max_fields"]: {
		group_id?:ModelTypes["uuid"],
	id?:ModelTypes["uuid"],
	user_id?:ModelTypes["uuid"]
};
	/** order by max() on columns of table "user_to_group" */
["user_to_group_max_order_by"]: GraphQLTypes["user_to_group_max_order_by"];
	/** aggregate min on columns */
["user_to_group_min_fields"]: {
		group_id?:ModelTypes["uuid"],
	id?:ModelTypes["uuid"],
	user_id?:ModelTypes["uuid"]
};
	/** order by min() on columns of table "user_to_group" */
["user_to_group_min_order_by"]: GraphQLTypes["user_to_group_min_order_by"];
	/** response of any mutation on the table "user_to_group" */
["user_to_group_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["user_to_group"][]
};
	/** on conflict condition type for table "user_to_group" */
["user_to_group_on_conflict"]: GraphQLTypes["user_to_group_on_conflict"];
	/** Ordering options when selecting data from "user_to_group". */
["user_to_group_order_by"]: GraphQLTypes["user_to_group_order_by"];
	/** primary key columns input for table: user_to_group */
["user_to_group_pk_columns_input"]: GraphQLTypes["user_to_group_pk_columns_input"];
	/** select columns of table "user_to_group" */
["user_to_group_select_column"]: GraphQLTypes["user_to_group_select_column"];
	/** input type for updating data in table "user_to_group" */
["user_to_group_set_input"]: GraphQLTypes["user_to_group_set_input"];
	/** update columns of table "user_to_group" */
["user_to_group_update_column"]: GraphQLTypes["user_to_group_update_column"];
	/** columns and relationships of "user_to_thread" */
["user_to_thread"]: {
		/** An object relationship */
	group_thread:ModelTypes["group_threads"],
	id:ModelTypes["uuid"],
	thread_id:ModelTypes["uuid"],
	/** An object relationship */
	user:ModelTypes["users"],
	user_id:ModelTypes["uuid"]
};
	/** aggregated selection of "user_to_thread" */
["user_to_thread_aggregate"]: {
		aggregate?:ModelTypes["user_to_thread_aggregate_fields"],
	nodes:ModelTypes["user_to_thread"][]
};
	/** aggregate fields of "user_to_thread" */
["user_to_thread_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["user_to_thread_max_fields"],
	min?:ModelTypes["user_to_thread_min_fields"]
};
	/** order by aggregate values of table "user_to_thread" */
["user_to_thread_aggregate_order_by"]: GraphQLTypes["user_to_thread_aggregate_order_by"];
	/** input type for inserting array relation for remote table "user_to_thread" */
["user_to_thread_arr_rel_insert_input"]: GraphQLTypes["user_to_thread_arr_rel_insert_input"];
	/** Boolean expression to filter rows from the table "user_to_thread". All fields are combined with a logical 'AND'. */
["user_to_thread_bool_exp"]: GraphQLTypes["user_to_thread_bool_exp"];
	/** unique or primary key constraints on table "user_to_thread" */
["user_to_thread_constraint"]: GraphQLTypes["user_to_thread_constraint"];
	/** input type for inserting data into table "user_to_thread" */
["user_to_thread_insert_input"]: GraphQLTypes["user_to_thread_insert_input"];
	/** aggregate max on columns */
["user_to_thread_max_fields"]: {
		id?:ModelTypes["uuid"],
	thread_id?:ModelTypes["uuid"],
	user_id?:ModelTypes["uuid"]
};
	/** order by max() on columns of table "user_to_thread" */
["user_to_thread_max_order_by"]: GraphQLTypes["user_to_thread_max_order_by"];
	/** aggregate min on columns */
["user_to_thread_min_fields"]: {
		id?:ModelTypes["uuid"],
	thread_id?:ModelTypes["uuid"],
	user_id?:ModelTypes["uuid"]
};
	/** order by min() on columns of table "user_to_thread" */
["user_to_thread_min_order_by"]: GraphQLTypes["user_to_thread_min_order_by"];
	/** response of any mutation on the table "user_to_thread" */
["user_to_thread_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["user_to_thread"][]
};
	/** on conflict condition type for table "user_to_thread" */
["user_to_thread_on_conflict"]: GraphQLTypes["user_to_thread_on_conflict"];
	/** Ordering options when selecting data from "user_to_thread". */
["user_to_thread_order_by"]: GraphQLTypes["user_to_thread_order_by"];
	/** primary key columns input for table: user_to_thread */
["user_to_thread_pk_columns_input"]: GraphQLTypes["user_to_thread_pk_columns_input"];
	/** select columns of table "user_to_thread" */
["user_to_thread_select_column"]: GraphQLTypes["user_to_thread_select_column"];
	/** input type for updating data in table "user_to_thread" */
["user_to_thread_set_input"]: GraphQLTypes["user_to_thread_set_input"];
	/** update columns of table "user_to_thread" */
["user_to_thread_update_column"]: GraphQLTypes["user_to_thread_update_column"];
	/** columns and relationships of "users" */
["users"]: {
		email?:string,
	id:ModelTypes["uuid"],
	/** An array relationship */
	messages:ModelTypes["messages"][],
	/** An aggregate relationship */
	messages_aggregate:ModelTypes["messages_aggregate"],
	name:string,
	profile_picture?:string,
	socket_id?:string,
	sub:string,
	/** An array relationship */
	user_to_groups:ModelTypes["user_to_group"][],
	/** An aggregate relationship */
	user_to_groups_aggregate:ModelTypes["user_to_group_aggregate"],
	/** An array relationship */
	user_to_threads:ModelTypes["user_to_thread"][],
	/** An aggregate relationship */
	user_to_threads_aggregate:ModelTypes["user_to_thread_aggregate"]
};
	/** aggregated selection of "users" */
["users_aggregate"]: {
		aggregate?:ModelTypes["users_aggregate_fields"],
	nodes:ModelTypes["users"][]
};
	/** aggregate fields of "users" */
["users_aggregate_fields"]: {
		count:number,
	max?:ModelTypes["users_max_fields"],
	min?:ModelTypes["users_min_fields"]
};
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: GraphQLTypes["users_bool_exp"];
	/** unique or primary key constraints on table "users" */
["users_constraint"]: GraphQLTypes["users_constraint"];
	/** input type for inserting data into table "users" */
["users_insert_input"]: GraphQLTypes["users_insert_input"];
	/** aggregate max on columns */
["users_max_fields"]: {
		email?:string,
	id?:ModelTypes["uuid"],
	name?:string,
	profile_picture?:string,
	socket_id?:string,
	sub?:string
};
	/** aggregate min on columns */
["users_min_fields"]: {
		email?:string,
	id?:ModelTypes["uuid"],
	name?:string,
	profile_picture?:string,
	socket_id?:string,
	sub?:string
};
	/** response of any mutation on the table "users" */
["users_mutation_response"]: {
		/** number of rows affected by the mutation */
	affected_rows:number,
	/** data from the rows affected by the mutation */
	returning:ModelTypes["users"][]
};
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: GraphQLTypes["users_obj_rel_insert_input"];
	/** on conflict condition type for table "users" */
["users_on_conflict"]: GraphQLTypes["users_on_conflict"];
	/** Ordering options when selecting data from "users". */
["users_order_by"]: GraphQLTypes["users_order_by"];
	/** primary key columns input for table: users */
["users_pk_columns_input"]: GraphQLTypes["users_pk_columns_input"];
	/** select columns of table "users" */
["users_select_column"]: GraphQLTypes["users_select_column"];
	/** input type for updating data in table "users" */
["users_set_input"]: GraphQLTypes["users_set_input"];
	/** update columns of table "users" */
["users_update_column"]: GraphQLTypes["users_update_column"];
	["uuid"]:any;
	/** Boolean expression to compare columns of type "uuid". All fields are combined with logical 'AND'. */
["uuid_comparison_exp"]: GraphQLTypes["uuid_comparison_exp"]
    }

export type GraphQLTypes = {
    /** Boolean expression to compare columns of type "Boolean". All fields are combined with logical 'AND'. */
["Boolean_comparison_exp"]: {
		_eq: boolean | null,
	_gt: boolean | null,
	_gte: boolean | null,
	_in: Array<boolean> | null,
	_is_null: boolean | null,
	_lt: boolean | null,
	_lte: boolean | null,
	_neq: boolean | null,
	_nin: Array<boolean> | null
};
	/** Boolean expression to compare columns of type "String". All fields are combined with logical 'AND'. */
["String_comparison_exp"]: {
		_eq: string | null,
	_gt: string | null,
	_gte: string | null,
	/** does the column match the given case-insensitive pattern */
	_ilike: string | null,
	_in: Array<string> | null,
	/** does the column match the given POSIX regular expression, case insensitive */
	_iregex: string | null,
	_is_null: boolean | null,
	/** does the column match the given pattern */
	_like: string | null,
	_lt: string | null,
	_lte: string | null,
	_neq: string | null,
	/** does the column NOT match the given case-insensitive pattern */
	_nilike: string | null,
	_nin: Array<string> | null,
	/** does the column NOT match the given POSIX regular expression, case insensitive */
	_niregex: string | null,
	/** does the column NOT match the given pattern */
	_nlike: string | null,
	/** does the column NOT match the given POSIX regular expression, case sensitive */
	_nregex: string | null,
	/** does the column NOT match the given SQL regular expression */
	_nsimilar: string | null,
	/** does the column match the given POSIX regular expression, case sensitive */
	_regex: string | null,
	/** does the column match the given SQL regular expression */
	_similar: string | null
};
	/** columns and relationships of "group_threads" */
["group_threads"]: {
	__typename: "group_threads",
	group_id: GraphQLTypes["uuid"],
	id: GraphQLTypes["uuid"],
	/** An array relationship */
	messages: Array<GraphQLTypes["messages"]>,
	/** An aggregate relationship */
	messages_aggregate: GraphQLTypes["messages_aggregate"],
	name: string,
	/** An array relationship */
	user_to_threads: Array<GraphQLTypes["user_to_thread"]>,
	/** An aggregate relationship */
	user_to_threads_aggregate: GraphQLTypes["user_to_thread_aggregate"]
};
	/** aggregated selection of "group_threads" */
["group_threads_aggregate"]: {
	__typename: "group_threads_aggregate",
	aggregate: GraphQLTypes["group_threads_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["group_threads"]>
};
	/** aggregate fields of "group_threads" */
["group_threads_aggregate_fields"]: {
	__typename: "group_threads_aggregate_fields",
	count: number,
	max: GraphQLTypes["group_threads_max_fields"] | null,
	min: GraphQLTypes["group_threads_min_fields"] | null
};
	/** order by aggregate values of table "group_threads" */
["group_threads_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["group_threads_max_order_by"] | null,
	min: GraphQLTypes["group_threads_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "group_threads" */
["group_threads_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["group_threads_insert_input"]>,
	/** on conflict condition */
	on_conflict: GraphQLTypes["group_threads_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "group_threads". All fields are combined with a logical 'AND'. */
["group_threads_bool_exp"]: {
		_and: Array<GraphQLTypes["group_threads_bool_exp"]> | null,
	_not: GraphQLTypes["group_threads_bool_exp"] | null,
	_or: Array<GraphQLTypes["group_threads_bool_exp"]> | null,
	group_id: GraphQLTypes["uuid_comparison_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	messages: GraphQLTypes["messages_bool_exp"] | null,
	name: GraphQLTypes["String_comparison_exp"] | null,
	user_to_threads: GraphQLTypes["user_to_thread_bool_exp"] | null
};
	/** unique or primary key constraints on table "group_threads" */
["group_threads_constraint"]: group_threads_constraint;
	/** input type for inserting data into table "group_threads" */
["group_threads_insert_input"]: {
		group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	messages: GraphQLTypes["messages_arr_rel_insert_input"] | null,
	name: string | null,
	user_to_threads: GraphQLTypes["user_to_thread_arr_rel_insert_input"] | null
};
	/** aggregate max on columns */
["group_threads_max_fields"]: {
	__typename: "group_threads_max_fields",
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null
};
	/** order by max() on columns of table "group_threads" */
["group_threads_max_order_by"]: {
		group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	name: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["group_threads_min_fields"]: {
	__typename: "group_threads_min_fields",
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null
};
	/** order by min() on columns of table "group_threads" */
["group_threads_min_order_by"]: {
		group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	name: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "group_threads" */
["group_threads_mutation_response"]: {
	__typename: "group_threads_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["group_threads"]>
};
	/** input type for inserting object relation for remote table "group_threads" */
["group_threads_obj_rel_insert_input"]: {
		data: GraphQLTypes["group_threads_insert_input"],
	/** on conflict condition */
	on_conflict: GraphQLTypes["group_threads_on_conflict"] | null
};
	/** on conflict condition type for table "group_threads" */
["group_threads_on_conflict"]: {
		constraint: GraphQLTypes["group_threads_constraint"],
	update_columns: Array<GraphQLTypes["group_threads_update_column"]>,
	where: GraphQLTypes["group_threads_bool_exp"] | null
};
	/** Ordering options when selecting data from "group_threads". */
["group_threads_order_by"]: {
		group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	messages_aggregate: GraphQLTypes["messages_aggregate_order_by"] | null,
	name: GraphQLTypes["order_by"] | null,
	user_to_threads_aggregate: GraphQLTypes["user_to_thread_aggregate_order_by"] | null
};
	/** primary key columns input for table: group_threads */
["group_threads_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "group_threads" */
["group_threads_select_column"]: group_threads_select_column;
	/** input type for updating data in table "group_threads" */
["group_threads_set_input"]: {
		group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null
};
	/** update columns of table "group_threads" */
["group_threads_update_column"]: group_threads_update_column;
	/** columns and relationships of "groups" */
["groups"]: {
	__typename: "groups",
	group_name: string,
	/** An array relationship */
	group_threads: Array<GraphQLTypes["group_threads"]>,
	/** An aggregate relationship */
	group_threads_aggregate: GraphQLTypes["group_threads_aggregate"],
	id: GraphQLTypes["uuid"],
	/** An array relationship */
	user_to_groups: Array<GraphQLTypes["user_to_group"]>,
	/** An aggregate relationship */
	user_to_groups_aggregate: GraphQLTypes["user_to_group_aggregate"]
};
	/** aggregated selection of "groups" */
["groups_aggregate"]: {
	__typename: "groups_aggregate",
	aggregate: GraphQLTypes["groups_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["groups"]>
};
	/** aggregate fields of "groups" */
["groups_aggregate_fields"]: {
	__typename: "groups_aggregate_fields",
	count: number,
	max: GraphQLTypes["groups_max_fields"] | null,
	min: GraphQLTypes["groups_min_fields"] | null
};
	/** Boolean expression to filter rows from the table "groups". All fields are combined with a logical 'AND'. */
["groups_bool_exp"]: {
		_and: Array<GraphQLTypes["groups_bool_exp"]> | null,
	_not: GraphQLTypes["groups_bool_exp"] | null,
	_or: Array<GraphQLTypes["groups_bool_exp"]> | null,
	group_name: GraphQLTypes["String_comparison_exp"] | null,
	group_threads: GraphQLTypes["group_threads_bool_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	user_to_groups: GraphQLTypes["user_to_group_bool_exp"] | null
};
	/** unique or primary key constraints on table "groups" */
["groups_constraint"]: groups_constraint;
	/** input type for inserting data into table "groups" */
["groups_insert_input"]: {
		group_name: string | null,
	group_threads: GraphQLTypes["group_threads_arr_rel_insert_input"] | null,
	id: GraphQLTypes["uuid"] | null,
	user_to_groups: GraphQLTypes["user_to_group_arr_rel_insert_input"] | null
};
	/** aggregate max on columns */
["groups_max_fields"]: {
	__typename: "groups_max_fields",
	group_name: string | null,
	id: GraphQLTypes["uuid"] | null
};
	/** aggregate min on columns */
["groups_min_fields"]: {
	__typename: "groups_min_fields",
	group_name: string | null,
	id: GraphQLTypes["uuid"] | null
};
	/** response of any mutation on the table "groups" */
["groups_mutation_response"]: {
	__typename: "groups_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["groups"]>
};
	/** input type for inserting object relation for remote table "groups" */
["groups_obj_rel_insert_input"]: {
		data: GraphQLTypes["groups_insert_input"],
	/** on conflict condition */
	on_conflict: GraphQLTypes["groups_on_conflict"] | null
};
	/** on conflict condition type for table "groups" */
["groups_on_conflict"]: {
		constraint: GraphQLTypes["groups_constraint"],
	update_columns: Array<GraphQLTypes["groups_update_column"]>,
	where: GraphQLTypes["groups_bool_exp"] | null
};
	/** Ordering options when selecting data from "groups". */
["groups_order_by"]: {
		group_name: GraphQLTypes["order_by"] | null,
	group_threads_aggregate: GraphQLTypes["group_threads_aggregate_order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	user_to_groups_aggregate: GraphQLTypes["user_to_group_aggregate_order_by"] | null
};
	/** primary key columns input for table: groups */
["groups_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "groups" */
["groups_select_column"]: groups_select_column;
	/** input type for updating data in table "groups" */
["groups_set_input"]: {
		group_name: string | null,
	id: GraphQLTypes["uuid"] | null
};
	/** update columns of table "groups" */
["groups_update_column"]: groups_update_column;
	/** columns and relationships of "messages" */
["messages"]: {
	__typename: "messages",
	created_at: GraphQLTypes["timestamptz"],
	deleted: boolean,
	edited: boolean,
	/** An object relationship */
	group_thread: GraphQLTypes["group_threads"],
	id: GraphQLTypes["uuid"],
	is_image: boolean,
	message: string,
	thread_id: GraphQLTypes["uuid"],
	/** An object relationship */
	user: GraphQLTypes["users"],
	user_sent: GraphQLTypes["uuid"]
};
	/** aggregated selection of "messages" */
["messages_aggregate"]: {
	__typename: "messages_aggregate",
	aggregate: GraphQLTypes["messages_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["messages"]>
};
	/** aggregate fields of "messages" */
["messages_aggregate_fields"]: {
	__typename: "messages_aggregate_fields",
	count: number,
	max: GraphQLTypes["messages_max_fields"] | null,
	min: GraphQLTypes["messages_min_fields"] | null
};
	/** order by aggregate values of table "messages" */
["messages_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["messages_max_order_by"] | null,
	min: GraphQLTypes["messages_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "messages" */
["messages_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["messages_insert_input"]>,
	/** on conflict condition */
	on_conflict: GraphQLTypes["messages_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "messages". All fields are combined with a logical 'AND'. */
["messages_bool_exp"]: {
		_and: Array<GraphQLTypes["messages_bool_exp"]> | null,
	_not: GraphQLTypes["messages_bool_exp"] | null,
	_or: Array<GraphQLTypes["messages_bool_exp"]> | null,
	created_at: GraphQLTypes["timestamptz_comparison_exp"] | null,
	deleted: GraphQLTypes["Boolean_comparison_exp"] | null,
	edited: GraphQLTypes["Boolean_comparison_exp"] | null,
	group_thread: GraphQLTypes["group_threads_bool_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	is_image: GraphQLTypes["Boolean_comparison_exp"] | null,
	message: GraphQLTypes["String_comparison_exp"] | null,
	thread_id: GraphQLTypes["uuid_comparison_exp"] | null,
	user: GraphQLTypes["users_bool_exp"] | null,
	user_sent: GraphQLTypes["uuid_comparison_exp"] | null
};
	/** unique or primary key constraints on table "messages" */
["messages_constraint"]: messages_constraint;
	/** input type for inserting data into table "messages" */
["messages_insert_input"]: {
		created_at: GraphQLTypes["timestamptz"] | null,
	deleted: boolean | null,
	edited: boolean | null,
	group_thread: GraphQLTypes["group_threads_obj_rel_insert_input"] | null,
	id: GraphQLTypes["uuid"] | null,
	is_image: boolean | null,
	message: string | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user: GraphQLTypes["users_obj_rel_insert_input"] | null,
	user_sent: GraphQLTypes["uuid"] | null
};
	/** aggregate max on columns */
["messages_max_fields"]: {
	__typename: "messages_max_fields",
	created_at: GraphQLTypes["timestamptz"] | null,
	id: GraphQLTypes["uuid"] | null,
	message: string | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_sent: GraphQLTypes["uuid"] | null
};
	/** order by max() on columns of table "messages" */
["messages_max_order_by"]: {
		created_at: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	message: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user_sent: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["messages_min_fields"]: {
	__typename: "messages_min_fields",
	created_at: GraphQLTypes["timestamptz"] | null,
	id: GraphQLTypes["uuid"] | null,
	message: string | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_sent: GraphQLTypes["uuid"] | null
};
	/** order by min() on columns of table "messages" */
["messages_min_order_by"]: {
		created_at: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	message: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user_sent: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "messages" */
["messages_mutation_response"]: {
	__typename: "messages_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["messages"]>
};
	/** on conflict condition type for table "messages" */
["messages_on_conflict"]: {
		constraint: GraphQLTypes["messages_constraint"],
	update_columns: Array<GraphQLTypes["messages_update_column"]>,
	where: GraphQLTypes["messages_bool_exp"] | null
};
	/** Ordering options when selecting data from "messages". */
["messages_order_by"]: {
		created_at: GraphQLTypes["order_by"] | null,
	deleted: GraphQLTypes["order_by"] | null,
	edited: GraphQLTypes["order_by"] | null,
	group_thread: GraphQLTypes["group_threads_order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	is_image: GraphQLTypes["order_by"] | null,
	message: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user: GraphQLTypes["users_order_by"] | null,
	user_sent: GraphQLTypes["order_by"] | null
};
	/** primary key columns input for table: messages */
["messages_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "messages" */
["messages_select_column"]: messages_select_column;
	/** input type for updating data in table "messages" */
["messages_set_input"]: {
		created_at: GraphQLTypes["timestamptz"] | null,
	deleted: boolean | null,
	edited: boolean | null,
	id: GraphQLTypes["uuid"] | null,
	is_image: boolean | null,
	message: string | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_sent: GraphQLTypes["uuid"] | null
};
	/** update columns of table "messages" */
["messages_update_column"]: messages_update_column;
	/** mutation root */
["mutation_root"]: {
	__typename: "mutation_root",
	/** delete data from the table: "group_threads" */
	delete_group_threads: GraphQLTypes["group_threads_mutation_response"] | null,
	/** delete single row from the table: "group_threads" */
	delete_group_threads_by_pk: GraphQLTypes["group_threads"] | null,
	/** delete data from the table: "groups" */
	delete_groups: GraphQLTypes["groups_mutation_response"] | null,
	/** delete single row from the table: "groups" */
	delete_groups_by_pk: GraphQLTypes["groups"] | null,
	/** delete data from the table: "messages" */
	delete_messages: GraphQLTypes["messages_mutation_response"] | null,
	/** delete single row from the table: "messages" */
	delete_messages_by_pk: GraphQLTypes["messages"] | null,
	/** delete data from the table: "user_to_group" */
	delete_user_to_group: GraphQLTypes["user_to_group_mutation_response"] | null,
	/** delete single row from the table: "user_to_group" */
	delete_user_to_group_by_pk: GraphQLTypes["user_to_group"] | null,
	/** delete data from the table: "user_to_thread" */
	delete_user_to_thread: GraphQLTypes["user_to_thread_mutation_response"] | null,
	/** delete single row from the table: "user_to_thread" */
	delete_user_to_thread_by_pk: GraphQLTypes["user_to_thread"] | null,
	/** delete data from the table: "users" */
	delete_users: GraphQLTypes["users_mutation_response"] | null,
	/** delete single row from the table: "users" */
	delete_users_by_pk: GraphQLTypes["users"] | null,
	/** insert data into the table: "group_threads" */
	insert_group_threads: GraphQLTypes["group_threads_mutation_response"] | null,
	/** insert a single row into the table: "group_threads" */
	insert_group_threads_one: GraphQLTypes["group_threads"] | null,
	/** insert data into the table: "groups" */
	insert_groups: GraphQLTypes["groups_mutation_response"] | null,
	/** insert a single row into the table: "groups" */
	insert_groups_one: GraphQLTypes["groups"] | null,
	/** insert data into the table: "messages" */
	insert_messages: GraphQLTypes["messages_mutation_response"] | null,
	/** insert a single row into the table: "messages" */
	insert_messages_one: GraphQLTypes["messages"] | null,
	/** insert data into the table: "user_to_group" */
	insert_user_to_group: GraphQLTypes["user_to_group_mutation_response"] | null,
	/** insert a single row into the table: "user_to_group" */
	insert_user_to_group_one: GraphQLTypes["user_to_group"] | null,
	/** insert data into the table: "user_to_thread" */
	insert_user_to_thread: GraphQLTypes["user_to_thread_mutation_response"] | null,
	/** insert a single row into the table: "user_to_thread" */
	insert_user_to_thread_one: GraphQLTypes["user_to_thread"] | null,
	/** insert data into the table: "users" */
	insert_users: GraphQLTypes["users_mutation_response"] | null,
	/** insert a single row into the table: "users" */
	insert_users_one: GraphQLTypes["users"] | null,
	/** update data of the table: "group_threads" */
	update_group_threads: GraphQLTypes["group_threads_mutation_response"] | null,
	/** update single row of the table: "group_threads" */
	update_group_threads_by_pk: GraphQLTypes["group_threads"] | null,
	/** update data of the table: "groups" */
	update_groups: GraphQLTypes["groups_mutation_response"] | null,
	/** update single row of the table: "groups" */
	update_groups_by_pk: GraphQLTypes["groups"] | null,
	/** update data of the table: "messages" */
	update_messages: GraphQLTypes["messages_mutation_response"] | null,
	/** update single row of the table: "messages" */
	update_messages_by_pk: GraphQLTypes["messages"] | null,
	/** update data of the table: "user_to_group" */
	update_user_to_group: GraphQLTypes["user_to_group_mutation_response"] | null,
	/** update single row of the table: "user_to_group" */
	update_user_to_group_by_pk: GraphQLTypes["user_to_group"] | null,
	/** update data of the table: "user_to_thread" */
	update_user_to_thread: GraphQLTypes["user_to_thread_mutation_response"] | null,
	/** update single row of the table: "user_to_thread" */
	update_user_to_thread_by_pk: GraphQLTypes["user_to_thread"] | null,
	/** update data of the table: "users" */
	update_users: GraphQLTypes["users_mutation_response"] | null,
	/** update single row of the table: "users" */
	update_users_by_pk: GraphQLTypes["users"] | null
};
	/** column ordering options */
["order_by"]: order_by;
	["query_root"]: {
	__typename: "query_root",
	/** An array relationship */
	group_threads: Array<GraphQLTypes["group_threads"]>,
	/** An aggregate relationship */
	group_threads_aggregate: GraphQLTypes["group_threads_aggregate"],
	/** fetch data from the table: "group_threads" using primary key columns */
	group_threads_by_pk: GraphQLTypes["group_threads"] | null,
	/** fetch data from the table: "groups" */
	groups: Array<GraphQLTypes["groups"]>,
	/** fetch aggregated fields from the table: "groups" */
	groups_aggregate: GraphQLTypes["groups_aggregate"],
	/** fetch data from the table: "groups" using primary key columns */
	groups_by_pk: GraphQLTypes["groups"] | null,
	/** An array relationship */
	messages: Array<GraphQLTypes["messages"]>,
	/** An aggregate relationship */
	messages_aggregate: GraphQLTypes["messages_aggregate"],
	/** fetch data from the table: "messages" using primary key columns */
	messages_by_pk: GraphQLTypes["messages"] | null,
	/** fetch data from the table: "user_to_group" */
	user_to_group: Array<GraphQLTypes["user_to_group"]>,
	/** fetch aggregated fields from the table: "user_to_group" */
	user_to_group_aggregate: GraphQLTypes["user_to_group_aggregate"],
	/** fetch data from the table: "user_to_group" using primary key columns */
	user_to_group_by_pk: GraphQLTypes["user_to_group"] | null,
	/** fetch data from the table: "user_to_thread" */
	user_to_thread: Array<GraphQLTypes["user_to_thread"]>,
	/** fetch aggregated fields from the table: "user_to_thread" */
	user_to_thread_aggregate: GraphQLTypes["user_to_thread_aggregate"],
	/** fetch data from the table: "user_to_thread" using primary key columns */
	user_to_thread_by_pk: GraphQLTypes["user_to_thread"] | null,
	/** fetch data from the table: "users" */
	users: Array<GraphQLTypes["users"]>,
	/** fetch aggregated fields from the table: "users" */
	users_aggregate: GraphQLTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk: GraphQLTypes["users"] | null
};
	["subscription_root"]: {
	__typename: "subscription_root",
	/** An array relationship */
	group_threads: Array<GraphQLTypes["group_threads"]>,
	/** An aggregate relationship */
	group_threads_aggregate: GraphQLTypes["group_threads_aggregate"],
	/** fetch data from the table: "group_threads" using primary key columns */
	group_threads_by_pk: GraphQLTypes["group_threads"] | null,
	/** fetch data from the table: "groups" */
	groups: Array<GraphQLTypes["groups"]>,
	/** fetch aggregated fields from the table: "groups" */
	groups_aggregate: GraphQLTypes["groups_aggregate"],
	/** fetch data from the table: "groups" using primary key columns */
	groups_by_pk: GraphQLTypes["groups"] | null,
	/** An array relationship */
	messages: Array<GraphQLTypes["messages"]>,
	/** An aggregate relationship */
	messages_aggregate: GraphQLTypes["messages_aggregate"],
	/** fetch data from the table: "messages" using primary key columns */
	messages_by_pk: GraphQLTypes["messages"] | null,
	/** fetch data from the table: "user_to_group" */
	user_to_group: Array<GraphQLTypes["user_to_group"]>,
	/** fetch aggregated fields from the table: "user_to_group" */
	user_to_group_aggregate: GraphQLTypes["user_to_group_aggregate"],
	/** fetch data from the table: "user_to_group" using primary key columns */
	user_to_group_by_pk: GraphQLTypes["user_to_group"] | null,
	/** fetch data from the table: "user_to_thread" */
	user_to_thread: Array<GraphQLTypes["user_to_thread"]>,
	/** fetch aggregated fields from the table: "user_to_thread" */
	user_to_thread_aggregate: GraphQLTypes["user_to_thread_aggregate"],
	/** fetch data from the table: "user_to_thread" using primary key columns */
	user_to_thread_by_pk: GraphQLTypes["user_to_thread"] | null,
	/** fetch data from the table: "users" */
	users: Array<GraphQLTypes["users"]>,
	/** fetch aggregated fields from the table: "users" */
	users_aggregate: GraphQLTypes["users_aggregate"],
	/** fetch data from the table: "users" using primary key columns */
	users_by_pk: GraphQLTypes["users"] | null
};
	["timestamptz"]:any;
	/** Boolean expression to compare columns of type "timestamptz". All fields are combined with logical 'AND'. */
["timestamptz_comparison_exp"]: {
		_eq: GraphQLTypes["timestamptz"] | null,
	_gt: GraphQLTypes["timestamptz"] | null,
	_gte: GraphQLTypes["timestamptz"] | null,
	_in: Array<GraphQLTypes["timestamptz"]> | null,
	_is_null: boolean | null,
	_lt: GraphQLTypes["timestamptz"] | null,
	_lte: GraphQLTypes["timestamptz"] | null,
	_neq: GraphQLTypes["timestamptz"] | null,
	_nin: Array<GraphQLTypes["timestamptz"]> | null
};
	/** columns and relationships of "user_to_group" */
["user_to_group"]: {
	__typename: "user_to_group",
	admin: boolean,
	/** An object relationship */
	group: GraphQLTypes["groups"],
	group_id: GraphQLTypes["uuid"],
	id: GraphQLTypes["uuid"],
	/** An object relationship */
	user: GraphQLTypes["users"],
	user_id: GraphQLTypes["uuid"]
};
	/** aggregated selection of "user_to_group" */
["user_to_group_aggregate"]: {
	__typename: "user_to_group_aggregate",
	aggregate: GraphQLTypes["user_to_group_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["user_to_group"]>
};
	/** aggregate fields of "user_to_group" */
["user_to_group_aggregate_fields"]: {
	__typename: "user_to_group_aggregate_fields",
	count: number,
	max: GraphQLTypes["user_to_group_max_fields"] | null,
	min: GraphQLTypes["user_to_group_min_fields"] | null
};
	/** order by aggregate values of table "user_to_group" */
["user_to_group_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["user_to_group_max_order_by"] | null,
	min: GraphQLTypes["user_to_group_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "user_to_group" */
["user_to_group_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["user_to_group_insert_input"]>,
	/** on conflict condition */
	on_conflict: GraphQLTypes["user_to_group_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "user_to_group". All fields are combined with a logical 'AND'. */
["user_to_group_bool_exp"]: {
		_and: Array<GraphQLTypes["user_to_group_bool_exp"]> | null,
	_not: GraphQLTypes["user_to_group_bool_exp"] | null,
	_or: Array<GraphQLTypes["user_to_group_bool_exp"]> | null,
	admin: GraphQLTypes["Boolean_comparison_exp"] | null,
	group: GraphQLTypes["groups_bool_exp"] | null,
	group_id: GraphQLTypes["uuid_comparison_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	user: GraphQLTypes["users_bool_exp"] | null,
	user_id: GraphQLTypes["uuid_comparison_exp"] | null
};
	/** unique or primary key constraints on table "user_to_group" */
["user_to_group_constraint"]: user_to_group_constraint;
	/** input type for inserting data into table "user_to_group" */
["user_to_group_insert_input"]: {
		admin: boolean | null,
	group: GraphQLTypes["groups_obj_rel_insert_input"] | null,
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	user: GraphQLTypes["users_obj_rel_insert_input"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** aggregate max on columns */
["user_to_group_max_fields"]: {
	__typename: "user_to_group_max_fields",
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by max() on columns of table "user_to_group" */
["user_to_group_max_order_by"]: {
		group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["user_to_group_min_fields"]: {
	__typename: "user_to_group_min_fields",
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by min() on columns of table "user_to_group" */
["user_to_group_min_order_by"]: {
		group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "user_to_group" */
["user_to_group_mutation_response"]: {
	__typename: "user_to_group_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["user_to_group"]>
};
	/** on conflict condition type for table "user_to_group" */
["user_to_group_on_conflict"]: {
		constraint: GraphQLTypes["user_to_group_constraint"],
	update_columns: Array<GraphQLTypes["user_to_group_update_column"]>,
	where: GraphQLTypes["user_to_group_bool_exp"] | null
};
	/** Ordering options when selecting data from "user_to_group". */
["user_to_group_order_by"]: {
		admin: GraphQLTypes["order_by"] | null,
	group: GraphQLTypes["groups_order_by"] | null,
	group_id: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	user: GraphQLTypes["users_order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** primary key columns input for table: user_to_group */
["user_to_group_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "user_to_group" */
["user_to_group_select_column"]: user_to_group_select_column;
	/** input type for updating data in table "user_to_group" */
["user_to_group_set_input"]: {
		admin: boolean | null,
	group_id: GraphQLTypes["uuid"] | null,
	id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** update columns of table "user_to_group" */
["user_to_group_update_column"]: user_to_group_update_column;
	/** columns and relationships of "user_to_thread" */
["user_to_thread"]: {
	__typename: "user_to_thread",
	/** An object relationship */
	group_thread: GraphQLTypes["group_threads"],
	id: GraphQLTypes["uuid"],
	thread_id: GraphQLTypes["uuid"],
	/** An object relationship */
	user: GraphQLTypes["users"],
	user_id: GraphQLTypes["uuid"]
};
	/** aggregated selection of "user_to_thread" */
["user_to_thread_aggregate"]: {
	__typename: "user_to_thread_aggregate",
	aggregate: GraphQLTypes["user_to_thread_aggregate_fields"] | null,
	nodes: Array<GraphQLTypes["user_to_thread"]>
};
	/** aggregate fields of "user_to_thread" */
["user_to_thread_aggregate_fields"]: {
	__typename: "user_to_thread_aggregate_fields",
	count: number,
	max: GraphQLTypes["user_to_thread_max_fields"] | null,
	min: GraphQLTypes["user_to_thread_min_fields"] | null
};
	/** order by aggregate values of table "user_to_thread" */
["user_to_thread_aggregate_order_by"]: {
		count: GraphQLTypes["order_by"] | null,
	max: GraphQLTypes["user_to_thread_max_order_by"] | null,
	min: GraphQLTypes["user_to_thread_min_order_by"] | null
};
	/** input type for inserting array relation for remote table "user_to_thread" */
["user_to_thread_arr_rel_insert_input"]: {
		data: Array<GraphQLTypes["user_to_thread_insert_input"]>,
	/** on conflict condition */
	on_conflict: GraphQLTypes["user_to_thread_on_conflict"] | null
};
	/** Boolean expression to filter rows from the table "user_to_thread". All fields are combined with a logical 'AND'. */
["user_to_thread_bool_exp"]: {
		_and: Array<GraphQLTypes["user_to_thread_bool_exp"]> | null,
	_not: GraphQLTypes["user_to_thread_bool_exp"] | null,
	_or: Array<GraphQLTypes["user_to_thread_bool_exp"]> | null,
	group_thread: GraphQLTypes["group_threads_bool_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	thread_id: GraphQLTypes["uuid_comparison_exp"] | null,
	user: GraphQLTypes["users_bool_exp"] | null,
	user_id: GraphQLTypes["uuid_comparison_exp"] | null
};
	/** unique or primary key constraints on table "user_to_thread" */
["user_to_thread_constraint"]: user_to_thread_constraint;
	/** input type for inserting data into table "user_to_thread" */
["user_to_thread_insert_input"]: {
		group_thread: GraphQLTypes["group_threads_obj_rel_insert_input"] | null,
	id: GraphQLTypes["uuid"] | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user: GraphQLTypes["users_obj_rel_insert_input"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** aggregate max on columns */
["user_to_thread_max_fields"]: {
	__typename: "user_to_thread_max_fields",
	id: GraphQLTypes["uuid"] | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by max() on columns of table "user_to_thread" */
["user_to_thread_max_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** aggregate min on columns */
["user_to_thread_min_fields"]: {
	__typename: "user_to_thread_min_fields",
	id: GraphQLTypes["uuid"] | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** order by min() on columns of table "user_to_thread" */
["user_to_thread_min_order_by"]: {
		id: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** response of any mutation on the table "user_to_thread" */
["user_to_thread_mutation_response"]: {
	__typename: "user_to_thread_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["user_to_thread"]>
};
	/** on conflict condition type for table "user_to_thread" */
["user_to_thread_on_conflict"]: {
		constraint: GraphQLTypes["user_to_thread_constraint"],
	update_columns: Array<GraphQLTypes["user_to_thread_update_column"]>,
	where: GraphQLTypes["user_to_thread_bool_exp"] | null
};
	/** Ordering options when selecting data from "user_to_thread". */
["user_to_thread_order_by"]: {
		group_thread: GraphQLTypes["group_threads_order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	thread_id: GraphQLTypes["order_by"] | null,
	user: GraphQLTypes["users_order_by"] | null,
	user_id: GraphQLTypes["order_by"] | null
};
	/** primary key columns input for table: user_to_thread */
["user_to_thread_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "user_to_thread" */
["user_to_thread_select_column"]: user_to_thread_select_column;
	/** input type for updating data in table "user_to_thread" */
["user_to_thread_set_input"]: {
		id: GraphQLTypes["uuid"] | null,
	thread_id: GraphQLTypes["uuid"] | null,
	user_id: GraphQLTypes["uuid"] | null
};
	/** update columns of table "user_to_thread" */
["user_to_thread_update_column"]: user_to_thread_update_column;
	/** columns and relationships of "users" */
["users"]: {
	__typename: "users",
	email: string | null,
	id: GraphQLTypes["uuid"],
	/** An array relationship */
	messages: Array<GraphQLTypes["messages"]>,
	/** An aggregate relationship */
	messages_aggregate: GraphQLTypes["messages_aggregate"],
	name: string,
	profile_picture: string | null,
	socket_id: string | null,
	sub: string,
	/** An array relationship */
	user_to_groups: Array<GraphQLTypes["user_to_group"]>,
	/** An aggregate relationship */
	user_to_groups_aggregate: GraphQLTypes["user_to_group_aggregate"],
	/** An array relationship */
	user_to_threads: Array<GraphQLTypes["user_to_thread"]>,
	/** An aggregate relationship */
	user_to_threads_aggregate: GraphQLTypes["user_to_thread_aggregate"]
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
	count: number,
	max: GraphQLTypes["users_max_fields"] | null,
	min: GraphQLTypes["users_min_fields"] | null
};
	/** Boolean expression to filter rows from the table "users". All fields are combined with a logical 'AND'. */
["users_bool_exp"]: {
		_and: Array<GraphQLTypes["users_bool_exp"]> | null,
	_not: GraphQLTypes["users_bool_exp"] | null,
	_or: Array<GraphQLTypes["users_bool_exp"]> | null,
	email: GraphQLTypes["String_comparison_exp"] | null,
	id: GraphQLTypes["uuid_comparison_exp"] | null,
	messages: GraphQLTypes["messages_bool_exp"] | null,
	name: GraphQLTypes["String_comparison_exp"] | null,
	profile_picture: GraphQLTypes["String_comparison_exp"] | null,
	socket_id: GraphQLTypes["String_comparison_exp"] | null,
	sub: GraphQLTypes["String_comparison_exp"] | null,
	user_to_groups: GraphQLTypes["user_to_group_bool_exp"] | null,
	user_to_threads: GraphQLTypes["user_to_thread_bool_exp"] | null
};
	/** unique or primary key constraints on table "users" */
["users_constraint"]: users_constraint;
	/** input type for inserting data into table "users" */
["users_insert_input"]: {
		email: string | null,
	id: GraphQLTypes["uuid"] | null,
	messages: GraphQLTypes["messages_arr_rel_insert_input"] | null,
	name: string | null,
	profile_picture: string | null,
	socket_id: string | null,
	sub: string | null,
	user_to_groups: GraphQLTypes["user_to_group_arr_rel_insert_input"] | null,
	user_to_threads: GraphQLTypes["user_to_thread_arr_rel_insert_input"] | null
};
	/** aggregate max on columns */
["users_max_fields"]: {
	__typename: "users_max_fields",
	email: string | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null,
	profile_picture: string | null,
	socket_id: string | null,
	sub: string | null
};
	/** aggregate min on columns */
["users_min_fields"]: {
	__typename: "users_min_fields",
	email: string | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null,
	profile_picture: string | null,
	socket_id: string | null,
	sub: string | null
};
	/** response of any mutation on the table "users" */
["users_mutation_response"]: {
	__typename: "users_mutation_response",
	/** number of rows affected by the mutation */
	affected_rows: number,
	/** data from the rows affected by the mutation */
	returning: Array<GraphQLTypes["users"]>
};
	/** input type for inserting object relation for remote table "users" */
["users_obj_rel_insert_input"]: {
		data: GraphQLTypes["users_insert_input"],
	/** on conflict condition */
	on_conflict: GraphQLTypes["users_on_conflict"] | null
};
	/** on conflict condition type for table "users" */
["users_on_conflict"]: {
		constraint: GraphQLTypes["users_constraint"],
	update_columns: Array<GraphQLTypes["users_update_column"]>,
	where: GraphQLTypes["users_bool_exp"] | null
};
	/** Ordering options when selecting data from "users". */
["users_order_by"]: {
		email: GraphQLTypes["order_by"] | null,
	id: GraphQLTypes["order_by"] | null,
	messages_aggregate: GraphQLTypes["messages_aggregate_order_by"] | null,
	name: GraphQLTypes["order_by"] | null,
	profile_picture: GraphQLTypes["order_by"] | null,
	socket_id: GraphQLTypes["order_by"] | null,
	sub: GraphQLTypes["order_by"] | null,
	user_to_groups_aggregate: GraphQLTypes["user_to_group_aggregate_order_by"] | null,
	user_to_threads_aggregate: GraphQLTypes["user_to_thread_aggregate_order_by"] | null
};
	/** primary key columns input for table: users */
["users_pk_columns_input"]: {
		id: GraphQLTypes["uuid"]
};
	/** select columns of table "users" */
["users_select_column"]: users_select_column;
	/** input type for updating data in table "users" */
["users_set_input"]: {
		email: string | null,
	id: GraphQLTypes["uuid"] | null,
	name: string | null,
	profile_picture: string | null,
	socket_id: string | null,
	sub: string | null
};
	/** update columns of table "users" */
["users_update_column"]: users_update_column;
	["uuid"]:any;
	/** Boolean expression to compare columns of type "uuid". All fields are combined with logical 'AND'. */
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
/** unique or primary key constraints on table "group_threads" */
export enum group_threads_constraint {
	group_threads_pkey = "group_threads_pkey"
}
/** select columns of table "group_threads" */
export enum group_threads_select_column {
	group_id = "group_id",
	id = "id",
	name = "name"
}
/** update columns of table "group_threads" */
export enum group_threads_update_column {
	group_id = "group_id",
	id = "id",
	name = "name"
}
/** unique or primary key constraints on table "groups" */
export enum groups_constraint {
	groups_pkey = "groups_pkey"
}
/** select columns of table "groups" */
export enum groups_select_column {
	group_name = "group_name",
	id = "id"
}
/** update columns of table "groups" */
export enum groups_update_column {
	group_name = "group_name",
	id = "id"
}
/** unique or primary key constraints on table "messages" */
export enum messages_constraint {
	messages_pkey = "messages_pkey"
}
/** select columns of table "messages" */
export enum messages_select_column {
	created_at = "created_at",
	deleted = "deleted",
	edited = "edited",
	id = "id",
	is_image = "is_image",
	message = "message",
	thread_id = "thread_id",
	user_sent = "user_sent"
}
/** update columns of table "messages" */
export enum messages_update_column {
	created_at = "created_at",
	deleted = "deleted",
	edited = "edited",
	id = "id",
	is_image = "is_image",
	message = "message",
	thread_id = "thread_id",
	user_sent = "user_sent"
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
/** unique or primary key constraints on table "user_to_group" */
export enum user_to_group_constraint {
	user_to_group_pkey = "user_to_group_pkey"
}
/** select columns of table "user_to_group" */
export enum user_to_group_select_column {
	admin = "admin",
	group_id = "group_id",
	id = "id",
	user_id = "user_id"
}
/** update columns of table "user_to_group" */
export enum user_to_group_update_column {
	admin = "admin",
	group_id = "group_id",
	id = "id",
	user_id = "user_id"
}
/** unique or primary key constraints on table "user_to_thread" */
export enum user_to_thread_constraint {
	user_to_thread_pkey = "user_to_thread_pkey"
}
/** select columns of table "user_to_thread" */
export enum user_to_thread_select_column {
	id = "id",
	thread_id = "thread_id",
	user_id = "user_id"
}
/** update columns of table "user_to_thread" */
export enum user_to_thread_update_column {
	id = "id",
	thread_id = "thread_id",
	user_id = "user_id"
}
/** unique or primary key constraints on table "users" */
export enum users_constraint {
	users_pkey = "users_pkey",
	users_sub_key = "users_sub_key"
}
/** select columns of table "users" */
export enum users_select_column {
	email = "email",
	id = "id",
	name = "name",
	profile_picture = "profile_picture",
	socket_id = "socket_id",
	sub = "sub"
}
/** update columns of table "users" */
export enum users_update_column {
	email = "email",
	id = "id",
	name = "name",
	profile_picture = "profile_picture",
	socket_id = "socket_id",
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
  

export const Gql = Chain('http://localhost:8080/v1/graphql')