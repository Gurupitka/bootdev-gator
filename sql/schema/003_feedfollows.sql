-- +goose Up
CREATE TABLE feed_follows (
    id UUID PRIMARY KEY,
    user_id UUID not null,
    feed_id UUID not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (feed_id) REFERENCES feeds(id) ON DELETE CASCADE,
    unique(user_id,feed_id)
);

-- +goose Down
drop table feed_follows