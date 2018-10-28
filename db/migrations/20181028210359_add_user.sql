-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users
(
  uuid VARCHAR(36) NOT NULL,
  username VARCHAR(32) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  PRIMARY KEY (uuid)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE users;
