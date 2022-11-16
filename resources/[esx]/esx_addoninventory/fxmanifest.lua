



fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

description 'ESX AddonInventory'

version '1.0.0'

escrow_ignore {
	'server/main.lua',
	'server/classes/addoninventory.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/classes/addoninventory.lua',
	'server/main.lua'
}

dependency '/assetpacks'

