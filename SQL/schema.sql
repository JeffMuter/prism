DROP TABLE IF EXISTS resources CASCADE;
DROP TABLE IF EXISTS workers CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS user_locations CASCADE;
DROP TABLE IF EXISTS worker_events CASCADE;
DROP TABLE IF EXISTS node_resources CASCADE;
DROP TABLE IF EXISTS worker_activities CASCADE;


-- User table to store user information
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    password TEXT NOT NULL
);

-- Locations table to store locations
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    location_type INTEGER REFERENCES location_types(id),
    longitude INTEGER NOT NULL,
    latitude INTEGER NOT NULL,
    name TEXT,
    description TEXT,
    art TEXT,
    accessible BOOLEAN DEFAULT TRUE
);

-- User Locations table to associate users with locations
CREATE TABLE user_locations (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    location_id INTEGER REFERENCES locations(id)
);

-- Worker table to store worker details
CREATE TABLE workers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    religion TEXT,
    age INTEGER,
    work_status BOOLEAN,
    injured BOOLEAN,
    strength INTEGER,
    intelligence INTEGER,
    faith INTEGER,
    stamina INTEGER,
    max_stamina INTEGER,
    travel_speed INTEGER,
    work_speed INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Worker Tasks table to store tasks assigned to workers
CREATE TABLE worker_tasks (
    id SERIAL PRIMARY KEY,
    task_type_id INTEGER REFERENCES task_types(id),
    location_id INTEGER REFERENCES locations(id),
    worker_id INTEGER REFERENCES workers(id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_longitude INTEGER,
    start_latitude INTEGER,
    end_longitude INTEGER,
    end_latitude INTEGER,
    is_ongoing BOOLEAN
);

-- Events table to store events
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    name TEXT,
    time TIMESTAMP,
    longitude INTEGER,
    latitude INTEGER,
    description TEXT,
    art TEXT
);

-- Timelog table to log time-based entries
CREATE TABLE timelog (
    id SERIAL PRIMARY KEY,
    entity_id INTEGER,
    entity_type TEXT,
    latitude INTEGER,
    longitude INTEGER,
    time TIMESTAMP
);

-- Task Types table to store different types of tasks
CREATE TABLE task_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Location Types table to store different types of locations
CREATE TABLE location_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Location Type Resource table to associate resources with location types
CREATE TABLE location_type_resources (
    id SERIAL PRIMARY KEY,
    location_type_id INTEGER REFERENCES location_types(id),
    resource_id INTEGER REFERENCES resources(id)
);

-- Task Type Resource table to associate resources with task types
CREATE TABLE task_type_resources (
    id SERIAL PRIMARY KEY,
    task_type_id INTEGER REFERENCES task_types(id),
    resource_id INTEGER REFERENCES resources(id)
);

-- Resources table to store different resources
CREATE TABLE resources (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);
