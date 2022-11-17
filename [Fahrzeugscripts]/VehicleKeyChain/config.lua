
Config = {}

-- set at least one to false, otherwise both menus will clash
--   and don't forget to comment the menu in the fxmanifest.lua if you don't use it!
--   Setting both to true does not work!
-- setting both to false results in no menu being usable at all
-- you can then just include the exports in your own menu if you have one
Config.useContextMenu = false
Config.useNativeUI = true

-- set to nil if you don't want to use the command
Config.lockCommand = "lock"
-- set to nil if you don't want to use the button (default 73, X)
Config.lockKey = 73

-- set to nil if you don't want to use the command
Config.keyMenuCommand = "keys"
-- set to nil if you don't want to use the button (default 311, K)
Config.keyMenuKey = 311

-- maximum distance (in meters) between the player and ContextMenu interaction point
Config.maxDistance = 5.0

-- number of items in a menu where vehicles should be separated into categories (only ContextMenu)
Config.subCategoryThreshhold = 10

-- you can define more keymakers by just adding additional entries
Config.Keymakers = {
	{
		-- ped model (yes, the ` symbols are correct)
		model = `s_m_m_autoshop_01`,
		-- position and heading vector4(x, y, z, heading)
		pos = vector4(170.33, -1799.13, 28.32, 313.0)
	},
}

-- if the vehicle owner should be able to give away his vehicle
Config.enableGiveAwayMasterKey = true

-- define costs for creating a new key and exchanging locks
Config.Costs = {
	newKey			= 500,
	exchangeLocks	= 5000
}

-- define job vehicles like this (this acts as a key for those vehicles)
--   models in ``
--   either exact plates or just a string that should be in the vehicles plate
--     e.g. "LSPD" will let a police officer lock/unlock any vehicle with the plate "LSPD1337" or "13LSPD37"
Config.JobVehicles = {
-- examples:
	["police"] = {
		models = {
			`lspdunm`,
			`bmwm5police_us3`,
			`polrevent`,
			`polmav`,
			`predator`,
			`SWAT_Royal_m7_2`,
			`riot`,
			`SCOUTLSPD`,
			`police`


		},
		plates = {
		}
	},
	--[[["ambulance"] = {
		models = {
			`RoyalDodgeRAMems`,
			`ambulance`,
			`dodgeems`,
			'rs615ambulance'

		},
		plates = {
			"LSMD"
		}
	},
	["taxi"] = {
		models = {
			`drafter`,
			'dubsta',
			'jugular',
			'revolter',
			'schafter2',
			'stretch',
			'taxi'
		},
		plates = {
			""
		}
	},
	["bloods"] = {
		models = {
			`drafter`,
			'gls63',
			'jugular',
			'revolter',
			'schafter2',
			'primo2',
			'sanchez2'
		},
		plates = {
			"bloods"
		}
	},
	["hitman"] = {
		models = {
			`CarbonRS`,
			'patriot',
			'tempesta',
			'windsor2'
		},
		plates = {
			""
		}
	},
	["lafam"] = {
		models = {
			`jugular`,
			'dubsta',
			'revolter',
			'schafter2'
		},
		plates = {
			""
		}
	},
	["mechanic"] = {
		models = {
			`flatbed`,
			'packer',
			'towtruck',
			'trflat'
		},
		plates = {
			"Bennys",
			"BennysTruck",
			"TowTruck",
			"Trailer"
		}
	},
	["orga"] = {
		models = {
			`dubsta`,
			'jugular',
			'revolter',
			'schafter2'
		},
		plates = {
			"orga"
		}
	},
	["orga"] = {
		models = {
			`dubsta`,
			'jugular',
			'revolter',
			'schafter2'
		},
		plates = {
			"orga",
			"ORGA"
		}
	},
	["oblocks"] = {
		models = {
			`bmx`,
			'dubsta',
			'revolter',
			'schafter2'
		},
		plates = {
			"oblocks"
		}
	},
	["club"] = {
		models = {
			`baller3`,
			'drafter',
			'jugular',
			'schafter2',
			'revolter'
		},
		plates = {
			"SNC"
		}
	},
	["soa"] = {
		models = {
			`dubsta`,
			'sanctus',
			'zombiea',
			'schafter2',
			'revolter'
		},
		plates = {
			"SOA"
		}
	},
	["yakuza"] = {
		models = {
			`dubsta`,
			`jugular`,
			`schafter2`,
			`revolter`
		},
		plates = {
			"yakuza"
		}
	},]]--
	
	
	["fib"] = {
		models = {
			`nm_amggtr`,
			`nm_rs6`,
			`nm_745`,
			`nm_amg`,
			`frogger2`,
			`fibheli`,
			`xls2poli`,
			`fibd2`,
			`fbi2`,
			`polschafter3`,
			`swat16fpiu`
		},
		plates = {
		}
	},
	["bauamt"] = {
		models = {
			`tractor2`

		},
		plates = {
			"BAUAMT"
		}
	},
}

-- this list allows specific vehicle models to be excluded from their keys being given away
Config.modelBlacklist = {
	--`bison`,
}

Config.Strings = {
	keymaker		= "Keymaker",

	helpText		= "Drücke ~INPUT_CONTEXT~ um mit dem Schlüsseldienst zu Sprechen.",

	lockNotif		= "Fahrzeug ~r~verschlossen",
	unlockNotif		= "Fahrzeug ~g~aufgeschlossen",

	createSuccess	= "Ein neuer Schlüssel wurde erstellt für %s.",
	createNoMoney	= "Nicht genug Geld dafür!",
	createFailed	= "Fehlgeschlagen %s!",

	giveSuccess		= "Schlüssel übergeben %s.",
	giveSuccessPly	= "Schlüssel bekommen %s.",
	giveFailed		= "Fehlgeschlagen %s !",

	giveMasterSuccess		= "Hauptschlüssel übergeben %s .",
	giveMasterSuccessPly	= "Hauptschlüssel bekommen %s .",
	giveMasterFailed		= "Fehlgeschlagen %s !",

	removeSuccess	= "Entfernt einen Schlüssel %s .",
	removeNoMoney	= "Nicht genug Geld für neue Schlösser!",
	removeFailed	= "Fehlgeschlagen %s!",

	deleteKeys		= "Schloss geändert und ALLE Schlüssel entfernt für deinen Wagen %s.",

	-- NativeUI
	NUI = {
		-- keymaker menu
		keymakerMenuTitle	= "Schlüsseldienst",
		keymakerMenuSub		= "~b~Lass Schlüssel nachmachen oder Schlösser Tauschen!",

		-- create key
		createKeyTitle		= "NEUER SCHLÜSSEL",
		createKeyDesc		= "Schlüssel für alle deine Fahrzeuge.",
		createVehicleKey	= "Erstelle Schlüssel für Fahrzeug %s Kennzeichen: %s.",

		-- invalidate Key
		invalKeyTitle		= "SCHLÖSSER AUSTAUSCHEN",
		invalKeyDesc		= "Tausche Schlösser an all deinen Fahrzeugen aus.",
		invalVehicleKey		= "Schloss getauscht für Fahrzeug %s Kennzeichen: %s.",

		-- key Inventory
		keyInventoryTitle	= "Autoschlüssel",
		keyInventorySub		= "~b~Verwalte deine Schlüssel!",

		-- master keys
		masterKeysTitle		= "Hauptschlüssel",
		masterKeysDesc		= "Zeigt eine Liste aller Fahrzeuge die du besitzt.",
		giveMasterKeyTitle	= "Gebe den Hauptschlüssel",
		giveMasterKeyDesc	= "Gebe den Hauptschlüssel UND das FAHRZEUG an die Person neben dir.",

		-- additional keys
		keysTitle			= "Ersatzschlüssel",
		keysDesc			= "Zeigt eine Liste aller Ersatzschlüssel die du besitzt.",
		giveKeyTitle		= "Gebe Ersatzschlüssel",
		giveKeyDesc			= "Gebe den Ersatzschlüssel an die Person neben dir.",
		removeKeyTitle		= "Wegwerfen",
		removeKeyDesc		= "Wirft den Schlüssel aus deinem Besitz.",
	},

	-- ContextMenu
	CM = {
		-- keymaker menu
		createKeyTitle		= "Schlüssel nachmachen",
		invalKeyTitle		= "Fahrzeugschloss tauschen",

		-- key inventory
		masterKeysTitle		= "Hauptschlüssel",
		keysTitle			= "Ersatzschlüssel",

		-- other player
		giveKey				= "Schlüssel geben",
		giveMasterKey		= "Hauptschlüssel geben",
		safetyConfirm		= "SICHER?",
		safetyConfirmYes	= "Ja, Übergebe das Fahrzeug"
	}
}

Config.VehicleClasses = {
	"Compacts",
	"Sedans",
	"SUVs",
	"Coupes",
	"Muscle",
	"Sports Classics",
	"Sports",
	"Super",
	"Motorcycles",
	"Off-Road",
	"Industrial",
	"Utility",
	"Vans",
	"Cycles",
	"Boats",
	"Helicopters",
	"Planes",
	"Service",
	"Emergency",
	"Military",
	"Commercial",
	"Trains"
}
