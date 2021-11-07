BEGIN TRANSACTION;
ALTER TABLE "public"."message_reactions" DROP CONSTRAINT "message_reactions_pkey";

ALTER TABLE "public"."message_reactions"
    ADD CONSTRAINT "message_reactions_pkey" PRIMARY KEY ("id", "reaction_type", "user_id", "message_id");
COMMIT TRANSACTION;
