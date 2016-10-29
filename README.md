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

### 1. Cards

1. GET to list cards
2. GET specify card
3. POST to create card
4. PUT to update card
5. DELETE to delete card

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

