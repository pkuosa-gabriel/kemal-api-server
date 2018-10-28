class User < Crecto::Model
  schema "users" do
    field :uuid, String, primary_key: true
    field :username, String
    # has_many :posts, Post, dependent: :destroy
  end

  validate_required [:username]
  validate_format :username, /^[a-z0-9_]+$/
end