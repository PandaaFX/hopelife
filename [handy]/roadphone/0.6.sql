ALTER TABLE `roadphone_information` ADD crypto LONGTEXT NOT NULL;

DELETE FROM roadphone_messages;
ALTER TABLE `roadphone_messages` MODIFY `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP();
ALTER TABLE `roadphone_messages` ADD isRead int(11) NOT NULL DEFAULT 0;
ALTER TABLE `roadphone_contacts` ADD favourite int(2) NOT NULL DEFAULT 0;

DELETE FROM roadphone_yellowapp;
DELETE FROM roadphone_calls;
DELETE FROM roadphone_jobs;

ALTER TABLE `roadphone_calls` MODIFY `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP();
ALTER TABLE `roadphone_jobs` MODIFY `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP();
ALTER TABLE `roadphone_yellowapp` MODIFY `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP();

CREATE TABLE IF NOT EXISTS `roadphone_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(30) NOT NULL DEFAULT '0',
  `receiver` varchar(30) NOT NULL DEFAULT '0',
  `text` varchar(80) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `roadphone_mails` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(255) NOT NULL DEFAULT '0' COLLATE utf8_general_ci,
	`sender` VARCHAR(255) NOT NULL DEFAULT '0' COLLATE utf8_general_ci,
	`subject` VARCHAR(255) NOT NULL DEFAULT '0' COLLATE utf8_general_ci,
	`image` TEXT NULL DEFAULT NULL COLLATE utf8_general_ci,
	`message` TEXT NOT NULL COLLATE utf8_general_ci,
	`button` TEXT NULL DEFAULT NULL COLLATE utf8_general_ci,
	`time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
) COLLATE=utf8_general_ci ENGINE=InnoDB AUTO_INCREMENT=0;

CREATE TABLE IF NOT EXISTS `roadphone_twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `profilavatar` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `created` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `roadphone_twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_roadphone_twitter_tweets_roadphone_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_roadphone_twitter_tweets_roadphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `roadphone_twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_UNICODE_CI;

CREATE TABLE IF NOT EXISTS `roadphone_twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_roadphone_twitter_likes_roadphone_twitter_accounts` (`authorId`),
  KEY `FK_roadphone_twitter_likes_roadphone_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_roadphone_twitter_likes_roadphone_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `roadphone_twitter_accounts` (`id`),
  CONSTRAINT `FK_roadphone_twitter_likes_roadphone_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `roadphone_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;