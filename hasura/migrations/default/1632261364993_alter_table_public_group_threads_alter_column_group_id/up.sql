alter table "public"."group_threads" alter column "group_id" drop not null;
comment on column "public"."group_threads"."group_id" is E'null if is dm';
