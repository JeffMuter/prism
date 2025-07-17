PRAGMA foreign_keys = ON;  -- Enable foreign key support in SQLite

-- Create tables

-- Users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Resources table
CREATE TABLE resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

-- Locations table
CREATE TABLE locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    default_accessible BOOLEAN DEFAULT 1,
    location_type TEXT NOT NULL,
    longitude REAL NOT NULL,
    latitude REAL NOT NULL,
    name TEXT,
    description TEXT,
    art TEXT
);

-- Workers table
CREATE TABLE workers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    religion TEXT,
    age INTEGER NOT NULL,
    name TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    work_status BOOLEAN DEFAULT 0,
    injured BOOLEAN DEFAULT 0,
    strength INTEGER NOT NULL,
    intelligence INTEGER NOT NULL,
    faith INTEGER NOT NULL,
    user_locations_id INTEGER NOT NULL,
    travel_speed INTEGER DEFAULT 0 NOT NULL,
    work_speed INTEGER DEFAULT 0 NOT NULL,
    stamina INTEGER DEFAULT 0 NOT NULL,
    max_stamina INTEGER DEFAULT 10 NOT NULL,
    FOREIGN KEY (user_locations_id) REFERENCES users_locations(id)
);

-- Users_locations table
CREATE TABLE users_locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    named TEXT,
    worker_count INTEGER DEFAULT 0 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

-- Task_types table
CREATE TABLE task_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

-- Task_types_resources table
CREATE TABLE task_types_resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_type_id INTEGER,
    resource_id INTEGER,
    FOREIGN KEY (task_type_id) REFERENCES task_types(id),
    FOREIGN KEY (resource_id) REFERENCES resources(id)
);

-- Workers_tasks table
CREATE TABLE workers_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_type_id INTEGER,
    location_id INTEGER,
    worker_id INTEGER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_longitude REAL,
    start_latitude REAL,
    end_longitude REAL,
    end_latitude REAL,
    is_ongoing BOOLEAN,
    FOREIGN KEY (task_type_id) REFERENCES task_types(id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (worker_id) REFERENCES workers(id)
);

-- Location_types table
CREATE TABLE location_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

-- Location_types_tasks table
CREATE TABLE location_types_tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_type_id INTEGER,
    location_type_id INTEGER,
    FOREIGN KEY (task_type_id) REFERENCES task_types(id),
    FOREIGN KEY (location_type_id) REFERENCES location_types(id)
);

-- Locations_resources table
CREATE TABLE locations_resources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location_id INTEGER,
    resource_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (resource_id) REFERENCES resources(id)
);
