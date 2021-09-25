alter table "public"."group_threads" add constraint "dm_or_group" check (is_dm OR group_id IS NOT NULL);
