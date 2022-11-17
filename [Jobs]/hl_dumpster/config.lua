Config = {
	EnableWeapons = false, -- If you want the players to be able to find weapons (false by default).
	SearchTime = 10000, -- How much time it takes to search in millisecond.

	Dumpsters = { -- Props of the dumpsters wich is getting defined in the client.
		"prop_dumpster_01a",
		"prop_dumpster_02a",
		"prop_dumpster_02b",
		"prop_dumpster_4a",
		"prop_dumpster_3a",
		"prop_dumpster_4b",
		"prop_bin_02a",
		"prop_bin_05a",
		"prop_bin_01a"
	},

	Items = { -- Add whatever items you want here.
        "bottle",
        "water",
        "bread",
        "scratch_ticket",
		"gazbottle"
	},
	
	Weapons = { -- Add whatever weapons you want here (don't care about this if EnableWeapons = false).
        "WEAPON_KNIFE",
        "WEAPON_PISTOL"
    }
}

Strings = { -- Translation
	["Search"] = "Drücke [~g~E~s~] zum suchen",
	["Searched"] = "Bereits durchsucht!",
	["Found"] = "Was gefunden! ... ",
	["Searching"] = "Suchen...",
	["Nothing"] = "Nichts und jetzt stinkst du..."
}
