Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = true
Config.getSharedObject = 'esx:getSharedObject'
----------------------------------------------------------------
Config.Menu = 'NativeUI' -- Set to 'ESX' if you want ESX Menu || Set to 'NativeUI' if you want NativeUI || Read the Readme.md if you want to use ESX Menu
Config.AntiWeaponPunch = true -- Set false if you don't want to use this
Config.Animation = true -- Set false if you dont want an animation

Config.SavePlayer = {
	enable = true,
	version = '1.2' -- Set to '1.2' or 'legacy'
	-- !!! If you set 'version' to 'legacy' then please read the Readme.md !!!
}

Config.checkMaxAmmo = {
	enable = true, -- If set to false the Player can get more than Config.MaxAmmo bullets
 	maxAmmo = 250 -- Set the max. Ammo in Weapon
}

Config.Hotkey = {
	enable = true, -- Set to false if you dont want to use ammo Item by pressing a Key
	key = 45, -- default: 45 = R // https://docs.fivem.net/docs/game-references/controls/

	category = {
		enable = true, -- Set false if you want to use the weaclip item instead of category items like pistolclip
		item = 'weaclip' -- Set the item that you want to use
	}
}
----------------------------------------------------------------
-- !!! This function is clientside AND serverside !!!
-- Look for type == 'client' and type == 'server'
Config.Notification = function(src, type, xPlayer, message) -- xPlayer = ESX.GetPlayerFromId(src)
    if type == 'client' then -- clientside
        ESX.ShowNotification(message) -- replace this with your Notify
    elseif type == 'server' then -- serverside
        xPlayer.showNotification(message) -- replace this with your Notify
    end
