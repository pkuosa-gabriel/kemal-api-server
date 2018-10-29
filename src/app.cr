require "kemal"
require "json"
require "uuid"
require "pg"
require "crecto"

require "./db"
require "./models/users"
require "./models/posts"

OK = "ok"

module Rest
  Query = Crecto::Repo::Query

  before_all "/*" do |env|
    puts "Setting response content type"
    env.response.content_type = "application/json"
  end

  get "/" do |env|
    {status: OK, message: "Welcome to Kemal!"}.to_json
  end

  get "/about" do |env|
    {status: OK, message: "This is a RESTful API server built on Kemal."}.to_json
  end

  get "/api/v1/users" do |env|
    query = Query.order_by("username ASC")
    {status: OK, data: Repo.all(User, query)}.to_json
  end

  get "/api/v1/users/:username" do |env|
    username = env.params.url["username"]
    query = Query.where(username: username)
    user = Repo.all(User, query)
    if user.size == 0
      halt env, status_code: 404, response: "user not found".to_json
    end
    {status: OK, data: user}.to_json
  end

  post "/api/v1/signup" do |env|
    user = User.new
    user.uuid = UUID.random.to_s
    user.username = env.params.json["username"].as(String)
    changeset = Repo.insert(user)
    if !changeset.valid?
      halt env, status_code: 400, response: "error signing up".to_json
    end
    {status: OK}.to_json
  end

  get "/api/v1/posts" do |env|
    query = Query.order_by("title ASC")
    {status: OK, data: Repo.all(Post, query)}.to_json
  end

  get "/api/v1/posts/:uuid" do |env|
    uuid = env.params.url["uuid"]
    query = Query.where(uuid: uuid)
    post = Repo.all(Post, query)
    if post.size == 0
      halt env, status_code: 404, response: "post not found".to_json
    end
    {status: OK, data: post}.to_json
  end

  post "/api/v1/posts" do |env|
    post = Post.new
    post.uuid = UUID.random.to_s
    post.title = env.params.json["title"].as(String)
    post.content = env.params.json["content"].as(String)
    changeset = Repo.insert(post)
    if !changeset.valid?
      halt env, status_code: 400, response: "error posting post".to_json
    end
    {status: OK}.to_json
  end

  patch "/api/v1/posts/:uuid" do |env|
    uuid = env.params.url["uuid"]
    query = Query.where(uuid: uuid)
    if Repo.all(Post, query).size == 0
      halt env, status_code: 404, response: "post not found".to_json
    else
      post = Repo.all(Post, query)[0]
    end
    post.title = env.params.json["title"].as(String)
    post.content = env.params.json["content"].as(String)
    changeset = Repo.update(post)
    if !changeset.valid?
      halt env, status_code: 400, response: "error patching post".to_json
    end
    {status: OK}.to_json
  end

  delete "/api/v1/posts/:uuid" do |env|
    uuid = env.params.url["uuid"]
    query = Query.where(uuid: uuid)
    if Repo.all(Post, query).size == 0
      halt env, status_code: 404, response: "post not found".to_json
    else
      post = Repo.all(Post, query)[0]
    end
    changeset = Repo.delete(post)
    if !changeset.valid?
      halt env, status_code: 400, response: "error deleting post".to_json
    end
    {status: OK}.to_json
  end
end

module WebSocket
  ws "/" do |socket|
    # Send welcome message to the client
    socket.send "Hello from Kemal!"

    # Handle incoming message and echo back to the client
    socket.on_message do |message|
      socket.send "Echo back from server #{message}"
    end

    # Executes when the client is disconnected. You can do the cleaning up here.
    socket.on_close do
      puts "Closing socket"
    end
  end
end

Kemal.run
