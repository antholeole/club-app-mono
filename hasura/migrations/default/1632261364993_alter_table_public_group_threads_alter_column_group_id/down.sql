comment on column "public"."group_threads"."group_id" is NULL;
alter table "public"."group_threads" alter column "group_id" set not null;
