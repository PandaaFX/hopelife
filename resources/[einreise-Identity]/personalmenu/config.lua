local Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57, 
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177, 
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70, 
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
	['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118
}

Config = {}

-- LANGUAGE --
Config.Locale = 'de'

-- GENERAL --
Config.MenuTitle = 'Hopelife' -- change it to you're server name
Config.DoubleJob = false -- enable if you're using esx double job
Config.NoclipSpeed = 2.0 -- change it to change the speed in noclip
Config.JSFourIDCard = true -- enable if you're using jsfour-idcard

-- CONTROLS --
Config.Controls = {
	OpenMenu = {keyboard = Keys['F5']},
	Pointing = {keyboard = Keys['B']},
	Crouch = {keyboard = Keys['LEFTCTRL']},
	StopTasks = {keyboard = Keys['X']},
	TPMarker = {keyboard1 = Keys['LEFTALT'], keyboard2 = Keys['E']}
}

-- ADMIN --
Config.Admin = {
	{
		name = 'rein',
		label = "Einreise",
		groups = {'dev', 'superadmin','support', 'admin', 'mod','cardev1','cardev2', 'guide'},
		command = function()
			ExecuteCommand("rein")

			RageUI.CloseAll()
		end
	},
	{
		name = 'raus',
		label = "Flughafen vor Eingang",
		groups = {'dev', 'superadmin','support', 'admin', 'mod', 'guide','cardev1','cardev2'},
		command = function()
			ExecuteCommand("raus")

			RageUI.CloseAll()
		end
	},
    {
		name = 'raus2',
		label = "Würfelpark Ostseite",
		groups = {'dev', 'superadmin','support', 'admin', 'mod', 'guide','cardev1','cardev2'},
		command = function()
			ExecuteCommand("raus2")

			RageUI.CloseAll()
		end
	},
    {
		name = 'raus3',
		label = "Paleto Bay",
		groups = {'dev', 'superadmin','support', 'admin', 'mod', 'guide','cardev1','cardev2'},
		command = function()
			ExecuteCommand("raus3")

			RageUI.CloseAll()
		end
	},
	{
		name = 'aduty',
		label = "Aduty",
		groups = {'dev', 'superadmin','support', 'admin', 'mod', 'cardev1', 'guide'},
		command = function()
			TriggerEvent("toggleDuty")
	        TriggerEvent("adminhl:c_godmodexyz")
			RageUI.CloseAll()			
		end
	},
	{
		name = 'noclip',
		label = _U('admin_noclip_button'),
		groups = {'dev', 'superadmin', 'admin', 'mod', 'cardev1'},
		command = function()
			Player.noclip = not Player.noclip
			if Player.noclip then
				FreezeEntityPosition(plyPed, true)
				SetEntityInvincible(plyPed, true)
				SetEntityCollision(plyPed, false, false)

				SetEntityVisible(plyPed, false, false)

				SetEveryoneIgnorePlayer(PlayerId(), true)
				SetPoliceIgnorePlayer(PlayerId(), true)
				ESX.ShowNotification(_U('admin_noclipon'))
                exports.logmanager:log{message = "personalmenu:noclipon"}
			else
				FreezeEntityPosition(plyPed, false)
				SetEntityInvincible(plyPed, false)
				SetEntityCollision(plyPed, true, true)

				SetEntityVisible(plyPed, true, false)

				SetEveryoneIgnorePlayer(PlayerId(), false)
				SetPoliceIgnorePlayer(PlayerId(), false)
				ESX.ShowNotification(_U('admin_noclipoff'))
                exports.logmanager:log{message = "personalmenu:noclipoff"}

			end

			RageUI.CloseAll()
		end
	},
    {
		name = 'unsichtbar',
		label = "Unsichtbar",
		groups = {'dev', 'superadmin', 'admin', 'mod'},
		command = function()
            Player.invisible = not Player.invisible
            if Player.invisible then
			    SetEntityInvincible(plyPed, true)

			    SetEntityVisible(plyPed, false, false)

			    SetEveryoneIgnorePlayer(PlayerId(), true)
			    SetPoliceIgnorePlayer(PlayerId(), true)
			    ESX.ShowNotification("Unsichtbar")
                exports.logmanager:log{message = "personalmenu:invisible"}
		    else
			    SetEntityInvincible(plyPed, false)

			    SetEntityVisible(plyPed, true, false)

			    SetEveryoneIgnorePlayer(PlayerId(), false)
			    SetPoliceIgnorePlayer(PlayerId(), false)
			    ESX.ShowNotification("Sichtbar")
                exports.logmanager:log{message = "personalmenu:visible"}
		    end

		    RageUI.CloseAll()
        end
	},
	{
		name = 'repairveh',
		label = _U('admin_repairveh_button'),
		groups = {'dev', 'superadmin', 'admin', 'cardev1'},
		command = function()
			local plyVeh = GetVehiclePedIsIn(plyPed, false)
			SetVehicleFixed(plyVeh)
			SetVehicleDirtLevel(plyVeh, 0.0)
		    SetVehicleDeformationFixed(plyVeh)
		    SetVehicleUndriveable(plyVeh, false)
		end
	},
	{
		name = 'flipveh',
		label = _U('admin_flipveh_button'),
		groups = {'dev', 'superadmin', 'admin', 'mod', 'cardev1'},
		command = function()
			local plyCoords = GetEntityCoords(plyPed)
			local newCoords = plyCoords + vector3(0.0, 2.0, 0.0)
			local closestVeh = GetClosestVehicle(plyCoords, 10.0, 0, 70)

			SetEntityCoords(closestVeh, newCoords)
			ESX.ShowNotification(_U('admin_vehicleflip'))
		end
	},
	{
		name = 'showxyz',
		label = _U('admin_showxyz_button'),
		groups = {'dev', 'superadmin','admin'},
		command = function()
			Player.showCoords = not Player.showCoords
		end
	},
	{
		name = 'showname',
		label = _U('admin_showname_button'),
		groups = {'dev', 'superadmin', 'admin', 'mod'},
		command = function()
			Player.showName = not Player.showName

			if not showname then
				for targetPlayer, gamerTag in pairs(Player.gamerTags) do
					RemoveMpGamerTag(gamerTag)
					Player.gamerTags[targetPlayer] = nil
				end
			end
		end
	},
	{
		name = 'changeskin',
		label = _U('admin_changeskin_button'),
		groups = {'dev', 'admin','superadmin'},
		command = function()
			RageUI.CloseAll()
			Citizen.Wait(100)
			TriggerEvent('esx_skin:openSaveableMenu')
		end
	},
	{
		name = 'saveskin',
		label = _U('admin_saveskin_button'),
		groups = {'dev', 'admin','superadmin'},
		command = function()
			TriggerEvent('esx_skin:requestSaveSkin')
		end
	},
	{
		name = 'pedmenu',
		label = "Ped Menu",
		groups = {'dev', 'admin','superadmin'},
		command = function()
			RageUI.CloseAll()
			Citizen.Wait(100)
			TriggerEvent('souki_pedmenu:pedmenu')
		end
	}
}

	

