

fx_version 'cerulean'

game 'gta5'

author 'okok#3488'
description 'okokBanking'

ui_page 'web/ui.html'

files {
	'web/*.*',
	'web/img/*.*'
}

shared_script 'config.lua'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'server.lua'
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'server.lua',
	'client.lua',
	'locales/*.lua'
}
dependency '/assetpacks'

