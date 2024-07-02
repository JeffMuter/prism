BEGIN;

INSERT INTO users (username, email, password) VALUES
('1', '1@gmail.com', '1'),
('2', '2@gmail.com', '2'),
('3', '3@gmail.com', '3');

INSERT INTO resources (name) VALUES
('wood'),
('stone'),
('food');

INSERT INTO locations (location_type, longitude, latitude, name, description, art) VALUES
('city', 39.9593017, -83.004456, 'Columbus', 'city node', 'node'),
('city', 39.101398, -84.512395, 'Cincinnati', 'city node', 'node'),
('city', 41.499748, -81.6935, 'Cleveland', 'small city', 'node'),
('forest node', 40.29, -83.065, 'firstNode', 'small node', 'node'),
('mine node', 39.46, -82.49, 'gem mine node', 'medium node', 'node'),
('fresh water node', 39.9344, -82.4653, 'lake node', 'small node', 'node');

INSERT INTO  user_locations (user_id, location_id, is_global, visible) VALUES
(1, 4, FALSE, TRUE),
(1, 5, FALSE, TRUE),
(1, 6, FALSE, TRUE);

INSERT INTO global_locations (location_id, available_on_start) VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE);
COMMIT;
