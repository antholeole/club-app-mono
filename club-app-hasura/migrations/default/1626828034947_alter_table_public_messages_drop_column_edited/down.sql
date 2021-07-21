alter table "public"."messages" alter column "edited" set default false;
alter table "public"."messages" alter column "edited" drop not null;
alter table "public"."messages" add column "edited" bool;
