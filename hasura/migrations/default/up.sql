SET check_function_bodies = false;
CREATE FUNCTION public.random_alphanumeric(length integer) RETURNS text
    LANGUAGE sql
    AS $_$
WITH chars AS (
    SELECT unnest(string_to_array('A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9', ' ')) AS _char
),
charlist AS
(
    SELECT _char FROM chars ORDER BY random() LIMIT $1
)
SELECT string_agg(_char, '')
FROM charlist
;
$_$;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.dms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text
);
CREATE TABLE public.group_metadata (
    group_id uuid NOT NULL,
    owner_id uuid NOT NULL
);
CREATE TABLE public.groups (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.join_tokens (
    role_id uuid NOT NULL,
    token character varying DEFAULT public.random_alphanumeric(10) NOT NULL
);
CREATE TABLE public.message_reaction_types (
    reaction_type text NOT NULL,
    description text
);
CREATE TABLE public.message_reactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reaction_type text NOT NULL,
    user_id uuid NOT NULL,
    message_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    deleted boolean DEFAULT false NOT NULL,
    updated_at timestamp with time zone DEFAULT now()
);
COMMENT ON TABLE public.message_reactions IS '''id'' is just for identification purposes; reaction_type, user_id, and message_id all serve as a PK combined.';
CREATE TABLE public.message_types (
    message_type text NOT NULL,
    description text
);
CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_sent uuid NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    body text NOT NULL,
    source_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    message_type text NOT NULL
);
COMMENT ON COLUMN public.messages.source_id IS 'can be EITHER from DM or Thread';
CREATE TABLE public.role_to_threads (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    role_id uuid NOT NULL,
    thread_id uuid NOT NULL
);
CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    group_id uuid DEFAULT gen_random_uuid() NOT NULL
);
CREATE TABLE public.threads (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_id uuid NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.user_to_dm (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    dm_id uuid DEFAULT gen_random_uuid() NOT NULL
);
CREATE TABLE public.user_to_role (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role_id uuid NOT NULL
);
CREATE VIEW public.user_to_group AS
 SELECT DISTINCT user_to_group.user_id,
    user_to_group.group_id,
    user_to_group.owner
   FROM ( SELECT user_to_role.user_id,
            groups.id AS group_id,
            false AS owner
           FROM ((public.roles
             JOIN public.groups ON ((roles.group_id = groups.id)))
             JOIN public.user_to_role ON ((roles.id = user_to_role.role_id)))
          WHERE (user_to_role.user_id <> ( SELECT group_metadata.owner_id
                   FROM public.group_metadata
                  WHERE (group_metadata.group_id = groups.id)))
        UNION
         SELECT group_metadata.owner_id AS user_id,
            group_metadata.group_id,
            true AS owner
           FROM public.group_metadata) user_to_group;
CREATE VIEW public.user_to_thread AS
 SELECT DISTINCT user_to_role.user_id,
    threads.id AS thread_id
   FROM ((public.role_to_threads
     JOIN public.user_to_role ON ((user_to_role.role_id = role_to_threads.role_id)))
     JOIN public.threads ON ((threads.id = role_to_threads.thread_id)));
CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email text,
    sub text NOT NULL,
    name text DEFAULT 'Club App User'::text NOT NULL
);
ALTER TABLE ONLY public.dms
    ADD CONSTRAINT dms_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.group_metadata
    ADD CONSTRAINT group_metadata_pkey PRIMARY KEY (group_id);
ALTER TABLE ONLY public.threads
    ADD CONSTRAINT group_threads_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.join_tokens
    ADD CONSTRAINT join_tokens_pkey PRIMARY KEY (role_id);
ALTER TABLE ONLY public.message_reaction_types
    ADD CONSTRAINT message_reaction_types_pkey PRIMARY KEY (reaction_type);
ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_pkey PRIMARY KEY (reaction_type, user_id, message_id);
ALTER TABLE ONLY public.message_types
    ADD CONSTRAINT message_types_pkey PRIMARY KEY (message_type);
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT role_id_key UNIQUE (id);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT role_pkey PRIMARY KEY (name, group_id);
ALTER TABLE ONLY public.role_to_threads
    ADD CONSTRAINT role_to_threads_pkey PRIMARY KEY (role_id, thread_id);
ALTER TABLE ONLY public.user_to_dm
    ADD CONSTRAINT user_to_dm_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_to_role
    ADD CONSTRAINT user_to_role_id_key UNIQUE (id);
ALTER TABLE ONLY public.user_to_role
    ADD CONSTRAINT user_to_role_pkey PRIMARY KEY (user_id, role_id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_sub_key UNIQUE (sub);
CREATE TRIGGER set_public_message_reactions_updated_at BEFORE UPDATE ON public.message_reactions FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_message_reactions_updated_at ON public.message_reactions IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_messages_updated_at BEFORE UPDATE ON public.messages FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_messages_updated_at ON public.messages IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.group_metadata
    ADD CONSTRAINT group_metadata_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.group_metadata
    ADD CONSTRAINT group_metadata_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.threads
    ADD CONSTRAINT group_threads_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.join_tokens
    ADD CONSTRAINT join_tokens_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_message_fkey FOREIGN KEY (message_id) REFERENCES public.messages(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_reaction_type_fkey FOREIGN KEY (reaction_type) REFERENCES public.message_reaction_types(reaction_type) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.message_reactions
    ADD CONSTRAINT message_reactions_user_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_message_type_fkey FOREIGN KEY (message_type) REFERENCES public.message_types(message_type) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_sent_fkey FOREIGN KEY (user_sent) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT role_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.role_to_threads
    ADD CONSTRAINT role_to_threads_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.role_to_threads
    ADD CONSTRAINT role_to_threads_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.threads(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.user_to_dm
    ADD CONSTRAINT user_to_dm_dm_id_fkey FOREIGN KEY (dm_id) REFERENCES public.dms(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.user_to_dm
    ADD CONSTRAINT user_to_dm_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.user_to_role
    ADD CONSTRAINT user_to_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE ONLY public.user_to_role
    ADD CONSTRAINT user_to_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;

INSERT INTO "public"."message_reaction_types"("reaction_type", "description") VALUES (E'ANGRY', E'Red Face Angry Emoji');
INSERT INTO "public"."message_reaction_types"("reaction_type", "description") VALUES (E'HEART', E'Heart Emoji');
INSERT INTO "public"."message_reaction_types"("reaction_type", "description") VALUES (E'LAUGH', E'Crying Laughing Face');
INSERT INTO "public"."message_reaction_types"("reaction_type", "description") VALUES (E'STRAIGHT', E'Straight Bruh face');
INSERT INTO "public"."message_reaction_types"("reaction_type", "description") VALUES (E'WOW', E'Open mouth wow face');

INSERT INTO "public"."message_types"("message_type", "description") VALUES (E'IMAGE', E'Image');
INSERT INTO "public"."message_types"("message_type", "description") VALUES (E'TEXT', E'Text');
