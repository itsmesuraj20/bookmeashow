-- Initialize database schema

-- Create tables if they don't exist
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'USER',
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    locked BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_phone ON users(phone);

-- Add sample admin user (password: admin123)
INSERT INTO users (email, password, first_name, last_name, phone, role) 
VALUES ('admin@bookmeashow.com', '$2a$10$8J0L4qXqZ1Y5V3Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5', 'Admin', 'User', '1234567890', 'ADMIN')
ON CONFLICT (email) DO NOTHING;

-- Create sample data for testing
INSERT INTO users (email, password, first_name, last_name, phone, role)
VALUES ('user@test.com', '$2a$10$8J0L4qXqZ1Y5V3Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5Y5', 'Test', 'User', '9876543210', 'USER')
ON CONFLICT (email) DO NOTHING;
