fx_version 'cerulean'
game 'gta5'
ui_page 'html/index.html'
client_scripts {
	'client/*.lua'
}
lua54 'yes'
escrow_ignore {
	'config.lua'
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua',
}

shared_scripts {
	'config.lua',
}

files {
	'html/index.html',
	'html/*.css',
	'html/script.js',
	'html/assets/img/garage/*.png',
	'html/assets/img/stock/*.png',
}

dependency '/assetpacks'