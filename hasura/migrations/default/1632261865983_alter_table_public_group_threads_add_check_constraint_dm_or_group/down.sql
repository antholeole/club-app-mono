alter table "public"."group_threads" drop constraint "dm_or_group";
alter table "public"."group_threads" add constraint "dm_or_group" check (CHECK (is_dm OR group_id IS NOT NULL));
