CREATE TABLE planes (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` CHAR(5),
    `description` TEXT,
    numFlying DECIMAL(8,1) )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO planes (`name`, `description`, numFlying)
VALUES
    ("A380", "Gros porteur", 12000),
    ("A320", "Avion de ligne quadriréacteur", 17000),
    ("A340", "Moyen Courrier", 50000);

ALTER TABLE pilots
ADD plane_id INT(6) UNSIGNED;

ALTER TABLE `pilots`
ADD CONSTRAINT `fk_pilots_planes`
FOREIGN KEY (`plane_id`) REFERENCES `planes`(`id`);

/* La colonne planes n'est pas dans la table pilots de la db_aviation donnée par le dump.
On utilise donc les noms des pilotes pour leur assigner le plane_id*/

UPDATE `pilots`
SET `plane_id` = 1
WHERE `name` = 'Tom' OR `name` = 'Jhon' OR `name` = 'Pierre';

UPDATE `pilots`
SET `plane_id` = 2
WHERE `name` = 'Yan' OR `name` = 'Yi';

UPDATE `pilots`
SET `plane_id` = 3
WHERE `name` = 'Alan' OR `name` = 'Sophie' OR `name` = 'Albert' OR `name` = 'Benoit';

CREATE TABLE trips (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` CHAR(10),
    departure CHAR(15),
    arrival CHAR(15),
    created DATETIME DEFAULT CURRENT_TIMESTAMP) 
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE pilot_trip (
    `certificate` VARCHAR(6) COLLATE utf8mb4_unicode_ci NOT NULL,
    trip_id INT(6) UNSIGNED,
    CONSTRAINT fk_certificate_pilots FOREIGN KEY (`certificate`) REFERENCES pilots(`certificate`),
    CONSTRAINT fk_id_trips FOREIGN KEY (`trip_id`) REFERENCES trips(id) )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;

INSERT INTO `trips`
(`name`, `departure`, `arrival`, `created`)
VALUES
('direct', 'Paris', 'Brest', '2020-01-01 00:00:00'),
('direct', 'Paris', 'Berlin', '2020-02-01 00:00:00'),
('direct', 'Paris', 'Barcelone', '2020-08-01 00:00:00'),
('direct', 'Amsterdan', 'Brest', '2020-11-11 00:00:00'),
('direct', 'Alger', 'Paris', '2020-09-01 00:00:00'),
('direct', 'Brest', 'Paris', '2020-12-01 00:00:00');

INSERT INTO `pilot_trip`
(`certificate`, `trip_id`)
VALUES
('ct-10', 1),
('ct-6', 2),
('ct-100', 1),
('ct-11', 3),
('ct-12', 4),
('ct-10', 4),
('ct-12', 5);

SELECT `certificate`, `name` FROM pilots
WHERE `certificate` NOT IN(
    SELECT `certificate` FROM pilot_trip);

SELECT * FROM pilot_trip
INNER JOIN trips ON pilot_trip.trip_id = trips.id;