# Freepass

> RFID Project


## Usage

This API `http://freepass.herokuapp.com` have some endpoints to use:


### 1. Users

1. GET to list users
2. GET specify user
3. POST to create user
4. PUT to update user
5. DELETE to delete user

####1. GET /users

You can use cURL to get

```
curl http://<project url>/users
```

Response (with empty objects):

```json
[{
   "id":
   "full_name":
   "email":
}]
```

####2. POST /users

This endpoint will receive `user` params

Available attributes

```
full_name (required)
cpf (required)
password (required)
email (required)
phone
address
```

```
curl -H "Content-type: application/json" -X POST -d '{"full_name":"Jon Doe"}....' http://<project url>/users
```

####3. PUT /users/:id

```
curl -H "Content-type: application/json" -X PUT -d '{"full_name":"Jon Doe"}....' http://<project url>/users/:id
```

####4. GET /:id

```
curl -H "Content-type: application/json"  http://<project url>/users/:id
```

####5. DELETE /:id

```
curl -H "Content-type: application/json" -X DELETE http://<project url>/users/:id
```

### 2. Cards

1. GET to list cards
2. GET specify card
3. POST to create card
4. PUT to update card
5. DELETE to delete card
6. POST to auth

####1. GET /cards

You can use cURL to get

```
curl http://<project url>/cards
```

Response (with empty objects):

```json
[{
   "id":
   "full_name":
   "email":
}]
```

####2. POST /cards

This endpoint will receive `card` params

Available attributes

```
number (required)
user_id (required)
is_admin (default is false)
```

```
curl -H "Content-type: application/json" -X POST -d '{"number":"12345678"}....' http://<project url>/cards
```

####3. PUT /cards/:id

```
curl -H "Content-type: application/json" -X PUT -d '{"number":"12345678"}....' http://<project url>/cards/:id
```

####4. GET /:id

```
curl -H "Content-type: application/json"  http://<project url>/cards/:id
```

####5. DELETE /:id

```
curl -H "Content-type: application/json" -X DELETE http://<project url>/cards/:id
```

####6. POST /cards/auth

This endpoint will auth admin and return object of user

Available attributes

```
number (required)
```

```
curl -H "Content-type: application/json" -X POST -d '{"number":"num"}....' http://<project url>/cards/auth
```

### 3. Holidays

1. GET to list holidays
2. GET specify holiday
3. POST to create holiday
4. PUT to update holiday
5. DELETE to delete holiday

####1. GET /holidays

You can use cURL to get

```
curl http://<project url>/holidays
```

Response (with empty objects):

```json
[{
   "name":
   "happen_at":
}]
```

####2. POST /holidays

This endpoint will receive `holiday` params

Available attributes

```
name (required)
happend_at (required) - format (yyyy-mm-dd)
```

```
curl -H "Content-type: application/json" -X POST -d '{"name":"Holiday"}....' http://<project url>/holidays
```

####3. PUT /holidays/:id

```
curl -H "Content-type: application/json" -X PUT -d '{"name":"holiday"}....' http://<project url>/holidays/:id
```

####4. GET /:id

```
curl -H "Content-type: application/json"  http://<project url>/holidays/:id
```

####5. DELETE /:id

```
curl -H "Content-type: application/json" -X DELETE http://<project url>/holidays/:id
```

### 4. Hours

1. GET to list hours
2. GET specify hour
3. POST to create hour
4. PUT to update hour
5. DELETE to delete hour

####1. GET /hours

You can use cURL to get

```
curl http://<project url>/hours
```

Response (with empty objects):

```json
[{
   "name":
   "start_at":
   "end_at":
   "sunday":
   "monday":
}]
```

####2. POST /hours

This endpoint will receive `hour` params

Available attributes

```
name (required)
start_at (required) - format (hh:mm:ss)
end_at (required) - format (hh:mm:ss)
days: [
  monday: true,
  saturday: true
]
```

```
curl -H "Content-type: application/json" -X POST -d '{"name":"Hour"}....' http://<project url>/hours
```

####3. PUT /hours/:id

```
curl -H "Content-type: application/json" -X PUT -d '{"name":"Hour"}....' http://<project url>/hours/:id
```

####4. GET /:id

```
curl -H "Content-type: application/json"  http://<project url>/hours/:id
```

####5. DELETE /:id

```
curl -H "Content-type: application/json" -X DELETE http://<project url>/hours/:id
```


### 5. Periods

1. GET to list periods
2. GET specify period
3. POST to create period
4. PUT to update period
5. DELETE to delete period

####1. GET /periods

You can use cURL to get

```
curl http://<project url>/periods
```

Response (with empty objects):

```json
[{
   "name":
   "start_at":
   "end_at":
   "hours":[
    "name"
   ]
}]
```

####2. POST /periods

This endpoint will receive `period` params

Available attributes

```
name (required)
start_at (required) - format (hh:mm:ss)
end_at (required) - format (hh:mm:ss)
hour_ids: []
```

```
curl -H "Content-type: application/json" -X POST -d '{"name":"Period"}....' http://<project url>/periods
```

####3. PUT /hours/:id

```
curl -H "Content-type: application/json" -X PUT -d '{"name":"Period"}....' http://<project url>/periods/:id
```

####4. GET /:id

```
curl -H "Content-type: application/json"  http://<project url>/periods/:id
```

####5. DELETE /:id

```
curl -H "Content-type: application/json" -X DELETE http://<project url>/periods/:id
```

### 6. Admins

1. POST to auth admin

####1. POST /admins/auth

This endpoint will auth admin and return object of user

Available attributes

```
password (required)
```

```
curl -H "Content-type: application/json" -X POST -d '{"password":"pass"}....' http://<project url>/admin/auth
```

## Run Tests

First, create a test database:

  DATABASE_ENV=test bundle exec rake db:create

Then run migrations:

  DATABASE_ENV=test bundle exec rake db:migrate

Run tests

  bundle exec rspec


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for your feature.
4. Add your feature.
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2016, Tiago Lupepic

