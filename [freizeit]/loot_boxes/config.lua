Config = {}
Config.UserLicense = "None"
Config["image_source"] = "nui://inventory/web/dist/assets/items/"
Config.CloseInventoryHudTrigger = "inventory:close"

Config["chance"] = {
	[1] = { name = "Common", rate = 50 },
	[2] = { name = "Rare", rate = 30 },
	[3] = { name = "Epic", rate = 10 },
	[4] = { name = "Unique", rate = 3} ,
	[5] = { name = "Legendary", rate = 1 },
}

Config["broadcast"] = true 
Config["broadcast_tier"] = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
}

Config["5mscriptscom"] = {
	["csgocase"] = {
		name = "Case #1",
		list = {
			{ item = "bread", amount=50 , tier = 3 },
			{ item = "water", amount=50 , tier = 3 },
			{ money = 250000, tier = 3 },
			{ money = 400000, tier = 3 },
			{ item = "gin", amount=5, tier = 2 },
			{ item = "tequila", amount=3, tier = 2 },
			{ item = "cocktail", amount=3, tier = 2 },
			{ item = "schrauben", amount=100, tier = 3 },
			{ item = "weabox", amount=20, tier = 3 },
			{ item = "bulletproof2", amount=20, tier = 3 },
			{ item = "telefonnummer", amount=1, tier = 5 },
			{ item = "shopauto", amount=1, tier = 5 },
			{ item = "csgocase", amount=1, tier = 1 },
			{ item = "zentorno", amount=1, tier = 4 },
			{ item = "caddy", amount=1, tier = 4 },
		}
	},
	

	["csgocase2"] = {
		name = "Case #2",
		list = {
			{ item = "bread", amount=5 , tier = 1 },
			{ money = 1000, tier = 2 },
			{ black_money = 1000, tier = 3 },
			{ item = "beer", amount=1, tier = 4 },
			{ item = "water", amount=1, tier = 4 },
			{ item = "gold", amount=3, tier = 1 },
		}
	},
}