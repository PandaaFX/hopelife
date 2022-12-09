Config = {}

Config.UseOkokTextUI = true -- true = okokTextUI (I recommend you using this since it is way more optimized than the default ShowHelpNotification) | false = ShowHelpNotification

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.HideMinimap = true -- If true it'll hide the minimap when the Crafting menu is opened

Config.ShowBlips = false -- If true it'll show the crafting blips on the map

Config.ShowFloorBlips = true -- If true it'll show the crafting markers on the floor

Config.UseXP = false -- If you want to use the XP system or not

Config.MaxLevel = 20 -- Max level on the workbenches

Config.StartEXP = 100 -- First level XP

Config.LevelMultiplier = 1.2 -- How much the XP needed increases per level (1.05 = 5% | level 1 = 100 | level 2 = 205 | etc...)

Config.GiveXPOnCraftFailed = true -- If the player receives XP when he fails the craft of an item

Config.itemNames = { -- Format: id = label
	griff = 'Griff',
	lauf = 'Lauf',
	schaft = 'Schaft',
	WEAPON_KNUCKLE = 'Schlagring',
	WEAPON_SWITCHBLADE = 'Klappmesser',
	WEAPON_DOUBLEACTION = 'Revolver',
	WEAPON_MICROSMG = 'Micro SMG',
	WEAPON_SAWNOFFSHOTGUN = 'Abgesägte Schrotflinte',
	WEAPON_ASSAULTRIFLE = 'AK 47',
	WEAPON_COMPACTRIFLE = 'Kompaktgewehr',
	WEAPON_BULLPUPRIFLE = 'Bullpup Gewehr',
	WEAPON_MARKSMANRIFLE = 'Marksmangewehr',
	drug_lean = 'Lean',
	coke = 'Koks',
	coke_pooch = 'Kokspäckchen',
	drug_lsd = 'LSD',
	drug_meth = 'METH',
	heroin = 'Heroin',
	maische = 'Maische',
	grapperaisin = 'Trauben',
	winabis = 'Winabis',
	berriesjuice = 'Traubensaft',
	sekt = 'Sekt',
	champagne = 'Champagner',
	rotwein = 'Rotwein',
	weisswein = 'Weißwein',


	
}

