require "crecto"
require "faker"
require "pg"
require "uuid"

require "../../src/db"
require "../../src/models/users"

10.times do
  user = User.new
  user.uuid = UUID.random.to_s
  user.username = Faker::Name.first_name.downcase + "_" + Faker::Name.last_name.downcase
  changeset = Repo.insert(user)
end