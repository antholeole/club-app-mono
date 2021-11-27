alter table "public"."message_reactions" drop constraint "message_reactions_pkey";
alter table "public"."message_reactions"
    add constraint "message_reactions_pkey"
    primary key ("id");