Config.Crafting = {
		{
		coordinates = vector3(1344.514282, 4387.226563, 44.343628), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Waffenteile', -- Title
		tableID = 'Teile', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'lauf', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'schrauben', 114, true}, -- item/amount/if the item should be removed when crafting
					{'copper', 74, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
				'saints',
				'mg13',
				'outlaws',
				'soa',
				'bloods',
				'18th',
				'hoover',
				'vagos',
				'oblocks',
				},
			},

			
			{
				item = 'griff', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 25, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'schrauben', 108, true}, -- item/amount/if the item should be removed when crafting
					{'iron', 83, true},
				
			
				},
				job = { -- What jobs can craft this item in this workbench
				'saints',
				'mg13',
				'outlaws',
				'soa',
				'bloods',
				'18th',
				'hoover',
				'vagos',
				'oblocks',
				},
			},

			{
				item = 'schaft', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 30, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'schrauben', 107, true}, -- item/amount/if the item should be removed when crafting
					{'iron', 66, true},
				
			
				},
				job = { -- What jobs can craft this item in this workbench
					'saints',
					'mg13',
					'outlaws',
					'soa',
					'bloods',
					'18th',
					'hoover',
					'vagos',
				    'oblocks',
				},
			},



		},
	},

	{
		coordinates = vector3(5091.969238, -4682.953613, 2.404419), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Waffen', -- Title
		tableID = 'Herstellung', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'WEAPON_KNUCKLE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'griff', 2, true}, -- item/amount/if the item should be removed when crafting
					{'blueprint_knuckle', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					'',

				},
			},
			{
				item = 'WEAPON_SWITCHBLADE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'griff', 1, true}, -- item/amount/if the item should be removed when crafting
					{'blueprint_switchblade', 1, true},
					{'schaft', 1, true}, 

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_DOUBLEACTION', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 1, true}, 
					{'lauf', 2, true},
					{'griff', 1, true}, 
					{'blueprint_doubleaction', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_MICROSMG', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 3, true}, 
					{'lauf', 3, true},
					{'griff', 2, true}, 
					{'blueprint_microsmg', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_SAWNOFFSHOTGUN', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 2, true}, 
					{'lauf', 3, true},
					{'griff', 3, true}, 
					{'blueprint_sawnoffshotgun', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_ASSAULTRIFLE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 4, true}, 
					{'lauf', 3, true},
					{'griff', 3, true}, 
					{'blueprint_assultrifle', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_COMPACTRIFLE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 2, true}, 
					{'lauf', 3, true},
					{'griff', 2, true}, 
					{'blueprint_compactrifle', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_BULLPUPRIFLE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 4, true}, 
					{'lauf', 5, true},
					{'griff', 3, true}, 
					{'blueprint_bullpuprifle', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'WEAPON_MARKSMANRIFLE', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					 -- item/amount/if the item should be removed when crafting
					{'schaft', 10, true}, 
					{'lauf', 8, true},
					{'griff', 9, true}, 
					{'blueprint_marksmanrifle', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			}

			



		},
	},

	{
		coordinates = vector3(-1363.08, -756.03, 22.31), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Lean', -- Title
		tableID = 'Labor', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'drug_lean', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'applejuice', 1, true}, -- item/amount/if the item should be removed when crafting
					{'codeine', 1, true},
					{'ice', 1, true},

			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},




		},
	},
	{
		coordinates = vector3(1208.73, -3114.54, 5.55), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Koks', -- Title
		tableID = 'Labor', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'coke', -- Item id and name of the image
				amount = 3,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'koksblatt', 5, true},
					{'benzin', 3, true}, -- item/amount/if the item should be removed when crafting


			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},
			{
				item = 'coke_pooch', -- Item id and name of the image
				amount = 3,
				successCraftPercentage = 85, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'coke', 4, true}, -- item/amount/if the item should be removed when crafting
					

			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},




		},
	},

	{
		coordinates = vector3(92.9, 3755.4, 40.77), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'LSD', -- Title
		tableID = 'Labor', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'drug_lsd', -- Item id and name of the image
				amount = 3,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'hydrogen', 3, true},
					{'oxygen', 2, true},
					{'nitrogen', 2, true}, -- item/amount/if the item should be removed when crafting


			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},




		},
	},

	{
		coordinates = vector3(434.76, 6472.62, 28.77), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'METH', -- Title
		tableID = 'Labor', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'drug_meth', -- Item id and name of the image
				amount = 3,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'sodium_hydroxide', 1, true},
					{'pseudoefedrine', 3, true},
					{'carbon', 2, true}, -- item/amount/if the item should be removed when crafting


			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},




		},
	},
	
	{
		coordinates = vector3(722.55, 4189.35, 41.09), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'HEROIN', -- Title
		tableID = 'Labor', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'heroin', -- Item id and name of the image
				amount = 2,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'morphin', 4, true},
					{'essigsaure', 2, true}, -- item/amount/if the item should be removed when crafting


			
				},
				job = { -- What jobs can craft this item in this workbench
				'',
				},
			},




		},
	},
	{
		coordinates = vector3(-1889.643921,2050.562744, 140.808838), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Wein', -- Title
		tableID = 'Wein', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'winabis', -- Item id and name of the image
				amount = 2,
				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 2, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'maische', 4, true},
					{'weed_pooch', 2, true}, -- item/amount/if the item should be removed when crafting
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'maische', -- Item id and name of the image
				amount = 2,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 0, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'grapperaisin', 2, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'sekt', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 0, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'maische', 2, true},
					{'berriesjuice', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'champagne', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 0, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'maische', 2, true},
					{'berriesjuice', 1, true},
					{'grapperaisin', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'weisswein', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 0, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'grapperaisin', 1, true},
					{'maische', 3, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'rotwein', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 5, -- Time to craft (in seconds)
				levelNeeded = 0, -- What level he needs to craft this item
				xpPerCraft = 5, -- How much XP he receives after crafting this item
				recipe = { -- Recipe to craft it
					{'grapperaisin', 2, true},
					{'maische', 2, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
		},
	},
}
-- Config.Crafting = {
-- 	{
-- 		coordinates = vector3(-2062.997803, 3093.112061, 32.801514), -- coordinates of the table
-- 		radius = 1, -- radius of the table
-- 		maxCraftRadius = 5, -- if you are further it will stop the craft
-- 		showBlipRadius = 50,
-- 		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
-- 		tableName = 'Illegale', -- Title
-- 		tableID = 'Waffen', -- make a different one for every table with NO spaces
-- 		crafts = { -- What items are available for crafting and the recipe
-- 			{
-- 				item = 'WEAPON_KNUCKLE', -- Item id and name of the image
-- 				amount = 1,
-- 				successCraftPercentage = 75, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
-- 				isItem = true, -- if true = is item | if false = is weapon
-- 				time = 20, -- Time to craft (in seconds)
-- 				levelNeeded = 2, -- What level he needs to craft this item
-- 				xpPerCraft = 5, -- How much XP he receives after crafting this item
-- 				recipe = { -- Recipe to craft it
-- 					{'griff', 2, true}, -- item/amount/if the item should be removed when crafting
-- 					{'blueprint_knuckle', 1, true},
					

			
-- 				},
-- 				job = { -- What jobs can craft this item in this workbench
-- 					'hook'
-- 				},
-- 			},

			
			



-- 		},
-- 	},

	
-- }

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 3

Config.BotName = 'GamboBot' -- Write the desired bot name

Config.ServerName = 'Hopelife' -- Write your server's name

Config.IconURL = 'https://imgur.com/a/HBmBJKz' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.StartCraftWebhookColor = '16127'

Config.ConcludeCraftWebhookColor = '65352'

Config.AnticheatProtectionWebhookColor = '16776960'

Config.FailWebhookColor = '16711680'