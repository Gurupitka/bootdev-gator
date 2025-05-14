-- name: CreateUser :one
INSERT INTO users (id, created_at, updated_at, name)
VALUES (
    $1,
    $2,
    $3,
    $4
)
RETURNING *;

-- name: GetUser :one
SELECT *
FROM users
where name = $1; 

-- name: GetUserById :one
SELECT *
FROM users
where id = $1; 

-- name: DropAllUsers :exec
delete from users;

-- name: GetAllUsers :many
select * from users;