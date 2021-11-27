alter table "public"."group_threads" add constraint "required_group_name" check (is_dm OR name IS NOT NULL);
