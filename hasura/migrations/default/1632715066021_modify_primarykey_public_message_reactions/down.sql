alter table "public"."message_reactions" drop constraint "message_reactions_pkey";
alter table "public"."message_reactions"
    add constraint "message_reactions_pkey"
    primary key ("message_id", "id", "reaction_type", "user_id");
