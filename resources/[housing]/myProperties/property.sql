

CREATE TABLE IF NOT EXISTS `prop_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(60) DEFAULT NULL,
  `charactername` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `rented` int(11) DEFAULT NULL,
  `trusted` varchar(1000) DEFAULT NULL,
  `locked` int(11) DEFAULT 1,
  `deposit` int(11) DEFAULT 0,
  `blackMoneyDeposit` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1298 DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `prop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT NULL,
  `is_single` tinyint(1) DEFAULT NULL,
  `type` varchar(60) DEFAULT NULL,
  `is_buyable` tinyint(1) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `depends` varchar(60) DEFAULT NULL,
  `is_unique` tinyint(1) DEFAULT NULL,
  `hasGarage` tinyint(1) DEFAULT NULL,
  `garageSlots` int(11) DEFAULT NULL,
  `garageLocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb4;

DELETE FROM `prop`;

INSERT INTO `prop` (`id`, `name`, `label`, `entering`, `inside`, `room_menu`, `ipls`, `is_single`, `type`, `is_buyable`, `price`, `depends`, `is_unique`, `hasGarage`, `garageSlots`, `garageLocation`) VALUES
	(20, '2677WhispymoundDrive', '2677 Whispymound Drive', '{"x":119.2,"y":564.62,"z":183.96}', '{"x":117.21,"y":559.67,"z":184.3}', '{"x":122.17,"y":548.84,"z":180.5}', '[]', 1, 'House', 1, 1000000, '0', 1, 1, 4, '{"x":130.05,"rot":272.5,"z":183.4,"y":570.96}'),
	(21, '2874HillcrestAvenue', '2874 Hillcrest Avenue', '{"x":-853.15,"y":695.91,"z":148.79}', '{"x":-859.97,"y":691.07,"z":152.86}', '{"x":-855.23,"y":680.13,"z":149.05}', '[]', 1, 'House', 1, 1000000, '0', 1, 1, 6, '{"x":-863.24,"rot":333.11,"z":149.05,"y":699.67}'),
	(22, '3655WildOatsDrive', '3655 Wild Oats Drive', '{"x":-175.29,"y":502.37,"z":137.42}', '{"x":-174.23,"y":497.29,"z":137.67}', '{"x":-167.38,"y":487.78,"z":133.84}', '[]', 1, 'House', 1, 1000000, '0', 1, 1, 6, '{"x":-189.1,"rot":15.5,"z":134.4,"y":503.43}'),
	(23, '2862HillcrestAvenue', '2862 Hillcrest Avenue', '{"x":-686.07,"y":596.35,"z":143.64}', '{"x":-682.39,"y":592.65,"z":145.38}', '{"x":-671.59,"y":587.37,"z":141.57}', '[]', 1, 'House', 1, 1000000, '0', 0, 1, 6, '{"x":-685.64,"rot":65.62,"z":143.68,"y":604.36}'),
	(24, '2133MadWayneThunder', '2133 Mad Wayne Thunder', '{"x":-1294.4,"y":454.66,"z":97.52}', '{"x":-1289.97,"y":449.55,"z":97.9}', '{"x":-1286.31,"y":438.16,"z":94.09}', '[]', 1, 'House', 1, 1000000, '0', 1, 1, 4, '{"x":-1299.22,"rot":277.12,"z":97.57,"y":457.87}'),
	(25, '2868 Hillcrest Avenue', '2868 Hillcrest Avenue', '{"x":-752.81,"y":620.51,"z":142.59}', '{"x":-758.55,"y":618.94,"z":144.15}', '{"x":-767.49,"y":610.98,"z":140.33}', '[]', 1, 'House', 1, 1000000, '0', 0, 1, 6, '{"x":-752.21,"rot":288.56,"z":142.44,"y":628.5}'),
	(26, '2045NorthConkerAvenue', '2045 North Conker Avenue', '{"x":373.06,"y":428.48,"z":145.69}', '{"x":373.43,"y":423.41,"z":145.91}', '{"x":374.58,"y":411.65,"z":142.1}', '[]', 1, 'House', 1, 1000000, '0', 0, 1, 4, '{"z":143.12,"x":391.39,"rot":83.13,"y":432.14}'),
	(27, '2044NorthConkerAvenue', '2044 North Conker Avenue', '{"x":347.21,"y":440.86,"z":147.7}', '{"x":341.76,"y":437.84,"z":149.39}', '{"x":334.36,"y":428.34,"z":145.57}', '[]', 1, 'House', 1, 1000000, '0', 0, 1, 4, '{"x":354.76,"rot":108.86,"z":146.29,"y":438.04}'),
	(28, 'EclipseTower', 'Eclipse Tower', '{"x":-776.20,"y":313.54,"z":85.14}', '0', '0', '[]', 1, '0', 1, 0, 'Collector', 0, NULL, NULL, NULL),
	(29, 'EclipseTowerApartment', 'Eclipse Tower, Apt', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-784.81,"y":323.59,"z":212.0}', '{"x":-793.33,"y":326.62,"z":210.8}', '[]', 0, 'Apartment', 1, 525000, 'EclipseTower', 0, NULL, NULL, NULL),
	(30, 'EclipseTowerPenthouse', 'Eclipse Tower, Pnt', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-781.84,"y":323.68,"z":176.8}', '{"x":-761.08,"y":325.41,"z":170.61}', '[]', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(31, 'ModernPenthouse', 'Modern Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_01_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(32, 'StimmungsvollPenthouse', 'Moody Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_02_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(33, 'DynastischPenthouse', 'Vibrant Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_03_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(34, 'PraegnantPenthouse', 'Sharp Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_04_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(35, 'MonochromePenthouse', 'Monochrome Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_05_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(36, 'VerfuehrerischPenthouse', 'Seductive Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_06_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(37, 'MajestetischPenthouse', 'Regal Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_07_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(38, 'MaritimPenthouse', 'Aqua Penthouse', '{"x":-776.20,"y":313.54,"z":85.14}', '{"x":-774.21,"y":341.97,"z":196.69}', '{"x":-763.33,"y":329.09,"z":199.49}', 'apa_v_mp_h_08_b', 0, 'Penthouse', 1, 400000, 'EclipseTower', 0, NULL, NULL, NULL),
	(39, 'DellPerroHeights', 'Dell Perro Heights', '{"x":-1446.4,"y":-539.1,"z":34.74}', '0', '0', '[]', 1, '0', 1, 0, 'Collector', 0, NULL, NULL, NULL),
	(40, 'DellPerroHeightsApt ', 'Dell Perro Heights, Apt', '{"x":-1446.4,"y":-539.1,"z":34.74}', '{"x":-1452.42,"y":-540.32,"z":74.04}', '{"x":-1449.84,"y":-548.88,"z":72.84}', '[]', 0, 'Apartment', 1, 525000, 'DellPerroHeights', 0, NULL, NULL, NULL),
	(41, 'DellPerroHeightsPnt', 'Dell Perro Heights, Pnt', '{"x":-1446.4,"y":-539.1,"z":34.74}', '{"x":-1451.33,"y":-524.05,"z":69.65}', '{"x":-1467.42,"y":-537.1,"z":63.36}', '[]', 0, 'Penthouse', 1, 575000, 'DellPerroHeights', 0, NULL, NULL, NULL),
	(42, 'BondsLowApartment', 'Bonds, Apt', '{"x":329.1,"y":-800.87,"z":29.27}', '{"x":266.12,"y":-1007.05,"z":-100.95}', '{"x":259.76,"y":-1003.94,"z":-99.01}', '[]', 1, 'Wohnung', 1, 156000, '0', 0, NULL, NULL, NULL),
	(43, 'WeazelPlazaPnt', 'Weazel Plaze, Pnt', '{"x":-916.7,"y":-450.77,"z":39.6}', '{"x":-888.86,"y":-451.74,"z":95.46}', '{"x":-899.47,"y":-434.26,"z":89.26}', '[]', 1, 'Penthouse', 1, 575000, '0', 0, NULL, NULL, NULL),
	(44, 'TinselTower', 'Tinsel Tower, Apt', '{"x":-618.36,"y":36.37,"z":43.57}', '{"x":-603.21,"y":58.93,"z":98.2}', '{"x":-594.77,"y":56.14,"z":97.0}', '[]', 1, 'Apartment', 1, 525000, '0', 0, NULL, NULL, NULL),
	(45, 'ThePinkCage', 'Pink Cage Hotel', '{"x":314.88,"y":-227.43,"z":54.02}', '{"x":151.4,"y":-1007.46,"z":-99.0}', '{"x":152.29,"y":-1001.29,"z":-99.0}', '[]', 1, 'Hotel', 1, 40000, '0', 0, NULL, NULL, NULL),
	(48, 'RichardMajesticApartment', 'Richard Majestic, Apt', '{"x":-937.02,"y":-379.41,"z":38.96}', '{"x":-912.82,"y":-365.27,"z":114.27}', '{"x":-903.92,"y":-363.59,"z":113.07}', '[]', 1, 'Apartment', 1, 525000, '0', 0, NULL, NULL, NULL),
	(50, 'MiRd6085', '6085 Milton Road', '{"x":-658.87,"y":888.0,"z":229.24}', '{"x":-682.39,"y":592.65,"z":145.38}', '{"x":-671.59,"y":587.37,"z":141.57}', '[]', 1, 'House', 1, 20000, '0', 1, 1, 12, '{"x":-676.82,"rot":328.03,"z":230.58,"y":903.76}'),
	(51, 'LakeVWEst', 'Lake Vinewood Est', '{"x":-152.43,"y":911.2,"z":234.65}', '{"x":-174.23,"y":497.29,"z":137.67}', '{"x":-167.38,"y":487.78,"z":133.84}', '[]', 1, 'House', 1, 20000, '0', 1, 1, 12, '{"x":-159.41,"rot":225.41,"z":235.66,"y":926.16}'),
	(56, 'VWPowerSt', 'PowerSt 0702', '{"x":284.71,"y":47.19,"z":91.66}', '{"x":151.4,"y":-1007.46,"z":-99.0}', '{"x":152.29,"y":-1001.29,"z":-99.0}', '[]', 1, 'Hotel', 1, 320000, '0', 0, NULL, NULL, NULL),
	(57, 'LaPuGomaSt', 'La Puerta GomaSt', '{"x":-970.14,"y":-1431.4,"z":6.67}', '{"x":151.4,"y":-1007.46,"z":-99.0}', '{"x":152.29,"y":-1001.29,"z":-99.0}', '[]', 1, 'Hotel', 1, 320000, '0', 0, NULL, NULL, NULL),
	(58, 'Tahitian', 'The Tahitian', '{"x":-25.50,"y":-1556.38,"z":29.68}', '{"x":151.4,"y":-1007.46,"z":-99.0}', '{"x":152.29,"y":-1001.29,"z":-99.0}', '[]', 1, 'Hotel', 1, 320000, '0', 0, NULL, NULL, NULL),
	(67, 'WhDr3673', '3673 Whispymound Drive', '{"x":45.69,"y":556.71,"z":179.18}', '{"x":117.21,"y":559.67,"z":184.3}', '{"x":122.17,"y":548.84,"z":180.5}', '[]', 1, 'House', 1, 20000, '0', 1, 1, 4, '{"x":51.13,"rot":20.35,"z":180.3,"y":563.32}'),
	(68, 'MeSt', 'Melanoma St', '{"x":-1114.6,"y":-1579.04,"z":7.68}', '{"x":151.4,"y":-1007.46,"z":-99.0}', '{"x":152.29,"y":-1001.29,"z":-99.0}', '[]', 1, 'Hotel', 1, 320000, '0', 0, NULL, NULL, NULL),
	(69, '1018NRF', '1018 North Rockford', '{"x":-1973.91,"y":630.68,"z":121.54}', '{"x":-174.23,"y":497.29,"z":137.67}', '{"x":-167.38,"y":487.78,"z":133.84}', '[]', 1, 'House', 1, 320000, '0', 1, 1, 12, '{"x":-1974.33,"rot":247.2,"z":122.52,"y":623.52}'),
	(78, 'MazeBank', 'Maze Bank', '{"x":-68.4,"y":-800.57,"z":44.23}', '0', '0', '[]', 1, '0', 0, 0, 'Collector', 0, NULL, NULL, NULL),
	(79, 'MBO1', 'MB Executive Rich', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_02b', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(80, 'MBO2', 'MB Executive Cool', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_02c', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(81, 'MBO3', 'MB Executive Contrast', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_02a', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(82, 'MBO4', 'MB Old Spice Warm', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_01a', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(83, 'MBO5', 'MB Old Spice Classical', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_01b', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(84, 'MBO6', 'MB Old Spice Vintage', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_01c', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(85, 'MBO7', 'MB Power Broker Ice', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_03a', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(86, 'MBO8', 'MB Power Broker Conservative', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_03b', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(87, 'MBO9', 'MB Power Broker Polished', '{"x":-68.4,"y":-800.57,"z":44.23}', '{"x":-77.71,"y":-829.89,"z":243.39}', '{"x":-78.1,"y":-810.65,"z":243.39}', 'ex_dt1_11_office_03c', 0, 'Office', 1, 1200000, 'MazeBank', 0, NULL, NULL, NULL),
	(88, 'VespucciClubhouse', 'Vespucci Clubhouse', '{"x":-1134.61,"y":-1568.99,"z":4.41}', '{"x":997.64,"y":-3158.04,"z":-38.91}', '{"x":1009.89,"y":-3168.35,"z":-38.89}', '[]', 1, 'ClubHouse', 1, 200000, '0', 1, NULL, NULL, NULL);

ALTER TABLE `users` ADD COLUMN `last_property` VARCHAR(255);

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('property','Property',0)
;

INSERT INTO `datastore` (name, label, shared) VALUES
  ('property','Property',0)
;
