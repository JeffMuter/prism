-- +goose Up
-- Insert initial data for resource types
INSERT INTO resources (name) VALUES 
    ('iron'),
    ('copper'),
    ('wood'),
    ('stone'),
    ('food'),
    ('gold');

-- Insert initial location types
INSERT INTO location_types (name) VALUES 
    ('node'),      -- 1: basic location type
    ('mine'),      -- 2: for mining resources
    ('farm'),      -- 3: for farming
    ('lumber'),    -- 4: for woodcutting
    ('port'),      -- 5: near water
    ('forest'),    -- 6: wooded areas
    ('mountain'),  -- 7: mountainous areas
    ('city'),      -- 8: major cities
    ('outpost'),   -- 9: small settlements
    ('home');      -- 10: user's home base

-- Insert initial task types
INSERT INTO task_types (name) VALUES 
    ('mining'),        -- 1
    ('woodcutting'),   -- 2
    ('farming'),       -- 3
    ('fishing'),       -- 4
    ('exploring'),     -- 5
    ('resting'),       -- 6
    ('building'),      -- 7
    ('traveling');     -- 8

-- Set up which tasks can be performed at which location types
INSERT INTO location_types_tasks (location_type_id, task_type_id) VALUES 
    (2, 1),  -- Mines can do mining
    (3, 3),  -- Farms can do farming
    (4, 2),  -- Lumber camps can do woodcutting
    (5, 4);  -- Ports can do fishing

-- All locations can do resting
INSERT INTO location_types_tasks (location_type_id, task_type_id) 
SELECT id, 6 FROM location_types;

-- Set up which resources are produced by which tasks
INSERT INTO task_types_resources (task_type_id, resource_id, base_rate) VALUES 
    (1, 1, 0.3),  -- mining -> iron
    (1, 4, 0.5),  -- mining -> stone
    (2, 3, 0.7),  -- woodcutting -> wood
    (3, 5, 0.6);  -- farming -> food

-- Add a test user
INSERT INTO users (username, email, password) VALUES 
    ('1', '1@gmail.com', '1');

-- +goose Down
DELETE FROM task_types_resources;
DELETE FROM location_types_tasks;
DELETE FROM task_types;
DELETE FROM location_types;
DELETE FROM resources;
DELETE FROM users WHERE username = '1';
