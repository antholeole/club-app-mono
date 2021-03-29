To run codegen:

```
zeus GQLENDPOINT ./src/generated --header=x-hasura-admin-secret:"SECRET" --ts
```


Current stack:
- Hasura graphql on heroku free teir 
- cloudflare workers for BE
- backblaze for images


At scale (Will never get here, just for fun!) 
- Hasura cloud
- Redis for managing current connections