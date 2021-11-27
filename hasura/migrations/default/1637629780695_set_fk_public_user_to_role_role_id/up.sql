alter table "public"."user_to_role"
  add constraint "user_to_role_role_id_fkey"
  foreign key ("role_id")
  references "public"."role"
  ("id") on update restrict on delete cascade;
