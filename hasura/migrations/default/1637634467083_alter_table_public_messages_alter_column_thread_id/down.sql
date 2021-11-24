alter table "public"."messages" rename column "source_id" to "thread_id";
comment on column "public"."messages"."thread_id" is NULL;
