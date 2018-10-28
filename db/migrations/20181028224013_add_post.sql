-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE posts
(
  uuid VARCHAR(36) NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  PRIMARY KEY (uuid)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE posts;