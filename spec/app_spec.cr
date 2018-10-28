require "./spec_helper"

describe "Info routes" do
  it "responses to /" do
    get "/"
    JSON.parse(response.body)["message"].should eq "Welcome to Kemal!"
  end

  it "responses to /about" do
    get "/about"
    JSON.parse(response.body)["message"].should eq "This is a RESTful API server built on Kemal."
  end
end
