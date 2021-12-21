alter table "public"."threads" alter column "group_id" set not null;
comment on column "public"."threads"."group_id" is NULL;
