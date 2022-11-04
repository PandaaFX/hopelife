



fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar <info@rcore.cz>'
description 'rcore.cz new clothing'
version '1.6.1'

ui_page 'client/html/index.html'

files {
    'client/html/*.js',
    'client/html/*.css',
    'client/html/img/*.png',
    'client/html/index.html',
    'client/html/icons/*.png',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'locales.lua',
    'framework.lua',
    'locales/*.lua',
    'server/extend/*.lua',
    'server/lib/*.lua',
    'server/main.lua',
}

client_scripts {
    'locales.lua',
    'framework.lua',
    'locales/*.lua',
    'client/lib/*.lua',
    'client/extend/*.lua',
    'client/main.lua',
}

shared_scripts {
    'config.lua',
    'common.lua',
    'validate.lua',
}

dependencies {
    '/server:4752',
}

escrow_ignore {
    'config.lua',
    'common.lua',
    'validate.lua',
    'locales.lua',
    'framework.lua',	
    'locales/*.lua',	
    'client/lib/*.lua',
    'client/extend/*.lua',	
    'server/extend/*.lua',
    'server/lib/*.lua',	
}

lua54 "yes"

dependency '/assetpacks'
