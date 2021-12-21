comment on column "public"."threads"."group_id" is E'null if is dm';
alter table "public"."threads" alter column "group_id" drop not null;
