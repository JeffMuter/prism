DROP TABLE IF EXISTS resources CASCADE;
DROP TABLE IF EXISTS workers CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS nodes CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS objects CASCADE;
DROP TABLE IF EXISTS user_locations CASCADE;
DROP TABLE IF EXISTS worker_events CASCADE;
DROP TABLE IF EXISTS node_resources CASCADE;
DROP TABLE IF EXISTS worker_activities CASCADE;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE resources (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE workers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    religion VARCHAR(50),
    age INTEGER NOT NULL,
    name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    work_status BOOLEAN DEFAULT FALSE,
    injured BOOLEAN DEFAULT FALSE,
    strength INTEGER NOT NULL,
    intelligence INTEGER NOT NULL,
    faith INTEGER NOT NULL
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    location_type VARCHAR(50) NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    name TEXT,
    description TEXT,
    art TEXT
);

--includes visible global locations, and user's created nodes
 CREATE TABLE user_locations (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    location_id INTEGER NOT NULL REFERENCES locations(id),
    is_global BOOLEAN DEFAULT FALSE,
    visible BOOLEAN DEFAULT FALSE
);

CREATE TABLE global_locations (
    id SERIAL PRIMARY KEY,
    location_id INTEGER NOT NULL REFERENCES locations(id),
    available_on_start BOOLEAN DEFAULT FALSE
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    eventTime TIMESTAMP NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE worker_events (
    id SERIAL PRIMARY KEY,
    worker_id INTEGER NOT NULL REFERENCES workers(id),
    event_id INTEGER NOT NULL REFERENCES events(id)
);

CREATE TABLE worker_activities (
    id SERIAL PRIMARY KEY,
    worker_id INTEGER NOT NULL REFERENCES workers(id),
    start_location_id INTEGER NOT NULL REFERENCES locations(id),
    end_location_id INTEGER NOT NULL REFERENCES locations(id),
    type VARCHAR(50) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    start_latitude DOUBLE PRECISION NOT NULL,
    start_longitude DOUBLE PRECISION NOT NULL,
    destination_latitude DOUBLE PRECISION NOT NULL,
    destination_longitude DOUBLE PRECISION NOT NULL
);

CREATE TABLE node_resources (
  id SERIAL PRIMARY KEY,
  locations_id INTEGER NOT NULL REFERENCES locations(id),
  resource_id INTEGER NOT NULL REFERENCES resources(id)
);