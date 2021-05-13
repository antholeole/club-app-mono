Check out the makefile for scripts.

Make sure to squash changes if we're pre-launch so that we don't have a bunch of garbage.


## Adding Access

By default, no one can do anything! Anything that can be accessed must be specificially allowed. If you are adding access,
write tests! This is the most critical part of the application and if we accidently open up too much permission there are
potential security holes. 

In the case of needing fine grained access, follow ]this tutorial](https://hasura.io/docs/latest/graphql/core/auth/authorization/role-multiple-rules.html).

## Testing

Because ACLs are often finniky and making a change opens up a security hole, test around each ACL making sure that
you didn't accidently open up too much access. For instance, if adding "User should be able to change name" make sure to
test that other users cannot change the name.


A single docker instance is spun up ot test aginst. After each test the instance is cleared.