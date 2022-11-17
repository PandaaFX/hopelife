fx_version 'adamant'
games { 'gta5' }

author 'Musiker15 - MSK Scripts'
name 'msk_weaponammo'
description 'Clips, Components & Tints'
version '8.2'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'locales/*.lua',
	'menu.lua',
	'server_items.lua'
}

shared_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua'
}

client_scripts {
	'@NativeUI/NativeUI.lua', -- Remove this if you don't use NativeUI // Go to menu.lua and remove ALL of the NativeUI Code
	'client.lua',
	'menu.lua'
}

server_scripts {
	'server.lua',
	'server_items.lua'
}
dependency '/assetpacks'