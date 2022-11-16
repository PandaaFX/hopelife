fx_version 'adamant'

game 'gta5'

description 'TBM Job Storage'

version '1.5.0'

lua54 'yes'

escrow_ignore {
	'locales/*.lua',
	'config.lua',
	'view/**/*'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/database.lua',
	'server/player.lua',
	'server/storage.lua',
	'locales/de.lua',
	'locales/en.lua',
	'server/server.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/de.lua',
	'locales/en.lua',
	'client/blipsManager.lua',
	'client/translations.lua',
	'client/client.lua',
}

dependencies {
	'es_extended',
	'oxmysql'
}

ui_page('view/index.html')

files {
	'view/index.html',
	'view/storage.html',
	'view/manageAccess.html',
	'view/index.js',
	'view/style.css',
	'view/items/*.png',
}

dependency '/assetpacks'