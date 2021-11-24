alter table "public"."threads" alter column "is_dm" set default false;
alter table "public"."threads" alter column "is_dm" drop not null;
alter table "public"."threads" add column "is_dm" bool;
