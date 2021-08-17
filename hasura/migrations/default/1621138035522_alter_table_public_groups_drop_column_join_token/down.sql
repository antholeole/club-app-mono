alter table "public"."groups" add constraint "groups_join_token_key" unique (join_token);
alter table "public"."groups" alter column "join_token" drop not null;
alter table "public"."groups" add column "join_token" text;
