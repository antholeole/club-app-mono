alter table "public"."message_reactions" add column "created_at" timestamptz
 null default now();
