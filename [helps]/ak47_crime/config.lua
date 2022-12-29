Config = {}
Config.SharedObjectName = 'esx:getSharedObject'         --Change if you Shared Object Name is different
Config.Locale = 'en'

Config.CheckCanCarryItem = false

Config.Whitelistedjobs = {
	['police'] = true,
	['lssd'] = true,
	['fib'] = true,
}

Config.DamageChance = {
	cuff = 70,  -- 70%
	key = 70,	-- 70%
	blindfold = 70, --70%
}

Config.HandsUpAnimationData = {
	dir = 'missminuteman_1ig_2',
	anim = 'handsup_enter',
}

Config.UnTieWeapons = {
	[`weapon_dagger`] = true,
	[`weapon_knife`] = true,
	[`weapon_switchblade`] = true,
}

Config.BlindFold = {
	skinOn = {
		male = {
			mask_1 = 62, mask_2 = 0,
		},
		female = {
			mask_1 = 126, mask_2 = 0,
		},
	},
	skinOff = {
		male = {
			mask_1 = 0, mask_2 = 0,
		},
		female = {
			mask_1 = 0, mask_2 = 0,
		},
	},
}

