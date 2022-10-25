DROP TABLE IF EXISTS `phone_app_chat`;
DROP TABLE IF EXISTS`phone_calls`;
DROP TABLE IF EXISTS `phone_messages`;
DROP TABLE IF EXISTS `phone_users_contacts`;

ALTER TABLE `jobs` DROP IF EXISTS `isService`;
ALTER TABLE `jobs` DROP IF EXISTS `handyservice`;
ALTER TABLE `jobs` DROP IF EXISTS `hasapp`;
