# FIXD Coding Challenge

## Setup
1. Clone this repo to your machine and run `bundle install` from the command line in the root directory to install the necessary gems.
2. Run `bundle exec rails db:create db:migrate` to create the database and run the migrations.
3. Run `bundle exec rails db:seed` to seed the database with sample data to get you started. This is optional, you can also create your own data.
4. You can then run `bundle exec rails s` from the command line to run the server locally on port 3000. After running the server you can test the endpoints using an API development platform like [Postman](https://www.postman.com).
5. There are Rspec tests that can be ran against the models using `bundle exec rspec spec`.


## Technologies Used

  * PostgreSQL
  * Ruby on Rails
  * [bcrypt](https://rubygems.org/gems/bcrypt/versions/3.1.12) (for authentication)
  * [kaminari](https://github.com/kaminari/kaminari) (for pagination)
  
  
## API Endpoints

### `users`
* `GET /api/users/:user_name` - returns a user's feed given a user_name
  * A result includes a maximum of 25 posts, comments, and github events.
  * To see more results, use the pagination feature `/api/users/:user_name?page={page_number}`
  * Replace `{page_number}` with your desired page. By default, the first page is returned.
  
  * Example Response:
  ```
  {
    "id": 3,
    "user_name": “TestUser3”,
    "fname": “Test”,
    "lname": “User”,
    "avg_rating": 4,
    "gh_username": "elvinv123",
    "posts": [
        {
            "id": 6,
            "title": "hello",
            "body": “world”,
            "created_at": "2023-06-07T02:13:56.999Z",
            "author": {
                "id": 3,
                "user_name": "TestUser3”,
                "avg_rating": 4
            }
        }
    ],
    "comments": [
	 {
            "id": 6,
            "body": “Very Cool”,
            "created_at": "2023-06-07T02:13:56.999Z",
            "author": {
                "id": 3,
                "user_name": “TestUser3”,
                "avg_rating": 4
            }
        }
     ],
     “github_events”: [
	 {
            "id": "29545144720",
            "type": "CreateEvent",
            "repo": "elvinv123/fixd_coding_challenge",
            "payload": {
                "ref": "main",
                "ref_type": "branch",
                "master_branch": "main",
                "description": null,
                "pusher_type": "user"
            }
        }
     ]
  }

* `POST /api/users` - sign up
  * Example Request Body: (password minimum: 6 characters)
    ```
    {
        "user": {
            "user_name": "car_guy_123",
            "fname": "Jay",
            "lname": "Leno",
            "password": "1966miura",
            "gh_username": "jleno123"
        }
    }
    
    
### `session`
* `POST /api/session` - log in
  * Example Request Body:
  ```
  {
    "session":
    {
        "user_name": "jonnyappleseed",
        "password": "password",
    }
  }

* `DELETE /api/session` - log out


### `posts`
* `GET /api/posts/:id` - returns a post given a post_id
  * Example Response:
  ``` 
  {
        "id": 5,
        "title": “Hello”,
        "body": “World”,
        "created_at": "2023-06-07T02:13:55.522Z",
        "author": {
            "id": 3,
            "user_name": “TestUser3,
            "avg_rating": 4
        },
        "comments": [
            {
                "id": 5,
                "body": “Hey”,
                "created_at": "2023-06-07T05:00:24.125Z",
                "author": {
                    "id": 5,
                    "user_name": “TestUser5”,
                    "avg_rating": 2
                }
            }
        ]
    }

* `POST /api/posts/` - lets an authenticated user create a post
  * Example Request Body:
      ```
      {
          "post":
          {
              "title": "hello",
              "body": "world"
          }
      }
    
* `DELETE /api/posts/:id` - deletes a post given a post_id


### `comments`
* `POST /api/comments/`  - lets an authenticated user leave a comment on a post
  * Example Request Body:
      ```
      {
        "comment":
        {
            "post_id": 1,
            "body": "Very cool"
        }
      }
      
* `DELETE /api/comments/:id`  - removes a comment that the authenticated user authored

### `ratings`
* `POST /api/ratings/`  - lets an authenticated user set a rating for another user
  * Example Request Body:
     ```
     {
        "rating":
        {
            "rated_user_id": 2,
            "rating": 1
        }
    }


## Postgres Database Schema

### users
| column name  | data type | details  |
| ------------- | ------------- | ------------- |
| fname  | string  | not null |
| lname  | string  | not null |
| user_name  | string  | not null |
| session_token  | string  | not null |
| password_digest  | string  | not_null |
| gh_username  | string  |  |
| avg_rating  | float  |  |
| created_at  | datetime  | not null  |
| updated_at  | datetime  | not null  |
* index on session_token, user_name

### posts
| column name  | data type | details  |
| ------------- | ------------- | ------------- |
| title  | string  | not null  |
| body  | string  | not null  |
| author_id  | integer  | not null, foreign key  |
| created_at  | datetime  | not null  |
| updated_at  | datetime  | not null  |

### comments
| column name  | data type | details  |
| ------------- | ------------- | ------------- |
| body | string  | not null |
| post_id | integer  | not null, foreign key |
| author_id | integer  | not null, foreign key |
| created_at  | datetime  | not null  |
| updated_at  | datetime  | not null  |

### ratings
| column name  | data type | details  |
| ------------- | ------------- | ------------- |
| rating | integer | not null |
| author_id | integer | not null, foreign key |
| rated_user_id | integer | not null,  foreign key |
| created_at  | datetime  | not null  |
| updated_at  | datetime  | not null  |
