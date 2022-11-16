INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES ("society_unicorn", "Vanilla unicorn", 1);
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES ("society_unicorn", "Vanilla unicorn", 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
    ("society_unicorn", "Vanilla unicorn", 1),
    ("unicorn_bar", "Vanilla unicorn - bar", 1);

INSERT INTO `jobs` (`name`, `label`) VALUES ("unicorn", "Vanilla unicorn");

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
    ("unicorn", 0, "bouncer", "Türsteher", 100, "{}", "{}"),
    ("unicorn", 1, "bartender", "Barkeeper", 125, "{}", "{}"),
    ("unicorn", 2, "dancer", "Stripper", 150, "{}", "{}"),
    ("unicorn", 3, "boss", "Boss", 250, "{}", "{}");
