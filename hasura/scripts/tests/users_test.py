from .testing_utils import create_user, gql_request
from unittest import TestCase

class TestUserInserts:
    def test_user_insert(self):
        '''
        should not allow unauth to create user
        '''
        
        assert gql_request('''
        mutation {
            insert_users_one(object: {
                name: "Happy guy",
                email: "Email email",
                sub: "asdasdnin"
            }) {
                sub,
                email,
                name
            }
        } 
        ''').status_code == 400

    def test_change_user_name(self):
        '''
        should only allow a user to change THEIR name
        '''

        user_1_id = create_user('SUB1')
        user_2_id = create_user('SUB2')

        

        assert user_1_id['data'] == 'hi'

        
        



