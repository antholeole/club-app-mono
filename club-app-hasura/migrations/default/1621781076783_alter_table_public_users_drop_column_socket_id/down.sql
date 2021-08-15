alter table "public"."users" alter column "socket_id" drop not null;
alter table "public"."users" add column "socket_id" text;
