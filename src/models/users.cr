class User < Crecto::Model
  schema "users" do
    field :uuid, String, primary_key: true
    field :username, String
    field :password, String, virtual: true
    field :password_confirmation, String, virtual: true
    # has_many :posts, Post, dependent: :destroy
  end

  validate_required :username
  validate_format :username, /^[a-z0-9_]+$/
  validate_length :uuid, is: 36
  unique_constraint [:uuid, :username]

  validate "Passwords must match", ->(user: User) do
    user.password == user.password_confirmation
  end
end
