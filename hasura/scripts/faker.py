import argparse
import json
import helpers 


#check for override flag
parser = argparse.ArgumentParser(description="Flip a switch by setting a flag")
parser.add_argument('-c', action='store_true')

args = parser.parse_args()
clear_data = args.c

#clears data if -c flag enabled
if clear_data:
    print('\033[93mClearing all data!\033[0m')
    helpers.send_query_from_file('clear_all_data.sql')


#checks if the fake data already exists in table 
#by querying count of users table 
data_count = int(json.loads(helpers.send_query_from_file(
    'check_if_faked.sql').content.decode('utf-8'))['result'][1][0])

if data_count > 0:
    exit('\033[93mFake data already exists in table! run with -c to clear tables.')

#fakes data
resp = helpers.send_query_from_file('fake_data.sql')

if resp.status_code != 200:
    exit(f'''
    {json.dumps(json.loads(resp.content.decode("utf-8")), indent=1)}
    
    \033[91m DATA FAKING FAILED! \033[0merror outputted above.
    ''')
else:
    print('\033[92msuccess! content generated')