
Config = {}
Config.Locale = 'en'

Config.ItemName = 'zetony' -- The chip item in DB

Config.PrintClient = false -- Print on client's console the spins in case of object bug
Config.Offset = true -- Add 30% propability to stop the spins in wrong position

Config.HideUI = true
Config.HideUIEvent = 'pma-voice:toggleui'
Config.ShowUIEvent = 'pma-voice:toggleui'

Config.Mult = { -- Multipliers based on GTA:ONLINE
	['1'] = 2,	
	['2'] = 5,
	['3'] = 10,
	['4'] = 20,
	['5'] = 40,
	['6'] = 80,
	['7'] = 100,
}

Config.Slots = {
	[1] = { -- Shoot First
		pos = vector3(-168.0387, -336.8055, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[2] = { -- Shoot First
		pos = vector3(-169.3252, -336.3372, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01b_reels',
	},
	[3] = { -- Shoot First
		pos = vector3(-166.7499, -337.2746, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02b_reels',
	},
	[4] = { -- Shoot First
		pos = vector3(-165.221, -332.9262, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[5] = { -- Shoot First
		pos = vector3(-166.5076, -332.4579, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[6] = { -- Shoot First
		pos = vector3(-167.7964, -331.9888, 57.80076),
		bet = 100,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
}




Config.Wins = { -- DO NOT TOUCH IT
	[1] = '2',
	[2] = '2',
	[3] = '2',
	[4] = '2',
	[5] = '2',
	[6] = '2',
	[7] = '6',
	[8] = '5',
	[9] = '2',
	[10] = '1',
	[11] = '3',
	[12] = '6',
	[13] = '7',
	[14] = '1',
	[15] = '4',
	[16] = '5',
}