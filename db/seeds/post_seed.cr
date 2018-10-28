require "crecto"
require "faker"
require "pg"
require "uuid"

require "../../src/db"
require "../../src/models/posts"

10.times do
  post = Post.new
  post.uuid = UUID.random.to_s
  post.title = Faker::Lorem.sentence
  post.content = Faker::Lorem.paragraph
  changeset = Repo.insert(post)
end