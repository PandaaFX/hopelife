



fx_version 'cerulean'
games { 'gta5' }

author 'Philipp Decker'
description 'Track any vehicle across the map!'
version '1.1'

dependency 'kimi_callbacks'
dependency 'NativeUI'

server_scripts {
	'@mysql-async/lib/MySQL.lua',

	'config.lua',
	'server.lua'
}

client_scripts {
	'@NativeUI/NativeUI.lua',

	'config.lua',
	'client.lua'
}

server_exports {
	'StartTracker',
	'StopTracker'
}


