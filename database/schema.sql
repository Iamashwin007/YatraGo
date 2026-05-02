-- YatraGo Database Schema
-- Run this file once to set up the database

CREATE DATABASE IF NOT EXISTS yatrago;
USE yatrago;

-- -------------------------------------------------------
-- Users
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id         INT          PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    password   VARCHAR(255) NOT NULL,
    role       ENUM('admin','user') DEFAULT 'user',
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Default admin user  (password: admin123)
INSERT INTO users (name, email, password, role) VALUES
('Admin', 'admin@yatrago.com', '$2a$12$S6TyuAz7/oXkRYhyH0P1SOtcVMKPWzBKQcRP5Lsmjz0GwpHg8IF5q', 'admin');
