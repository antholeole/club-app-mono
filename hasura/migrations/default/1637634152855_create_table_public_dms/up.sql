CREATE TABLE "public"."dms" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "name" text, PRIMARY KEY ("id") );
CREATE EXTENSION IF NOT EXISTS pgcrypto;
