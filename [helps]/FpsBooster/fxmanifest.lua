



fx_version 'adamant'
game 'gta5'
author 'malizniak'
lua54 "yes"

files {
    'html/html.html',
    'html/css.css',
    'html/js.js',
}

ui_page 'html/html.html'

client_script "client.lua"
shared_script "Config.lua"

escrow_ignore {
    "Config.lua",
}
dependency '/assetpacks'
