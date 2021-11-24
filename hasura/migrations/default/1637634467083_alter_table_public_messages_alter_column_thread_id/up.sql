comment on column "public"."messages"."thread_id" is E'can be EITHER from DM or Thread';
alter table "public"."messages" rename column "thread_id" to "source_id";
