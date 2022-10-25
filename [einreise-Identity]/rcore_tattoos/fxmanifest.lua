



fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Isigar <info@rcore.cz> & Kralik'
description 'rcore_tattoos complete tattoo system'
version '1.3.1'

ui_page 'client/html/index.html'

files {
    'client/html/style/*.css',
    'client/html/style/fonts/*.ttf',
    'client/html/style/fonts/fonts.css',
    'client/html/style/themes/*.css',
    'client/html/*.html',
    'client/html/js/*.js',
    'client/html/img/*.png',
    'assets/tattooLists/*.json',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/lib/*.lua',
    'sconfig.lua',
    'server/api/*.lua',
    'server/init/*.lua',
    'server/*.lua',
    'server/migration/**/*.lua',
}

client_scripts {
    'client/api/*.lua',
    'client/init/*.lua',
    'client/lib/*.lua',
    'client/*.lua',
}

shared_scripts {
    'shared/*.lua',
    'locales/*.lua',
    'config.lua',
}

escrow_ignore {
    'client/api/*.lua',
    'server/api/*.lua',
    'server/lib/*.lua',
    'client/lib/*.lua',
    'locales/*.lua',
    'config.lua',
    'sconfig.lua',
    'shared/*.lua',
    'server/migration/types/*.lua',
}











dependency '/assetpacks'
