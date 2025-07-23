-- Prism Game Database Schema for sqlite

-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Resources table (iron, wood, stone, etc.)
CREATE TABLE resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Location types table (city, mine, farm, lumber, home, etc.)
CREATE TABLE location_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Locations table
CREATE TABLE locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    default_accessible BOOLEAN DEFAULT 0,
    location_type_id INTEGER NOT NULL,
    longitude REAL NOT NULL,
    latitude REAL NOT NULL,
    name TEXT,
    description TEXT,
    art TEXT, -- filename for ASCII art
    is_user_created BOOLEAN DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (location_type_id) REFERENCES location_types(id)
);

-- Users_locations junction table (tracks which locations users have access to)
CREATE TABLE users_locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    name TEXT, -- user's custom name for the location
    worker_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE,
    UNIQUE(user_id, location_id)
);

-- Homes table (special locations that are user's home base)
CREATE TABLE homes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_location_id INTEGER NOT NULL UNIQUE,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_location_id) REFERENCES users_locations(id) ON DELETE CASCADE
);

-- Workers table (prismkin)
CREATE TABLE workers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    user_locations_id INTEGER NOT NULL,
    religion TEXT,
    work_status BOOLEAN DEFAULT 1,
    injured BOOLEAN DEFAULT 0,
    strength INTEGER NOT NULL CHECK (strength >= 1 AND strength <= 10),
    intelligence INTEGER NOT NULL CHECK (intelligence >= 1 AND intelligence <= 10),
    speed INTEGER NOT NULL CHECK (speed >= 1 AND speed <= 10),
    faith INTEGER NOT NULL CHECK (faith >= 1 AND faith <= 10),
    luck INTEGER NOT NULL CHECK (luck >= 1 AND luck <= 10),
    loyalty INTEGER NOT NULL CHECK (loyalty >= 1 AND loyalty <= 10),
    charisma INTEGER NOT NULL CHECK (charisma >= 1 AND charisma <= 10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_locations_id) REFERENCES users_locations(id) ON DELETE CASCADE
);

-- Eggs table (unhatched workers)
CREATE TABLE eggs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    users_locations_id INTEGER NOT NULL,
    worker_id INTEGER, -- NULL until hatched
    discovery_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hatch_time TIMESTAMP,
    FOREIGN KEY (users_locations_id) REFERENCES users_locations(id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES workers(id) ON DELETE SET NULL
);

-- Task types table (mining, woodcutting, farming, resting, etc.)
CREATE TABLE task_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Workers_tasks table (tracks what workers are doing)
CREATE TABLE workers_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_type_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    worker_id INTEGER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    start_longitude REAL NOT NULL,
    start_latitude REAL NOT NULL,
    end_longitude REAL NOT NULL,
    end_latitude REAL NOT NULL,
    is_ongoing BOOLEAN DEFAULT 1,
    FOREIGN KEY (task_type_id) REFERENCES task_types(id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (worker_id) REFERENCES workers(id) ON DELETE CASCADE
);

-- Location_types_tasks junction table (which tasks can be performed at which location types)
CREATE TABLE location_types_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_type_id INTEGER NOT NULL,
    task_type_id INTEGER NOT NULL,
    FOREIGN KEY (location_type_id) REFERENCES location_types(id) ON DELETE CASCADE,
    FOREIGN KEY (task_type_id) REFERENCES task_types(id) ON DELETE CASCADE,
    UNIQUE(location_type_id, task_type_id)
);

-- Task_types_resources junction table (which resources can be produced by which tasks)
CREATE TABLE task_types_resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_type_id INTEGER NOT NULL,
    resource_id INTEGER NOT NULL,
    base_rate REAL NOT NULL CHECK (base_rate >= 0 AND base_rate <= 1), -- probability per minute
    FOREIGN KEY (task_type_id) REFERENCES task_types(id) ON DELETE CASCADE,
    FOREIGN KEY (resource_id) REFERENCES resources(id) ON DELETE CASCADE,
    UNIQUE(task_type_id, resource_id)
);

-- Locations_resources table (tracks resources stored at each location)
CREATE TABLE locations_resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_id INTEGER NOT NULL,
    resource_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 0 CHECK (quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE,
    FOREIGN KEY (resource_id) REFERENCES resources(id) ON DELETE CASCADE,
    UNIQUE(location_id, resource_id)
);

-- Create indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_locations_coords ON locations(latitude, longitude);
CREATE INDEX idx_users_locations_user ON users_locations(user_id);
CREATE INDEX idx_users_locations_location ON users_locations(location_id);
CREATE INDEX idx_workers_user_location ON workers(user_locations_id);
CREATE INDEX idx_workers_tasks_worker ON workers_tasks(worker_id);
CREATE INDEX idx_workers_tasks_location ON workers_tasks(location_id);
CREATE INDEX idx_workers_tasks_ongoing ON workers_tasks(is_ongoing);
CREATE INDEX idx_locations_resources_location ON locations_resources(location_id);
CREATE INDEX idx_eggs_user_location ON eggs(users_locations_id);
CREATE INDEX idx_eggs_unhached ON eggs(worker_id) WHERE worker_id IS NULL;

