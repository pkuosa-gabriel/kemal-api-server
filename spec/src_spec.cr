require "./spec_helper"

describe "GET /" do
  it "responses to /" do
    get "/"
    expected = {status: "success", message: "Welcome to Kemal!"}.to_json
    response.body.should eq expected
  end
end
