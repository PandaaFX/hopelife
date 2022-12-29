fx_version 'adamant'
games { 'gta5' }

author 'Musiker15 - MSK Scripts'
name 'msk_weaponammo'
description 'Ammunition, Components & Tints'
version '8.6'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'translation.lua',
	'client/menu.lua',
	'server/server_items.lua'
}

shared_scripts {
	'config.lua',
	'translation.lua'
}

client_scripts {
	'@NativeUI/NativeUI.lua', -- Remove this if you don't use NativeUI // Go to menu.lua and remove ALL of the NativeUI Code
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua',
	'server/server_*.lua',
}

dependencies {
	'es_extended',
	'msk_core'
}
dependency '/assetpacks'