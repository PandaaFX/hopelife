



fx_version 'adamant'
game 'gta5'
name "ak47_hookahlounge"
author "MenanAk47 (MenanAk47#3129)"
version "1.0"

ui_page('html/index.html')

files({
    'html/index.html',
    'html/*.js',
    'html/sounds/*.wav',
})

shared_scripts {
    'config.lua',
    'locales/locale.lua',
    'locales/en.lua',
}

client_scripts {
    'client/utils.lua',
    'client/job.lua',
    'client/heater.lua',
    'client/main.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/utils.lua',
    'server/job.lua',
    'server/heater.lua',
    'server/main.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'server/utils.lua',
    'client/utils.lua',
}

lua54 'yes'

dependencies {
    '/server:5181', -- requires at least server build 5181
}

dependency '/assetpacks'

