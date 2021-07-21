truncate group_join_tokens RESTART IDENTITY CASCADE;
truncate group_threads RESTART IDENTITY CASCADE;
truncate groups RESTART IDENTITY CASCADE;
truncate messages RESTART IDENTITY CASCADE;
truncate user_to_group RESTART IDENTITY CASCADE;
truncate user_to_thread RESTART IDENTITY CASCADE;
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
INSERT INTO public.groups(id, group_name) 
    VALUES ('56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'ISU D&D Club');

INSERT INTO public.groups(id, group_name) 
    VALUES ('b454d579-c4d2-403c-95cd-ac8dbc97476a', 'Sports Ball Team');

INSERT INTO public.groups(id, group_name) 
    VALUES ('1f6aadfa-2f8c-4020-a338-379ee6a3fdce', 'ISU D&D Club');

/* what users are in each group. First, add self to D&D and Sports Ball */
INSERT INTO public.user_to_group(user_id, group_id)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', '56610d26-d62d-4628-8c08-eabf7ab7e8ad');

INSERT INTO public.user_to_group(user_id, group_id, admin)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', 'b454d579-c4d2-403c-95cd-ac8dbc97476a', True);

/* then, insert Brit B, Charles, and Midget into D&D  */
INSERT INTO public.user_to_group(user_id, group_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', '56610d26-d62d-4628-8c08-eabf7ab7e8ad');

INSERT INTO public.user_to_group(user_id, group_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', '56610d26-d62d-4628-8c08-eabf7ab7e8ad');

INSERT INTO public.user_to_group(user_id, group_id)
    VALUES ('4aff9671-edc3-410e-843e-647203def97d', '56610d26-d62d-4628-8c08-eabf7ab7e8ad');

/* ming will be admin of sportsball */
INSERT INTO public.user_to_group(user_id, group_id, admin)
    VALUES ('97f2c291-7449-4430-a47b-275d99ebdb0e',
    'b454d579-c4d2-403c-95cd-ac8dbc97476a', True);

/* create some threads for D&D */
INSERT INTO public.group_threads(id, group_id, name)
    VALUES ('6481f35f-e444-494b-a980-c0a420384c61', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Meetups');

INSERT INTO public.group_threads(id, group_id, name)
    VALUES ('78447a0c-6f41-4a6f-b0a6-002d1a64d903', '56610d26-d62d-4628-8c08-eabf7ab7e8ad', 'Dungeon Masters');

/* and general thread for sports ball */
INSERT INTO public.group_threads(id, group_id, name)
    VALUES ('d1aa84a0-37d6-46e8-819f-206cc285b17f', 'b454d579-c4d2-403c-95cd-ac8dbc97476a', 'General');

/* add self, ming and brittany to the Meetup group of D&D */
INSERT INTO public.user_to_thread(user_id, thread_id)
    VALUES ('04c9b164-8535-4ae0-a091-9681a425b935', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.user_to_thread(user_id, thread_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.user_to_thread(user_id, thread_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', '6481f35f-e444-494b-a980-c0a420384c61');

/* finally, insert some messages in the meetup group of D&D */
/* britb d3ac2f6b-e56f-47d2-9121-c5444b959a3f */
/* charles a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f */

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! Provident similique accusantium', '6481f35f-e444-494b-a980-c0a420384c61');
    

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'hi there! Im', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'eaque rerum! di at sunt excepturi expedita sint? Sed quibusd', '6481f35f-e444-494b-a980-c0a420384c61');
    

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', ' libero, at maximus nisl suscipit posuere. Mor', '6481f35f-e444-494b-a980-c0a420384c61');

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', ', hic voluptates pariatur est explicabo 
fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore 
suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium
modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam 
totam ratione voluptas quod exercitationem fuga. Possimus quis earum veniam 
quasi aliquam eligendi, placeat qui corporis!', '6481f35f-e444-494b-a980-c0a420384c61');


INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('d3ac2f6b-e56f-47d2-9121-c5444b959a3f', 'isis justo mollis, auctor consequat urna. Morbi a bibendum metus. 
Donec scelerisque sollicitudin enim eu venenatis. Duis tincidunt laoreet ex, 
in pretium orci vestibulum eget', '6481f35f-e444-494b-a980-c0a420384c61');
    

INSERT INTO public.messages(user_sent, message, thread_id)
    VALUES ('a1e459f1-b3aa-4e47-a3c7-cf6f7ff8f19f', 'hi there! Im', '6481f35f-e444-494b-a980-c0a420384c61');


