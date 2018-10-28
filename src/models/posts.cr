class Post < Crecto::Model
  schema "posts" do
    field :uuid, String, primary_key: true
    field :title, String
    field :content, String
  end
end