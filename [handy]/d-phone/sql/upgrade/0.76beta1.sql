DROP TABLE IF EXISTS `phone_gallery`;
CREATE TABLE `phone_gallery` (
  `id` int(15) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