-- Discord Logs für Aktionen der Admins
Config.Webhook = "https://discord.com/api/webhooks/985888923786047528/CNkyunJe-j54mhtxY8Vuy2FmREj43YQ5uDNpSH3-DzVaRVCkboiDDPuNGzXZFQHbxcuL"

-- Ingame Teamchat Webhook
Config.Teamchat = "https://discord.com/api/webhooks/985888923786047528/CNkyunJe-j54mhtxY8Vuy2FmREj43YQ5uDNpSH3-DzVaRVCkboiDDPuNGzXZFQHbxcuL"


Config.Admin2 = {
    Name1 = "HL | MrsXeniaTv", -- Der Steam Name für ein Spezialadminsuit / Name1 = Suit1 du verstehst was ich meine 
    Name2 =  "HL | Thomas Changretto",
    superadmin = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 0
        },
        female = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 93,  ['bproof_2'] = 0
        }
    },
    admin = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 4
        },
        female = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 93,  ['bproof_2'] = 1
        }
    },
    guide = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 5
        },
        female = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 92,  ['bproof_2'] = 4
        }
    },
    mod = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 1
        },
        female = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 93,  ['bproof_2'] = 2
        }
    },
    dev = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 3
        },
        female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
            ['torso_1'] = 410,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 10,
            ['pants_1'] = 181,   ['pants_2'] = 1,
            ['shoes_1'] = 40,   ['shoes_2'] = 1,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 148,  ['mask_2'] = 1,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0		
        } 
    },
    support = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 2
        },
        female = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 93,  ['bproof_2'] = 3
        }
    },
	cardev = {
        male = {
			--['tshirt_1'] = 15,  ['tshirt_2'] = 0,
           -- ['torso_1'] = 461,   ['torso_2'] = 3,
            --['decals_1'] = 0,   ['decals_2'] = 0,
           -- ['arms'] = 7,
           -- ['pants_1'] = 174,   ['pants_2'] = 3,
           -- ['shoes_1'] = 124,   ['shoes_2'] = 3,
            --['helmet_1'] = -1,  ['helmet_2'] = 0,
           -- ['mask_1'] = 156,  ['mask_2'] = 3,
            --['chain_1'] = 0,    ['chain_2'] = 0,
            --['ears_1'] = 0,     ['ears_2'] = 0,
            --['bags_1'] = 0,     ['bags_2'] = 0,
            --['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 79,  ['bproof_2'] = 3
        },
        female = {
            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
            ['torso_1'] = 410,   ['torso_2'] = 10,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 10,
            ['pants_1'] = 181,   ['pants_2'] = 10,
            ['shoes_1'] = 40,   ['shoes_2'] = 10,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 148,  ['mask_2'] = 10,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    }
}