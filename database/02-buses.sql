USE yatrago;

CREATE TABLE IF NOT EXISTS buses (
    id              INT          PRIMARY KEY AUTO_INCREMENT,
    bus_number      VARCHAR(20)  NOT NULL UNIQUE,
    operator_name   VARCHAR(100) NOT NULL,
    bus_type        ENUM('AC Deluxe','AC Sleeper','Non-AC','Tourist','Micro') NOT NULL,
    total_seats     INT          NOT NULL,
    amenities       VARCHAR(255),
    status          ENUM('active','maintenance','inactive') DEFAULT 'active',
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- sample data
INSERT INTO buses (bus_number, operator_name, bus_type, total_seats, amenities, status) VALUES
('BA-1-KHA-1234','Naya Yatayat','AC Deluxe',40,'WiFi, USB charging, Snacks','active'),
('BA-2-PA-5678','Sajha Yatayat','AC Sleeper',30,'WiFi, Blanket, Water','active'),
('GA-1-CHA-9999','Mountain Express','Non-AC',45,'Music system','maintenance');
