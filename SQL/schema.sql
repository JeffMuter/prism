DROP TABLE IF EXISTS users, objects, workers, resources, nodes, events, worker_events, worker_activities;

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
                         work_status BOOLEAN,
                         injured BOOLEAN NOT NULL,
                         strength INTEGER NOT NULL,
                         intelligence INTEGER NOT NULL,
                         faith INTEGER NOT NULL
);

CREATE TABLE objects (
                         id SERIAL PRIMARY KEY,
                         user_id INTEGER NOT NULL REFERENCES users(id),
                         object_id INTEGER,
                         object_type VARCHAR(30) NOT NULL,
                         longitude INTEGER NOT NULL,
                         latitude INTEGER NOT NULL,
                         name TEXT,
                         description TEXT,
                         art TEXT
);

CREATE TABLE nodes (
                       id SERIAL PRIMARY KEY,
                       user_id INTEGER NOT NULL REFERENCES users(id),
                       type VARCHAR(50) NOT NULL,
                       latitude DOUBLE PRECISION NOT NULL,
                       longitude DOUBLE PRECISION NOT NULL
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
                               worker_id INT NOT NULL REFERENCES workers(id),
                               event_id INT NOT NULL REFERENCES events(id)
);

CREATE TABLE worker_activites (
                                  id SERIAL PRIMARY KEY,
                                  worker_id INTEGER NOT NULL REFERENCES workers(id),
                                  node_id INTEGER NOT NULL REFERENCES nodes(id),
                                  type VARCHAR(50) NOT NULL,
                                  start_time TIMESTAMP NOT NULL,
                                  end_time TIMESTAMP NOT NULL,
                                  destination_latitude DOUBLE PRECISION NOT NULL,
                                  destination_longitude DOUBLE PRECISION NOT NULL
);