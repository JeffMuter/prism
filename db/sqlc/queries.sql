-- name: GetVisibleLocationsByUser :many
SELECT * FROM locations l LEFT JOIN users_locations ul ON l.id = ul.location_id WHERE ul.user_id = ? OR l.default_accessible = TRUE;

-- Tasks queries
-- name: CreateWorkerTask :exec
INSERT INTO workers_tasks (task_type_id, location_id, worker_id, start_time, start_longitude, start_latitude, end_longitude, end_latitude, is_ongoing) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

-- name: GetTaskTypes :many
SELECT name FROM task_types;

-- name: EndWorkerTask :exec
UPDATE workers_tasks SET is_ongoing = false, end_time = ? WHERE worker_id = ?;

-- name: GetOngoingTasksByLocation :many
SELECT wt.id, w.name, tt.name, wt.start_time
FROM workers_tasks wt 
RIGHT JOIN task_types tt ON wt.task_type_id = tt.id
RIGHT JOIN workers w ON wt.worker_id = w.id
WHERE wt.location_id = ? AND wt.end_time IS NULL;

-- name: GetTaskTypesForLocation :many
SELECT tt.id, tt.name 
FROM locations l 
JOIN location_types_tasks ltt ON l.location_type_id = ltt.location_type_id 
JOIN task_types tt ON ltt.task_type_id = tt.id 
WHERE l.id = ?;

-- name: GetOngoingTaskResourceRates :many
SELECT r.name, ttr.base_rate 
FROM workers_tasks wt 
JOIN task_types tt ON wt.task_type_id = tt.id 
JOIN task_types_resources ttr ON tt.id = ttr.task_type_id 
JOIN resources r ON ttr.resource_id = r.id 
WHERE wt.location_id = ? AND wt.is_ongoing = TRUE;

-- Resources queries
-- name: GetLocationResources :many
SELECT r.id, r.name, lr.quantity, lr.last_updated 
FROM locations_resources lr 
JOIN resources r ON r.id = lr.resource_id 
WHERE lr.location_id = ?;

-- name: UpdateLocationResource :exec
UPDATE locations_resources 
SET last_updated = ?, quantity = ? 
WHERE location_id = ? AND resource_id = ?;

-- name: CreateLocationResource :exec
INSERT INTO locations_resources (location_id, resource_id, last_updated, quantity) 
VALUES (?, ?, ?, ?);

-- name: GetResourceIdByName :one
SELECT id FROM resources WHERE name = ?;

-- Home queries
-- name: SetLocationTypeToHome :exec
UPDATE locations SET location_type_id = 10 WHERE id = ?;

-- name: UpdateUserLocationName :exec
UPDATE users_locations SET name = ? WHERE location_id = ?;

-- name: CreateHome :exec
INSERT INTO homes (user_location_id, name) VALUES (?, ?);

-- Egg queries
-- name: CreateEgg :exec
INSERT INTO eggs (users_locations_id, discovery_time) VALUES (?, ?);

-- name: GetEggUserLocationId :one
SELECT users_locations_id FROM eggs WHERE id = ?;

-- name: CreateWorker :one
INSERT INTO workers (name, user_locations_id, religion, strength, intelligence, speed, faith, luck, loyalty, charisma) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id;

-- name: UpdateEggAfterHatch :exec
UPDATE eggs SET hatch_time = ?, worker_id = ? WHERE id = ?;

-- name: CreateWorkerTask :exec
INSERT INTO workers_tasks (task_type_id, location_id, worker_id, start_time) 
VALUES (?, ?, ?, ?);

-- name: GetAvailableEggsForUser :many
SELECT e.id, ul.name 
FROM eggs e 
JOIN users_locations ul ON ul.id = e.users_locations_id 
JOIN users u ON u.id = ul.user_id 
JOIN locations l ON ul.location_id = l.id 
WHERE u.id = ? AND e.worker_id IS NULL;

-- User queries
-- name: GetUserByEmail :one
SELECT id, username, email, password FROM users WHERE email = ?;

-- Worker queries
-- name: GetWorkersByUser :many
SELECT w.id, w.name, w.religion, w.work_status, w.injured, w.intelligence, w.strength, w.faith, ul.name, ul.id, ul.location_id  
FROM workers w
LEFT JOIN users_locations ul ON w.user_locations_id = ul.id 
WHERE ul.user_id = ?;

-- name: GetWorkersByLocation :many
SELECT w.id, w.name, w.religion, w.work_status, w.injured, w.intelligence, w.strength, w.faith, ul.name, ul.id, ul.user_id, ul.location_id, tt.name
FROM workers w
JOIN users_locations ul ON w.user_locations_id = ul.id
RIGHT JOIN workers_tasks wt ON w.id = wt.worker_id AND wt.end_time IS NULL
LEFT JOIN task_types tt ON wt.task_type_id = tt.id
WHERE ul.location_id = ?;

-- name: GetUserLocationIdByLocationId :one
SELECT id FROM users_locations WHERE location_id = ?;

-- name: UpdateWorkerLocation :exec
UPDATE workers SET user_locations_id = ? WHERE id = ?;

-- name: ToggleWorkerStatus :exec
UPDATE workers SET work_status = NOT work_status WHERE id = ?;

-- Location queries
-- name: CreateLocation :one
INSERT INTO locations (default_accessible, latitude, longitude, name, description, art, location_type_id, is_user_created) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id;

-- name: CreateUserLocation :one
INSERT INTO users_locations (user_id, location_id, name) VALUES (?, ?, ?) RETURNING id;

-- name: GetUnconnectedLocations :many
SELECT l.id, ul.name, l.latitude, l.longitude 
FROM locations l 
LEFT JOIN users_locations ul ON l.id = ul.location_id AND ul.user_id = ? 
WHERE ul.user_id IS NULL;

-- name: ConnectUserToLocation :one
INSERT INTO users_locations (user_id, location_id) VALUES (?, ?) RETURNING id;

-- name: GetUserLocations :many
SELECT l.id, ul.id, ul.worker_count, l.location_type_id, l.latitude, l.longitude, l.description, l.art, ul.name, lt.name, l.is_user_created
FROM locations l
JOIN users_locations ul ON l.id = ul.location_id 
JOIN location_types lt ON l.location_type_id = lt.id
WHERE ul.user_id = ?;

-- name: DecrementWorkerCount :exec
UPDATE users_locations SET worker_count = worker_count - 1 WHERE id = ?;

-- name: IncrementWorkerCount :exec
UPDATE users_locations SET worker_count = worker_count + 1 WHERE id = ?;

-- name: GetTaskTypesForLocationTypeId :many
SELECT tt.name 
FROM task_types tt 
JOIN location_types_tasks ltt ON tt.id = ltt.task_type_id 
JOIN location_types lt ON ltt.location_type_id = lt.id 
WHERE lt.id = ?;

-- name: GetLocationById :one
SELECT l.id, ul.id, l.location_type_id, l.latitude, l.longitude, ul.name, l.description, l.art 
FROM locations l
JOIN users_locations ul ON ul.location_id = l.id
WHERE l.id = ?;
