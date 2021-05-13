alter table "public"."group_threads"
  add constraint "group_threads_group_id_fkey"
  foreign key ("group_id")
  references "public"."groups"
  ("id") on update restrict on delete restrict;
