alter table "public"."groups" alter column "group_name" drop not null;
alter table "public"."groups" add column "group_name" text;
