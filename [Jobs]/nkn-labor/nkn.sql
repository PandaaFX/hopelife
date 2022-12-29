-- Use this for the firsttime to create your table in your database

CREATE TABLE IF NOT EXISTS `nknlabor` (
  `laborname` varchar(8000) DEFAULT NULL,
  `owner` varchar(8000) DEFAULT NULL,
  `stash` longtext DEFAULT NULL,
  `process` longtext DEFAULT NULL,
  `progress` longtext DEFAULT NULL,
  UNIQUE KEY `laborname` (`laborname`,`owner`,`stash`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- To insert your Laboratory !!!!!!!!Make that the Key from config.lua for the Laboratory you want to insert is Exactly the same like 'LABORNAME', 
--!!!!!! Make sure that the owner is set to unowned at default. if you want to insert a already owned laboratory in your database change 'unowned' to the *Jobname you want to set the owner!

--EXAMPLE: !!!!!!

--This is the Laboratory you want to insert in your database

-- nkn.labore = {
--     ['vespucci_laboratory'] = {
--         coordsEnter = vector3(-1125.68, -1544.08, 5.38), 
--         coordsExit = vector3(-1112.3, -1578.39, 8.39),  
--         coordsWorkbench = vector3(-1104.06, -1591.84, 11.88), 
--         coordsRob = vector3(-1120.17, -1582.93, 8.68), 
--         routingBucket = 31,
--         craftableDrugs = {
--             ['phone'] = {
--                 requiedItems = 'medikit',
--                 requiedItemsAmount = 2,
--                 maxTimeToCraft = 300 -- inSeconds
--             }, 
--             ['medikit'] = {
--                 requiedItems = 'kokain',
--                 requiedItemsAmount = 2,
--                 maxTimeToCraft = 150-- inSeconds
--             }, 
--         },
--     },
-- }


--HOW TO INSERT
-- INSERT INTO `nknlabor` (`laborname`, `owner`, `stash`, `process`, `progress`) VALUES
-- 	('vespucci_laboratory', 'unowned', '[]', '[]', '[]');
