DROP TABLE IF EXISTS `d-bitcoin`;
CREATE TABLE `d-bitcoin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext NOT NULL,
  `walletid` int(11) DEFAULT NULL,
  `bitcoin` decimal(18,9) DEFAULT NULL,
  `equipment` longtext,
  `transactions` longtext NOT NULL,
  `history` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `d-bitcoin-bitcoindata`;
CREATE TABLE `d-bitcoin-bitcoindata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(50) NOT NULL,
  `hour` int(11) NOT NULL,
  `minute` int(11) NOT NULL,
  `price` int(110) NOT NULL,
  `saverhytmus` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7421 DEFAULT CHARSET=utf8mb4;
