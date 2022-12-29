lua54 'yes'

fx_version 'cerulean'

game 'gta5'

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'code/client.lua',
}

server_scripts {
	'@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'code/server.lua',
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/*.png',
    'html/img/items/*.*',
    'html/js/*.*',
    'html/css/*.*',
}

escrow_ignore {
    'config.lua',
    'nkn.sql',
    'locales/*.*'
}
dependency '/assetpacks'