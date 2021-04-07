inital schema:

<UTD / NUTD (Up to date / not up to date)>
<TABLE NAME>:
    <FIELD TYPE> <FIELD NAME><* if required>: <desc>,

    
<UTD>
User:
    uuid id*,
    Text email UNIQUE,
    Text name*,
    Text profile_picture,
    Text ws_id: The ID of the websocket connection in WS API Gateway. NULL if not online,

<UTD>
Groups:
    uuid id*,
    Text group_name,

<UTD>
User_to_group:
    uuid id*,
    uuid user_id*,
    uuid group_id*,
    bool admin DEFAULT FALSE

<UTD>
group_threads:
    uuid id*,
    uuid group_id*,
    Text name*,

<UTD>
User_to_thread:
    uuid id*,
    uuid user_id*,
    uuid thread_id*,

messages:
    uuid id*,
    uuid user_sent*,
    uuid thread_id
    bool edited DEFAULT FALSE,
    bool deleted DEFAULT FALSE,
    datetime created DEFAULT NOW,
    bool is_image*,
    Text message,



