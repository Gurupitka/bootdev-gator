-- name: CreateFeed :one
INSERT INTO feeds (id,name,url,user_id) values ($1,$2,$3,$4) RETURNING *;

-- name: GetAllFeeds :many
select f.id, f.name,url,u.name as username from feeds f inner join users u on f.user_id = u.id;

-- name: GetFeedByUrl :one
select name,url,id from feeds where url = $1;

-- name: MarkFeedFetched :one
UPDATE feeds
SET last_fetched_at = NOW(),
updated_at = NOW()
WHERE id = $1
RETURNING *;

-- name: GetNextFeedToFetch :one
SELECT * FROM feeds
ORDER BY last_fetched_at ASC NULLS FIRST
LIMIT 1;