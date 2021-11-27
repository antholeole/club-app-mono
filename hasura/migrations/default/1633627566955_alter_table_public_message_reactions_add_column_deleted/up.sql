alter table "public"."message_reactions" add column "deleted" boolean
 not null default 'False';
