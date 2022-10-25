
CREATE TABLE IF NOT EXISTS `speedcams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(60) DEFAULT NULL,
  `society` varchar(100) DEFAULT NULL,
  `maxSpeed` int(11) DEFAULT NULL,
  `flashRange` int(11) DEFAULT NULL,
  `positionX` double DEFAULT NULL,
  `positionY` double DEFAULT NULL,
  `positionZ` double DEFAULT NULL,
  `heading` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `speedcams_profit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `radarID` int(11) DEFAULT NULL,
  `label` varchar(80) DEFAULT NULL,
  `totalProfit` int(11) DEFAULT NULL,
  `lastTime` varchar(50) DEFAULT NULL,
  `lastProfit` int(11) DEFAULT NULL,
  `lastUser` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
