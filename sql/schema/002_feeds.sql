-- +goose Up
CREATE TABLE feeds (
name TEXT not null,
url TEXT not null unique,
user_id UUID not null,
id UUID PRIMARY KEY,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- +goose Down
DROP TABLE feeds;
