DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL,
  `caller` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `anonymous` int(1) NOT NULL DEFAULT 0,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `phone_information` ADD COLUMN `blocked` longtext  NULL;
