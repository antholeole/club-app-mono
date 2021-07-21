
alter table "public"."users" alter column "socket_id" drop not null;
alter table "public"."users" add column "socket_id" text;

DROP TABLE "public"."group_join_tokens";

alter table "public"."groups" add constraint "groups_join_token_key" unique (join_token);
alter table "public"."groups" alter column "join_token" drop not null;
alter table "public"."groups" add column "join_token" text;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."groups" add column "join_token" text
 null unique;

alter table "public"."group_threads" drop constraint "group_threads_group_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."users" add column "name" text
 not null default 'Club App User';

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."users" add column "sub" text
 not null unique;


DROP TABLE "public"."messages";

DROP TABLE "public"."user_to_thread";

DROP TABLE "public"."group_threads";

DROP TABLE "public"."user_to_group";

DROP TABLE "public"."groups";

DROP TABLE "public"."users";
