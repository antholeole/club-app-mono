CREATE OR REPLACE VIEW "public"."single_dms" AS 
 SELECT thread.id,
    thread.name
   FROM threads thread
  WHERE ((thread.is_dm = true) AND (( SELECT count(*) AS count
           FROM user_to_thread
          WHERE (user_to_thread.thread_id = thread.id)) = 2));
