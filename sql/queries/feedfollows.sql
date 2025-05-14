-- name: CreateFeedFollow :one
WITH inserted_feed_follow AS ( insert into feed_follows(id,user_id,feed_id,created_at, updated_at)
 values ($1,$2,$3,$4,$5) RETURNING *
)

SELECT iffy.*, f.name AS feed_name,u.name AS user_name
FROM inserted_feed_follow iffy
inner join users u on iffy.user_id = u.id
inner join feeds f on f.id = iffy.feed_id;

-- name: GetFeedsForUser :many
SELECT *, f.name as feed_name, u.name as user_name
FROM feed_follows ff
INNER JOIN feeds f on f.ID = ff.feed_id
INNER JOIN users u on ff.user_id = u.id
where ff.user_id = $1;

-- name: UnfollowFeed :exec
delete from feed_follows where user_id = $1 and feed_id = $2;