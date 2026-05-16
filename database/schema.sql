-- ============================================================
-- YatraGo — Complete Database Schema
-- Generated: 2026-05-03
--
-- Run this file once on a fresh MySQL instance to initialise
-- the entire YatraGo database with all tables and sample data.
--
-- Tables are ordered by foreign-key dependency:
--   independent tables first, dependent tables after.
--
-- Sample data is included for:
--   users, buses, routes, schedules, drivers
-- No sample data for:
--   bookings, booking_seats, payments  (populated at runtime)
-- ============================================================

CREATE DATABASE IF NOT EXISTS yatrago
    CHARACTER SET utf8mb4
    COLLATE       utf8mb4_unicode_ci;

USE yatrago;


-- ============================================================
-- 1. USERS
--    Stores customer accounts and the admin user.
--    role = 'admin'  →  access to the admin panel via AuthFilter.
--    role = 'user'   →  access to booking features (Milestone 2).
--    Passwords are hashed with BCrypt (12 salt rounds).
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id         INT          PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       ENUM('admin','user') NOT NULL DEFAULT 'user',
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Default admin account  (plain-text password: admin123)
INSERT INTO users (name, email, password, role) VALUES
('Admin', 'admin@yatrago.com',
 '$2a$12$S6TyuAz7/oXkRYhyH0P1SOtcVMKPWzBKQcRP5Lsmjz0GwpHg8IF5q',
 'admin');


