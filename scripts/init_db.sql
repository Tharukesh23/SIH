-- Enable PostGIS extension (for spatial data support)
CREATE EXTENSION IF NOT EXISTS postgis;

-- Users table (tourists, responders, admins)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('tourist','responder','admin')),
    created_at TIMESTAMP DEFAULT now()
);

-- Locations table (GPS + metadata)
CREATE TABLE IF NOT EXISTS locations (
    id BIGSERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    geom geometry(Point, 4326) NOT NULL,
    speed FLOAT,
    heading FLOAT,
    timestamp TIMESTAMP DEFAULT now()
);

-- Incidents table (SOS, detected events)
CREATE TABLE IF NOT EXISTS incidents (
    id BIGSERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    incident_type TEXT NOT NULL,
    description TEXT,
    geom geometry(Point, 4326) NOT NULL,
    status TEXT DEFAULT 'open' CHECK (status IN ('open','assigned','resolved')),
    created_at TIMESTAMP DEFAULT now()
);

-- Incident evidence (photos, videos, files)
CREATE TABLE IF NOT EXISTS incident_evidence (
    id BIGSERIAL PRIMARY KEY,
    incident_id INT REFERENCES incidents(id) ON DELETE CASCADE,
    file_path TEXT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT now()
);

-- Indexes for faster geospatial queries
CREATE INDEX IF NOT EXISTS idx_locations_geom ON locations USING GIST (geom);
CREATE INDEX IF NOT EXISTS idx_incidents_geom ON incidents USING GIST (geom);

-- Insert a sample responder for testing
INSERT INTO users (name, email, password_hash, role)
VALUES ('Demo Responder', 'responder@example.com', 'hashed_password', 'responder')
ON CONFLICT DO NOTHING;
