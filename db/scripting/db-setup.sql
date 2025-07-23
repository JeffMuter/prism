
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
-- Mines can do mining
INSERT INTO location_types_tasks (location_type_id, task_type_id) VALUES (2, 1);
-- Farms can do farming
INSERT INTO location_types_tasks (location_type_id, task_type_id) VALUES (3, 3);
-- Lumber camps can do woodcutting
INSERT INTO location_types_tasks (location_type_id, task_type_id) VALUES (4, 2);
-- Ports can do fishing
INSERT INTO location_types_tasks (location_type_id, task_type_id) VALUES (5, 4);
-- All locations can do resting
INSERT INTO location_types_tasks (location_type_id, task_type_id) 
SELECT id, 6 FROM location_types;

-- Set up which resources are produced by which tasks
-- Mining produces iron and stone
INSERT INTO task_types_resources (task_type_id, resource_id, base_rate) VALUES 
    (1, 1, 0.3),  -- mining -> iron (30% chance per minute)
    (1, 4, 0.5);  -- mining -> stone (50% chance per minute)

-- Woodcutting produces wood
INSERT INTO task_types_resources (task_type_id, resource_id, base_rate) VALUES 
    (2, 3, 0.7);  -- woodcutting -> wood (70% chance per minute)

-- Farming produces food
INSERT INTO task_types_resources (task_type_id, resource_id, base_rate) VALUES 
    (3, 5, 0.6);  -- farming -> food (60% chance per minute)

-- Add a test user (password should be hashed in production)
INSERT INTO users (username, email, password) VALUES 
    ('1', '1@gmail.com', '1');
