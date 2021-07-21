

CREATE TABLE "public"."users" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "email" text, "profile_picture" text, PRIMARY KEY ("id") , UNIQUE ("id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "public"."groups" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "group_name" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "public"."user_to_group" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "user_id" uuid NOT NULL, "group_id" uuid NOT NULL, "admin" boolean NOT NULL DEFAULT FALSE, PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON UPDATE restrict ON DELETE restrict, UNIQUE ("id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "public"."group_threads" ("id" uuid NOT NULL, "group_id" uuid NOT NULL, "name" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"));

CREATE TABLE "public"."user_to_thread" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "user_id" uuid NOT NULL, "thread_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("thread_id") REFERENCES "public"."group_threads"("id") ON UPDATE restrict ON DELETE restrict, UNIQUE ("id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "public"."messages" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "user_sent" uuid NOT NULL, "edited" boolean NOT NULL DEFAULT FALSE, "deleted" boolean NOT NULL DEFAULT FALSE, "created_at" timestamptz NOT NULL DEFAULT now(), "is_image" boolean NOT NULL DEFAULT FALSE, "message" text NOT NULL, "thread_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("user_sent") REFERENCES "public"."users"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("thread_id") REFERENCES "public"."group_threads"("id") ON UPDATE restrict ON DELETE restrict);
CREATE EXTENSION IF NOT EXISTS pgcrypto;

alter table "public"."users" add column "sub" text
 not null unique;

alter table "public"."users" add column "name" text
 not null default 'Club App User';

alter table "public"."group_threads"
  add constraint "group_threads_group_id_fkey"
  foreign key ("group_id")
  references "public"."groups"
  ("id") on update restrict on delete restrict;

CREATE TABLE "public"."group_join_tokens" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "group_id" uuid NOT NULL, "join_token" text, PRIMARY KEY ("id") , FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON UPDATE restrict ON DELETE restrict, UNIQUE ("id"), UNIQUE ("group_id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;