end
---------------------------------------------------
Config.WeaponAmmoClips = { -- Will give this many bullets to player
	-- Items are used for all types of weapons
	['weaclip'] = 30,
	['weabox'] = 150,
	-- Items are used for only that kind of weapon type
	['pistolclip'] = 12,
	['smgclip'] = 30,
	['shotgunclip'] = 25,
	['rifleclip'] = 25,
	['mgclip'] = 50,
	['sniperclip'] = 15,
	['throwableclip'] = 5,

	-- CUSTOM ITEMS // Add them in server_items.lua
	['polweaclip'] = 30, -- All Weapontypes
	['polweabox'] = 150, -- All Weapontypes
}
----------------------------------------------------------------
-- Set true if you like to remove item when used
Config.Removeables = {
	-- Weapon Clips
	['weaclip'] = true,
	['weabox'] = true,
	['pistolclip'] = true,
	['smgclip'] = true,
	['shotgunclip'] = true,
	['rifleclip'] = true,
	['mgclip'] = true,
	['sniperclip'] = true,
	['throwableclip'] = true,
	-- Weapon Attachments
	Attachments = true,
	Attachment_Remover = false, -- recommended set to false
	-- Weapon Tints
	Color = true,

	-- CUSTOM ITEMS // Add them in server_items.lua
	['polweaclip'] = true,
	['polweabox'] = true,
}
----------------------------------------------------------------
-- Please don't TOUCH if you don't know what you are doing!!
Config.Weapons = {
	Pistols = {
		{weaponName = 'WEAPON_PISTOL', weaponHash = GetHashKey('WEAPON_PISTOL')},
		{weaponName = 'WEAPON_PISTOL_MK2', weaponHash = GetHashKey('WEAPON_PISTOL_MK2')},
		{weaponName = 'WEAPON_COMBATPISTOL', weaponHash = GetHashKey('WEAPON_COMBATPISTOL')},
		{weaponName = 'WEAPON_APPISTOL', weaponHash = GetHashKey('WEAPON_APPISTOL')},
		{weaponName = 'WEAPON_PISTOL50', weaponHash = GetHashKey('WEAPON_PISTOL50')},
		{weaponName = 'WEAPON_SNSPISTOL', weaponHash = GetHashKey('WEAPON_SNSPISTOL')},
		{weaponName = 'WEAPON_SNSPISTOL_MK2', weaponHash = GetHashKey('WEAPON_SNSPISTOL_MK2')},
		{weaponName = 'WEAPON_HEAVYPISTOL', weaponHash = GetHashKey('WEAPON_HEAVYPISTOL')},
		{weaponName = 'WEAPON_VINTAGEPISTOL', weaponHash = GetHashKey('WEAPON_VINTAGEPISTOL')},
		{weaponName = 'WEAPON_MARKSMANPISTOL', weaponHash = GetHashKey('WEAPON_MARKSMANPISTOL')},
		{weaponName = 'WEAPON_REVOLVER', weaponHash = GetHashKey('WEAPON_REVOLVER')},
		{weaponName = 'WEAPON_REVOLVER_MK2', weaponHash = GetHashKey('WEAPON_REVOLVER_MK2')},
		{weaponName = 'WEAPON_DOUBLEACTION', weaponHash = GetHashKey('WEAPON_DOUBLEACTION')},
		{weaponName = 'WEAPON_CERAMICPISTOL', weaponHash = GetHashKey('WEAPON_CERAMICPISTOL')},
		{weaponName = 'WEAPON_NAVYREVOLVER', weaponHash = GetHashKey('WEAPON_NAVYREVOLVER')},
		{weaponName = 'WEAPON_GADGETPISTOL', weaponHash = GetHashKey('WEAPON_GADGETPISTOL')},
	},
	SMGs = {
		{weaponName = 'WEAPON_MICROSMG', weaponHash = GetHashKey('WEAPON_MICROSMG')},
		{weaponName = 'WEAPON_SMG', weaponHash = GetHashKey('WEAPON_SMG')},
		{weaponName = 'weapon_smg', weaponHash = GetHashKey('WEAPON_SMG')},
		{weaponName = 'WEAPON_SMG_MK2', weaponHash = GetHashKey('WEAPON_SMG_MK2')},
		{weaponName = 'WEAPON_ASSAULTSMG', weaponHash = GetHashKey('WEAPON_ASSAULTSMG')},
		{weaponName = 'WEAPON_COMBATPDW', weaponHash = GetHashKey('WEAPON_COMBATPDW')},
		{weaponName = 'WEAPON_MACHINEPISTOL', weaponHash = GetHashKey('WEAPON_MACHINEPISTOL')},
		{weaponName = 'WEAPON_MINISMG', weaponHash = GetHashKey('WEAPON_MINISMG')},
	},
	Shotguns = {
		{weaponName = 'WEAPON_PUMPSHOTGUN', weaponHash = GetHashKey('WEAPON_PUMPSHOTGUN')},
		{weaponName = 'WEAPON_PUMPSHOTGUN_MK2', weaponHash = GetHashKey('WEAPON_PUMPSHOTGUN_MK2')},
		{weaponName = 'WEAPON_SAWNOFFSHOTGUN', weaponHash = GetHashKey('WEAPON_SAWNOFFSHOTGUN')},
		{weaponName = 'WEAPON_ASSAULTSHOTGUN', weaponHash = GetHashKey('WEAPON_ASSAULTSHOTGUN')},
		{weaponName = 'WEAPON_BULLPUPSHOTGUN', weaponHash = GetHashKey('WEAPON_BULLPUPSHOTGUN')},
		{weaponName = 'WEAPON_MUSKET', weaponHash = GetHashKey('WEAPON_MUSKET')},
		{weaponName = 'WEAPON_HEAVYSHOTGUN', weaponHash = GetHashKey('WEAPON_HEAVYSHOTGUN')},
		{weaponName = 'WEAPON_DBSHOTGUN', weaponHash = GetHashKey('WEAPON_DBSHOTGUN')},
		{weaponName = 'WEAPON_AUTOSHOTGUN', weaponHash = GetHashKey('WEAPON_AUTOSHOTGUN')},
		{weaponName = 'WEAPON_COMBATSHOTGUN', weaponHash = GetHashKey('WEAPON_COMBATSHOTGUN')},
	},
	Rifles = {
		{weaponName = 'WEAPON_ASSAULTRIFLE', weaponHash = GetHashKey('WEAPON_ASSAULTRIFLE')},
		{weaponName = 'WEAPON_ASSAULTRIFLE_MK2', weaponHash = GetHashKey('WEAPON_ASSAULTRIFLE_MK2')},
		{weaponName = 'WEAPON_CARBINERIFLE', weaponHash = GetHashKey('WEAPON_CARBINERIFLE')},
		{weaponName = 'WEAPON_CARBINERIFLE_MK2', weaponHash = GetHashKey('WEAPON_CARBINERIFLE_MK2')},
		{weaponName = 'WEAPON_ADVANCEDRIFLE', weaponHash = GetHashKey('WEAPON_ADVANCEDRIFLE')},
		{weaponName = 'WEAPON_SPECIALCARBINE', weaponHash = GetHashKey('WEAPON_SPECIALCARBINE')},
		{weaponName = 'WEAPON_SPECIALCARBINE_MK2', weaponHash = GetHashKey('WEAPON_SPECIALCARBINE_MK2')},
		{weaponName = 'WEAPON_BULLPUPRIFLE', weaponHash = GetHashKey('WEAPON_BULLPUPRIFLE')},
		{weaponName = 'WEAPON_BULLPUPRIFLE_MK2', weaponHash = GetHashKey('WEAPON_BULLPUPRIFLE_MK2')},
		{weaponName = 'WEAPON_COMPACTRIFLE', weaponHash = GetHashKey('WEAPON_COMPACTRIFLE')},
		{weaponName = 'WEAPON_MILITARYRIFLE', weaponHash = GetHashKey('WEAPON_MILITARYRIFLE')},
		{weaponName = 'WEAPON_HEAVYRIFLE', weaponHash = GetHashKey('WEAPON_HEAVYRIFLE')},
		{weaponName = 'WEAPON_TACTICALRIFLE', weaponHash = GetHashKey('WEAPON_TACTICALRIFLE')},
	},
	MGs = {
		{weaponName = 'WEAPON_MG', weaponHash = GetHashKey('WEAPON_MG')},
		{weaponName = 'WEAPON_COMBATMG', weaponHash = GetHashKey('WEAPON_COMBATMG')},
		{weaponName = 'WEAPON_COMBATMG_MK2', weaponHash = GetHashKey('WEAPON_COMBATMG_MK2')},
		{weaponName = 'WEAPON_GUSENBERG', weaponHash = GetHashKey('WEAPON_GUSENBERG')},
	},
	Snipers = {
		{weaponName = 'WEAPON_SNIPERRIFLE', weaponHash = GetHashKey('WEAPON_SNIPERRIFLE')},
		{weaponName = 'WEAPON_HEAVYSNIPER', weaponHash = GetHashKey('WEAPON_HEAVYSNIPER')},
		{weaponName = 'WEAPON_HEAVYSNIPER_MK2', weaponHash = GetHashKey('WEAPON_HEAVYSNIPER_MK2')},
		{weaponName = 'WEAPON_MARKSMANRIFLE', weaponHash = GetHashKey('WEAPON_MARKSMANRIFLE')},
		{weaponName = 'WEAPON_MARKSMANRIFLE_MK2', weaponHash = GetHashKey('WEAPON_MARKSMANRIFLE_MK2')},
		{weaponName = 'WEAPON_PRECISIONRIFLE', weaponHash = GetHashKey('WEAPON_PRECISIONRIFLE')},
	},
	Throwables = {
		{weaponName = 'WEAPON_FLAREGUN', weaponHash = GetHashKey('WEAPON_FLAREGUN')},
	}
}