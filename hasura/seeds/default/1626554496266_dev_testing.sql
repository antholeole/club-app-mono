truncate roles RESTART IDENTITY CASCADE;
truncate groups RESTART IDENTITY CASCADE;
truncate message_reactions RESTART IDENTITY CASCADE;
truncate messages RESTART IDENTITY CASCADE;
truncate threads RESTART IDENTITY CASCADE;
truncate dms RESTART IDENTITY CASCADE;
truncate user_to_role RESTART IDENTITY CASCADE;
truncate users RESTART IDENTITY CASCADE;

/* Insert Real People */
INSERT INTO public.users (id, email, sub, name)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', 'antholeinik@gmail.com', 'google:115536296995241020808', 'Anthony Oleinik');

/* Insert fake people */
INSERT INTO public.users (id, email, sub, name)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'brittany@gmail.com', 'google:111111111111', 'Brit B');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'charles@att.net', 'google:234203429340239402349024092', 'Charles Xavier');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('4aff9671-edc3-410e-843e-647203def97d', 'midget@yahoo.com', 'google:2340239402304', 'Midget');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('97f2c291-7449-4430-a47b-275d99ebdb0e', 'ming@china.com', 'google:3423420342340', 'Yu Ming');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('67c3f527-5550-49c9-b169-b0111fc2581a', 'äā@specialchar.com', 'google:324824923849', 'Yùńg gõd');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('3b43454c-c08b-4ecd-9520-7c56983185f8', 'EMAIL@EMAIL.com', 'google:pfkqrkq091239120', 'AAAHAHAHAHAHA');


INSERT INTO public.users (id, email, sub, name)
    VALUES ('c4a55755-6359-4b37-9e82-cb066b05d729', 'lmf@o.yahoo', 'google:1904013594069765434567', 'Lmfao Lmfao');

INSERT INTO public.users (id, email, sub, name)
    VALUES ('352b55a7-b677-46ce-b52b-dd489f11dde4', 'this_data@gmail.com', 'google:876543676543', 'I am Data Incarnate');

