USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police','Polizei',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police','Polizei',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Polizei', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'Polizei')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Rekrut',20,'{}','{}'),
	('police',1,'officer','Officier',40,'{}','{}'),
	('police',2,'sergeant','Sergent',60,'{}','{}'),
	('police',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('police',4,'boss','Commandant',100,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int DEFAULT NULL,
	`category` int DEFAULT NULL,

	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `fine_types` VALUES ('1', '§13.1 Fahren ohne Fahrerlaubnis', '10000', '0');
INSERT INTO `fine_types` VALUES ('2', '§13.2 Schwerer Eingriff in den Straßenverkehr', '10000', '0');
INSERT INTO `fine_types` VALUES ('3', '§13.3 Geschwindigkeitsüberschreitung 50-100', '5000', '0');
INSERT INTO `fine_types` VALUES ('4', '§13.4 Geschwindigkeitsüberschreitung 100+', '10000', '0');
INSERT INTO `fine_types` VALUES ('5', '§11.1 unerlaubter Waffenbesitz', '20000', '1');
INSERT INTO `fine_types` VALUES ('6', '§11.2 Benutzung unerlaubter Waffen', '35000', '1');
INSERT INTO `fine_types` VALUES ('7', '§11.3 Verkauf unerlaubter Waffen', '20000', '1');
INSERT INTO `fine_types` VALUES ('8', '§10.1 Herrstellen von Betäubungsmitteln', '30000', '2');
INSERT INTO `fine_types` VALUES ('9', '§10.2 Ankauf/Verkauf von Betäubungsmitteln', '20000', '2');
INSERT INTO `fine_types` VALUES ('10', '§10.3 Besitz von Betäubungsmitteln Menge -200', '15000', '2');
INSERT INTO `fine_types` VALUES ('11', '§10.4 Besitz von Betäubungsmitteln Menge +200', '30000', '2');
INSERT INTO `fine_types` VALUES ('12', '§2.1 Mord', '100000', '3');
INSERT INTO `fine_types` VALUES ('13', '§2.1.1 Versuchter Mord', '50000', '3');
INSERT INTO `fine_types` VALUES ('14', '§2.2 Totschlag', '80000', '3');
INSERT INTO `fine_types` VALUES ('15', '§2.2.1 Versuchter Totschlag', '40000', '3');
INSERT INTO `fine_types` VALUES ('16', '§2.3 Körperverletzung', '15000', '3');
INSERT INTO `fine_types` VALUES ('17', '§2.4 Gefährliche Körperverletzung', '30000', '3');
INSERT INTO `fine_types` VALUES ('18', '§2.6 Unterlassene Hilfeleistung', '10000', '3');
INSERT INTO `fine_types` VALUES ('19', '§3 Freiheitsberaubung', '20000', '3');
INSERT INTO `fine_types` VALUES ('20', '§3.1 Beamten Beleidigung', '15000', '3');
INSERT INTO `fine_types` VALUES ('21', '§3.1.1 Mehrfache Beamten Beleidigung ', '30000', '3');
INSERT INTO `fine_types` VALUES ('22', '§3.2 Erpressung', '30000', '3');
INSERT INTO `fine_types` VALUES ('23', '§3.3 Beleidigung', '10000', '3');
INSERT INTO `fine_types` VALUES ('24', '§3.4 Bedrohung', '20000', '3');
INSERT INTO `fine_types` VALUES ('25', '§3.5 Geiselnahme', '40000', '3');
INSERT INTO `fine_types` VALUES ('26', '§3.6 Nötigung', '10000', '3');
INSERT INTO `fine_types` VALUES ('27', '§3.7 Meineid', '50000', '3');
INSERT INTO `fine_types` VALUES ('28', '§4.1 Belästigung', '15000', '3');
INSERT INTO `fine_types` VALUES ('29', '§4.2 Sexuelle Belästigung', '30000', '3');
INSERT INTO `fine_types` VALUES ('30', '§4.3 Erregung öffentlichen Ärgernisses', '15000', '3');
INSERT INTO `fine_types` VALUES ('31', '§5.1 Diebstahl KFZ und Alg.', '20000', '3');
INSERT INTO `fine_types` VALUES ('32', '§5.2 Raub / Shop', '50000', '3');
INSERT INTO `fine_types` VALUES ('33', '§5.3 Schwerer Raub / Staatsbank oder Juwelier', '70000', '3');
INSERT INTO `fine_types` VALUES ('34', '§5.4 Betrug', '20000', '3');
INSERT INTO `fine_types` VALUES ('35', '§6.1 Leichte Sachbeschädigung', '20000', '3');
INSERT INTO `fine_types` VALUES ('36', '§6.1.1 Schwere Sachbeschädigung', '30000', '3');
INSERT INTO `fine_types` VALUES ('37', '§6.2 Widerstand gegen die Staatsgewalt', '18000', '3');
INSERT INTO `fine_types` VALUES ('38', '§6.3 Amtsanmaßung', '50000', '3');
INSERT INTO `fine_types` VALUES ('39', '§6.5 Tragen einer Vermummung', '10000', '3');
INSERT INTO `fine_types` VALUES ('40', '§6.6 Verweigerung der Identitätsfeststellung', '15000', '3');
INSERT INTO `fine_types` VALUES ('41', '§6.7 Betreten einer Sperrzone', '20000', '3');
INSERT INTO `fine_types` VALUES ('42', '§6.7.1 Durchbrechen von Absperrungen', '10000', '3');
INSERT INTO `fine_types` VALUES ('43', '§6.8 Verstoß gegen Auflagen', '40000', '3');
INSERT INTO `fine_types` VALUES ('44', '§7.1 Terroristischer Akt', '100000', '3');
INSERT INTO `fine_types` VALUES ('45', '§7.2 Gefangenenbefreiung', '40000', '3');
INSERT INTO `fine_types` VALUES ('46', '§7.3 Durchbrechen von PKW Absperrungen', '20000', '3');
INSERT INTO `fine_types` VALUES ('47', '§7.4 Korruption', '250000', '3');
INSERT INTO `fine_types` VALUES ('48', '§8.1 Besitz von Schwarzgeld', '30000', '3');
INSERT INTO `fine_types` VALUES ('49', '§8.2 Verkauf von Schwarzgeld', '60000', '3');
;
