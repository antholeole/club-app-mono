CREATE TABLE "public"."group_join_tokens" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "group_id" uuid NOT NULL, "join_token" text, PRIMARY KEY ("id") , FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON UPDATE restrict ON DELETE restrict, UNIQUE ("id"), UNIQUE ("group_id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;
