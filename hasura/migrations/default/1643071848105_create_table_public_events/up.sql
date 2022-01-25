CREATE TABLE "public"."events" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "ical_event" text NOT NULL, "group_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON UPDATE cascade ON DELETE cascade);
CREATE EXTENSION IF NOT EXISTS pgcrypto;
