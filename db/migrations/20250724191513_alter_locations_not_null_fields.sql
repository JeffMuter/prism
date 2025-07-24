-- +goose Up
-- Update any existing NULL values first
UPDATE locations
SET
  name = 'Unnamed Location'
WHERE
  name IS NULL;

UPDATE locations
SET
  description = 'No description'
WHERE
  description IS NULL;

UPDATE locations
SET
  art = 'default'
WHERE
  art IS NULL;

-- Create new table with NOT NULL constraints
CREATE TABLE locations_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  default_accessible BOOLEAN DEFAULT 0 NOT NULL,
  location_type_id INTEGER NOT NULL,
  longitude REAL NOT NULL,
  latitude REAL NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  art TEXT NOT NULL,
  is_user_created BOOLEAN DEFAULT 0 NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Copy data from old table
INSERT INTO
  locations_new
SELECT
  id,
  default_accessible,
  location_type_id,
  longitude,
  latitude,
  name,
  description,
  art,
  is_user_created,
  created_at
FROM
  locations;

-- Drop old table and rename new one
DROP TABLE locations;

ALTER TABLE locations_new
RENAME TO locations;

-- Recreate any indexes you might have (add them if you have any)
-- CREATE INDEX idx_location_type ON locations(location_type_id);
-- etc.
-- +goose Down
-- Reverse by recreating the original table structure
CREATE TABLE locations_old (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  default_accessible BOOLEAN DEFAULT 0,
  location_type_id INTEGER NOT NULL,
  longitude REAL NOT NULL,
  latitude REAL NOT NULL,
  name TEXT,
  description TEXT,
  art TEXT,
  is_user_created BOOLEAN DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
  locations_old
SELECT
  id,
  default_accessible,
  location_type_id,
  longitude,
  latitude,
  name,
  description,
  art,
  is_user_created,
  created_at
FROM
  locations;

DROP TABLE locations;

ALTER TABLE locations_old
RENAME TO locations;
