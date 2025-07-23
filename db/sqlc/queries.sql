-- name: GetVisibleLocationsByUser :many
SELECT * FROM locations l LEFT JOIN users_locations ul ON l.id = ul.location_id WHERE ul.user_id = ? OR l.default_accessible = TRUE;