-- ============================================================
-- 2. BUSES
--    Physical buses operated by Nepali transport companies.
--    bus_number follows Nepal vehicle registration format.
--    amenities is a free-text comma-separated list.
-- ============================================================
CREATE TABLE IF NOT EXISTS buses (
    id            INT          PRIMARY KEY AUTO_INCREMENT,
    bus_number    VARCHAR(20)  NOT NULL UNIQUE,
    operator_name VARCHAR(100) NOT NULL,
    bus_type      ENUM('AC Deluxe','AC Sleeper','Non-AC','Tourist','Micro') NOT NULL,
    total_seats   INT          NOT NULL,
    amenities     VARCHAR(255),
    status        ENUM('active','maintenance','inactive') NOT NULL DEFAULT 'active',
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO buses (bus_number, operator_name, bus_type, total_seats, amenities, status) VALUES
('BA-1-KHA-1234', 'Naya Yatayat',     'AC Deluxe',  40, 'WiFi, USB charging, Snacks', 'active'),
('BA-2-PA-5678',  'Sajha Yatayat',    'AC Sleeper',  30, 'WiFi, Blanket, Water',       'active'),
('GA-1-CHA-9999', 'Mountain Express', 'Non-AC',      45, 'Music system',               'maintenance');


-- ============================================================
-- 3. ROUTES
--    Origin–destination pairs with distance, typical duration,
--    and a base fare used as the default when creating schedules.
--    Actual schedule fare may differ (promotional pricing, etc.).
-- ============================================================
CREATE TABLE IF NOT EXISTS routes (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    origin         VARCHAR(100) NOT NULL,
    destination    VARCHAR(100) NOT NULL,
    distance_km    DECIMAL(6,2),
    duration_hours DECIMAL(4,2),
    base_fare      DECIMAL(8,2),
    status         ENUM('active','inactive') NOT NULL DEFAULT 'active',
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO routes (origin, destination, distance_km, duration_hours, base_fare, status) VALUES
('Kathmandu', 'Pokhara', 200.50, 6.50, 800.00, 'active'),
('Kathmandu', 'Chitwan', 150.00, 5.00, 600.00, 'active'),
('Pokhara',   'Lumbini', 175.00, 5.50, 700.00, 'active'),
('Kathmandu', 'Butwal',  280.00, 8.00, 900.00, 'active');


-- ============================================================
-- 4. SCHEDULES
--    A specific bus assigned to a specific route on a specific date.
--    available_seats decrements as bookings are confirmed.
--    Foreign keys reference buses and routes (must exist first).
-- ============================================================
CREATE TABLE IF NOT EXISTS schedules (
    id              INT          PRIMARY KEY AUTO_INCREMENT,
    bus_id          INT          NOT NULL,
    route_id        INT          NOT NULL,
    departure_time  TIME         NOT NULL,
    arrival_time    TIME         NOT NULL,
    journey_date    DATE         NOT NULL,
    fare            DECIMAL(8,2) NOT NULL,
    available_seats INT          NOT NULL,
    status          ENUM('scheduled','running','completed','cancelled') NOT NULL DEFAULT 'scheduled',
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_schedule_bus   FOREIGN KEY (bus_id)   REFERENCES buses(id),
    CONSTRAINT fk_schedule_route FOREIGN KEY (route_id) REFERENCES routes(id)
);

-- bus_id:   1 = BA-1-KHA-1234 (Naya Yatayat),  2 = BA-2-PA-5678 (Sajha Yatayat)
-- route_id: 1 = Kathmandu→Pokhara,  2 = Kathmandu→Chitwan,  3 = Pokhara→Lumbini
INSERT INTO schedules (bus_id, route_id, departure_time, arrival_time, journey_date, fare, available_seats, status) VALUES
(1, 1, '07:00:00', '13:30:00', '2026-05-10', 850.00, 38, 'scheduled'),
(2, 2, '08:30:00', '13:30:00', '2026-05-11', 650.00, 28, 'scheduled'),
(1, 3, '09:00:00', '14:30:00', '2026-05-12', 750.00, 40, 'scheduled');


-- ============================================================
-- 5. DRIVERS
--    Licensed drivers who operate buses.
--    bus_id is nullable — a driver may not be assigned to any
--    bus yet, or may be between assignments.
--    ON DELETE SET NULL preserves the driver record if the
--    assigned bus is removed.
-- ============================================================
CREATE TABLE IF NOT EXISTS drivers (
    id               INT         PRIMARY KEY AUTO_INCREMENT,
    name             VARCHAR(100) NOT NULL,
    license_number   VARCHAR(50)  NOT NULL UNIQUE,
    phone            VARCHAR(15)  NOT NULL,
    experience_years INT          NOT NULL DEFAULT 0,
    bus_id           INT,
    status           ENUM('active','inactive') NOT NULL DEFAULT 'active',
    created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_driver_bus FOREIGN KEY (bus_id) REFERENCES buses(id) ON DELETE SET NULL
);

INSERT INTO drivers (name, license_number, phone, experience_years, bus_id, status) VALUES
('Ram Prasad Sharma',  'DL-1234-2020', '9841234567', 5, 1,    'active'),
('Hari Bahadur Thapa', 'DL-5678-2019', '9852345678', 8, 2,    'active'),
('Bikram Gurung',      'DL-9012-2021', '9863456789', 3, NULL, 'active');


-- ============================================================
-- 6. BOOKINGS
--    A user's reservation for one or more seats on a schedule.
--    booking_reference is a short human-readable code shown
--    on the e-ticket (e.g. YG-20260510-0001).
--    total_fare = fare × passenger_count (plus any extras).
-- ============================================================
CREATE TABLE IF NOT EXISTS bookings (
    id                INT           PRIMARY KEY AUTO_INCREMENT,
    user_id           INT           NOT NULL,
    schedule_id       INT           NOT NULL,
    booking_reference VARCHAR(20)   NOT NULL UNIQUE,
    total_fare        DECIMAL(10,2) NOT NULL,
    passenger_count   INT           NOT NULL DEFAULT 1,
    booking_status    ENUM('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
    created_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_user     FOREIGN KEY (user_id)     REFERENCES users(id),
    CONSTRAINT fk_booking_schedule FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);


-- ============================================================
-- 7. BOOKING_SEATS
--    One row per passenger within a booking.
--    Cascades on booking deletion so orphan seat rows
--    are automatically removed.
-- ============================================================
CREATE TABLE IF NOT EXISTS booking_seats (
    id             INT          PRIMARY KEY AUTO_INCREMENT,
    booking_id     INT          NOT NULL,
    seat_number    INT          NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    passenger_age  INT,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_seat_booking FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);


-- ============================================================
-- 8. PAYMENTS
--    One payment record per booking (enforced by UNIQUE on
--    booking_id).  paid_at is NULL until payment completes.
--    Supports local Nepali payment methods alongside cash/card.
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
    id             INT           PRIMARY KEY AUTO_INCREMENT,
    booking_id     INT           NOT NULL UNIQUE,
    amount         DECIMAL(10,2) NOT NULL,
    payment_method ENUM('cash','card','esewa','khalti') NOT NULL DEFAULT 'cash',
    payment_status ENUM('pending','completed','failed','refunded') NOT NULL DEFAULT 'pending',
    transaction_id VARCHAR(100),
    paid_at        TIMESTAMP     NULL,
    created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- ============================================================
-- 9. EMERGENCY_ALERTS
--    Alerts raised by users (e.g. accident, breakdown) and
--    broadcast by admins. raised_by_user_id references the
--    user who raised the alert.
-- ============================================================
CREATE TABLE IF NOT EXISTS emergency_alerts (
                                                id                INT          PRIMARY KEY AUTO_INCREMENT,
                                                message           TEXT         NOT NULL,
                                                raised_by_user_id INT          NOT NULL,
                                                status            ENUM('active','resolved') NOT NULL DEFAULT 'active',
    created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_alert_user FOREIGN KEY (raised_by_user_id) REFERENCES users(id)
    );