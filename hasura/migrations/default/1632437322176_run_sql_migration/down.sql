-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE VIEW single_dms as SELECT * FROM threads AS thread WHERE is_dm = true AND (
--     SELECT COUNT(*) FROM user_to_thread WHERE
--     thread_id = thread.id
-- ) = 2;
