get "/" do |env|
  env.response.content_type = "application/json"
  {status: "success", message: "Welcome to Kemal!"}.to_json
end

get "/about" do |env|
  env.response.content_type = "application/json"
  {status: "success", message: "This is a RESTful API server built on Kemal."}.to_json
end
