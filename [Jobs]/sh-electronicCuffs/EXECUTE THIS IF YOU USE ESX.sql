CREATE TABLE `sh_electroniccuffs` (
	`citizenId` VARCHAR(50) NOT NULL DEFAULT 'none' COLLATE 'utf8mb4_general_ci',
	`data` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`citizenId`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;