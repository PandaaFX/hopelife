fx_version 'cerulean'
game 'gta5'

name "rtd_gym-v2"
description "Gym System"
author "RTDTonino#2060"
version "2.0"
lua54 'yes'

shared_scripts {
    'shared/*.lua',
    'locales/es.lua',
    'locales/en.lua',
    'locales/de.lua',
    'locales/pl.lua',
}

client_scripts {
    'client/**/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua',
}

escrow_ignore {
    'shared/Config.lua',
    'locales/*.lua',
}
dependency '/assetpacks'