/* GROUPS */
INSERT INTO public.groups(id, name) 
    VALUES ('56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'ISU D&D Club');

INSERT INTO public.groups(id, name) 
    VALUES ('b454d579-c4d2-403c-95cd-ac8dbc97476a', 'Sports Ball Team');

INSERT INTO public.groups(id, name) 
    VALUES ('1f6aadfa-2f8c-4020-a338-379ee6a3fdce', 'ISU D&D Club 2');

/* roles for each group */

/* DD club */
INSERT INTO public.roles(id, group_id, name)
    VALUES ('2b9722cc-9ffb-4b5e-8245-7c76296cc4f6', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Dungeon Masters');

INSERT INTO public.roles(id, group_id, name)
    VALUES ('a1c1b211-f834-4e45-8fb7-48f7e458b54a', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Players');

/* Sports Ball Team */
INSERT INTO public.roles(id, group_id, name)
    VALUES ('47568061-097f-4de7-ba07-67516d4b90a4', 'b454d579-c4d2-403c-95cd-ac8dbc97476a', 'Defense');

INSERT INTO public.roles(id, group_id, name)
    VALUES ('850b9c83-38a0-4734-b7a2-0907650acbec', 'b454d579-c4d2-403c-95cd-ac8dbc97476a', 'Exec Board');

/* DD club 2 (dead) */
INSERT INTO public.roles(id, group_id, name)
    VALUES ('01fa03a2-e56c-4219-acf4-af7fd48003de', '1f6aadfa-2f8c-4020-a338-379ee6a3fdce', 'Goblins');

INSERT INTO public.roles(id, group_id, name)
    VALUES ('4184f9f7-1794-4c8f-9950-e7c8510a791c', '1f6aadfa-2f8c-4020-a338-379ee6a3fdce', 'Gnomes');

/* what users are in each role. First, add self to D&D and Sports Ball */
INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', '2b9722cc-9ffb-4b5e-8245-7c76296cc4f6');

INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', '47568061-097f-4de7-ba07-67516d4b90a4');

/* then, insert Brit B, Charles, and Midget into D&D as players  */
INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'a1c1b211-f834-4e45-8fb7-48f7e458b54a');

INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'a1c1b211-f834-4e45-8fb7-48f7e458b54a');

INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('4aff9671-edc3-410e-843e-647203def97d', 'a1c1b211-f834-4e45-8fb7-48f7e458b54a');

/* ming will be in sportsball */
INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('97f2c291-7449-4430-a47b-275d99ebdb0e', '850b9c83-38a0-4734-b7a2-0907650acbec');

/* create some threads for D&D */
INSERT INTO public.threads(id, group_id, name)
    VALUES ('6481f35f-e444-494b-a980-c0a420384c61', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Meetups');

INSERT INTO public.threads(id, group_id, name)
    VALUES ('79feb08f-6591-4e90-9f7c-d96b7244359c', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Another meetups');

INSERT INTO public.threads(id, group_id, name)
    VALUES ('78447a0c-6f41-4a6f-b0a6-002d1a64d903', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Dungeon Masters');

/* create a thread for DM between me and brit */
INSERT INTO public.dms(id)
    VALUES ('0e18b5f2-5f27-44b8-9840-2aaf3f01aa52');

INSERT INTO public.user_to_dm(user_id, dm_id)
    VALUES('04c9b164-8535-4ae0-a091-9681a425b935', '0e18b5f2-5f27-44b8-9840-2aaf3f01aa52');

INSERT INTO public.user_to_dm(user_id, dm_id)
    VALUES('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', '0e18b5f2-5f27-44b8-9840-2aaf3f01aa52');

/* create another dm between me, brit, and charles */
INSERT INTO public.dms(id)
    VALUES ('23b5b652-dd69-43c2-9790-8b877203a463');

INSERT INTO public.user_to_dm(user_id, dm_id)
    VALUES('04c9b164-8535-4ae0-a091-9681a425b935', '23b5b652-dd69-43c2-9790-8b877203a463');

INSERT INTO public.user_to_dm(user_id, dm_id)
    VALUES('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', '23b5b652-dd69-43c2-9790-8b877203a463');

INSERT INTO public.user_to_dm(user_id, dm_id)
    VALUES('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', '23b5b652-dd69-43c2-9790-8b877203a463');

/* and general thread for sports ball */
INSERT INTO public.threads(id, group_id, name)
    VALUES ('d1aa84a0-37d6-46e8-819f-206cc285b17f', 'b454d579-c4d2-403c-95cd-ac8dbc97476a', 'General');

/* add self, ming and brittany to the role of D&D */
INSERT INTO public.user_to_role(user_id, role_id)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', 'a1c1b211-f834-4e45-8fb7-48f7e458b54a');

/* tag DM role to DM thread */
INSERT INTO public.role_to_threads(role_id, thread_id) VALUES ('2b9722cc-9ffb-4b5e-8245-7c76296cc4f6', '78447a0c-6f41-4a6f-b0a6-002d1a64d903');

/* finally, insert some messages in the meetup group of D&D */
/* britb d3ac2f6b-e56f-47d2-9121-c5444b959a3f */
/* charles a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f */

/* 
we have an issue here: if we send more than 20 messages at the same exact MS, it breaks the UI.
Not good :/
*/

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');
    
INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'hi there! Im', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! di at sunt excepturi expedita sint? Sed quibusd', '6481f35f-e444-494b-a980-c0a420384c61');
    

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', ' libero, at maximus nisl suscipit posuere. Mor', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', ', hic voluptates pariatur est explicabo 
fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore 
suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium
modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam 
totam ratione voluptas quod exercitationem fuga. Possimus quis earum veniam 
quasi aliquam eligendi, placeat qui corporis!', '6481f35f-e444-494b-a980-c0a420384c61');


INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'isis justo mollis, auctor consequat urna. Morbi a bibendum metus. 
Donec scelerisque sollicitudin enim eu venenatis. Duis tincidunt laoreet ex, 
in pretium orci vestibulum eget', '6481f35f-e444-494b-a980-c0a420384c61');
    

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'hi there! Im', '6481f35f-e444-494b-a980-c0a420384c61');


INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, source_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');


