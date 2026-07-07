-- Consolidado de schema base do Madu Gate (V1)
-- Fonte: database/migrations/001_initial.sql + 002_visitors_vehicles.sql

CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'resident' CHECK (role IN ('admin', 'resident', 'employee', 'visitor')),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS gates (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  location VARCHAR(200),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  last_opened_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS access_events (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
  gate_id BIGINT NOT NULL REFERENCES gates(id) ON DELETE RESTRICT,
  source VARCHAR(20) NOT NULL DEFAULT 'mobile' CHECK (source IN ('mobile', 'web', 'esp32')),
  status VARCHAR(20) NOT NULL CHECK (status IN ('opened', 'denied', 'failed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS refresh_tokens (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS visitors (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  document VARCHAR(30),
  phone VARCHAR(25),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS vehicles (
  id BIGSERIAL PRIMARY KEY,
  plate VARCHAR(10) NOT NULL UNIQUE,
  model VARCHAR(80),
  color VARCHAR(40),
  owner_name VARCHAR(120),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_access_events_user_id ON access_events(user_id);
CREATE INDEX IF NOT EXISTS idx_access_events_gate_id ON access_events(gate_id);
CREATE INDEX IF NOT EXISTS idx_access_events_created_at ON access_events(created_at DESC);
