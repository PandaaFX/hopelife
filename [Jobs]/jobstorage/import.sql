CREATE TABLE IF NOT EXISTS `tbm_job_storage`
(
    `id`          INT(11) NOT NULL AUTO_INCREMENT,
    `job`  VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `position`    VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `maxStorage`  INT(11) NOT NULL DEFAULT '0',
    `usedStorage` INT(11) NOT NULL DEFAULT '0',
    `level`       TINYINT(3) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `job_position` (`job`, `position`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `tbm_job_storage_items` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `storage_id` int(11) NOT NULL,
    `name` varchar(50) NOT NULL DEFAULT '',
    `label` varchar(50) NOT NULL,
    `count` int(5) NOT NULL DEFAULT 0,
    `isWeapon` tinyint(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`) USING BTREE
    ) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;

CREATE TABLE `tbm_job_storage_access` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `storage_id` INT(10) UNSIGNED NOT NULL,
  `job_grade_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `type` VARCHAR(20) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `storage_id_job_grade_id_type` (`storage_id`, `job_grade_id`, `type`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB;
