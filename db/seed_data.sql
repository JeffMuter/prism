-- Seed data for development and production
-- This file is separate from migrations and can be loaded optionally

-- Add a test user
INSERT INTO users (username, email, password) VALUES 
    ('demo', 'demo@example.com', 'demo');

-- Add some user-created locations near Columbus, Ohio for demo
INSERT INTO locations(default_accessible, location_type_id, name, longitude, latitude, description, art, is_user_created) VALUES 
    (0, 2, 'Iron Mine Alpha', -82.1, 40.1, 'Demo iron mining operation', 'mountain', 1),
    (0, 3, 'Green Valley Farm', -82.2, 40.2, 'Demo farming settlement', 'node', 1),
    (0, 4, 'Lumber Camp Beta', -82.3, 40.3, 'Demo logging operation', 'node', 1),
    (0, 10, 'Demo Home Base', -82.9855, 39.9862, 'Demo home near Columbus', 'city_art', 1);

-- Note: The large cities dataset should be moved here from the migration
-- and loaded separately for production/demo environments