CREATE TABLE IF NOT EXISTS `job_xp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamID` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `xp` text COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `job_xp` (`id`, `steamID`, `xp`) VALUES
	(1, 'steam:11000010ac71ad7', '[{"type":"juice","amount":2}]');

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grapperaisin', 'Grapperaisin', 60, 0, 1),
	('weat', 'Weat', 60, 0, 1),
	('apple', 'Apple', 60, 0, 1),
	('tomatos', 'Tomatos', 60, 0, 1),
	('salad', 'Salad', 60, 0, 1),
	('stone', 'Stone', 60, 0, 1),
	('coal', 'Coal', 60, 0, 1),
	('silver', 'Silver', 60, 0, 1),
	('gold', 'Gold', 60, 0, 1),
	('mixedsalad', 'Mixed salad', 60, 0, 1),
	('applejuice', 'Apple juice', 60, 0, 1),
	('tomatojuice', 'Tomato juice', 60, 0, 1),
	('berriesjuice', 'Berries juice', 60, 0, 1),
	('flour', 'Flour', 60, 0, 1),
	('concrete', 'Concrete', 60, 0, 1),
	('coalingot', 'Coal ingot', 60, 0, 1),
	('silveringot', 'Silver ingot', 60, 0, 1),
	('goldingot', 'Gold ingot', 60, 0, 1),
	('ironbraclet', 'Iron braclet', 60, 0, 1),
	('goldrings', 'Golden rings', 60, 0, 1),
	('necklace', 'Necklace', 60, 0, 1);
	
