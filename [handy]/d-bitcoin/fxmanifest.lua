fx_version      'adamant'
game            'gta5'
description     'D-Bitcoin from Deun Services'
version         '1.00'
ui_page         'html/main.html'

lua54 'yes'

server_script {
  "@mysql-async/lib/MySQL.lua",
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "config/config.lua",
  "server/server.lua",
  "server/suser.lua",

  "shared/functions.lua",
}

client_script {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "config/config.lua",
  "client/client.lua",
  "client/cuser.lua",
  
  "shared/functions.lua",
}


files {
    'html/main.html',
    'html/js/*.js',
    'html/js/locales/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/sound/*.ogg',
    'html/fonts/Roboto/*.ttf',
    'html/fonts/fontawesome/css/all.css',
}

escrow_ignore {
  "server/suser.lua",
  "client/cuser.lua",
  "config/config.lua",
  'locales/en.lua',
  'locales/de.lua',
}
dependency '/assetpacks'