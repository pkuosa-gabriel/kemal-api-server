# TODO: Write documentation for `Src`
require "kemal"
require "json"

get "/" do |env|
  env.response.content_type = "application/json"
  {status: "success", message: "Welcome to Kemal!"}.to_json
end

Kemal.run
