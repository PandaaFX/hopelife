fx_version 'adamant'
game 'gta5'
description 'D-Phone from Deun Services'
version '0.8 Pre-Stable'
ui_page 'html/main.html'

lua54 'yes'

server_script {
  "@mysql-async/lib/MySQL.lua",
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',

  "config/config.lua",
  "config/ipconfig.lua",
  "config/mailconfig.lua",
  "config/serverconfig.lua",

  "server/apps/*.lua",
  "server/apps/addons/*.lua",
  "server/games/*.lua",
  "server/functions/*.lua",
  "server/classes/*.lua",
  "server/*.lua",

  -- Shared
  "shared/functions.lua",
  "shared/apps/*.lua",
}

client_script {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/de.lua',

  "config/config.lua",
  "config/ipconfig.lua",
  "config/mailconfig.lua",

  "client/*.lua",
  "client/apps/*.lua",
  "client/apps/addons/*.lua",
  "client/classes/*.lua",
  "client/games/*.lua",
  "client/functions/*.lua",

  -- Shared
  "shared/functions.lua",
  "shared/apps/*.lua",
}

shared_script '@es_extended/imports.lua'

files {
  'html/main.html',
  'html/js/*.js',
  'html/js/components/*.js',
  'html/js/locales/*.js',
  'html/css/*.css',
  'html/css/components/*.css',
  'html/css/themes/*.css',
  'html/img/*.png',
  'html/images/icons/*.png',
  'html/img/broker/*.png',
  'html/sound/*.ogg',
  'html/sound/DoodleJump/*.ogg',
  'html/fonts/font-1.ttf',
  'html/fonts/HalveticaNeue-Medium.ttf',
  'html/fonts/KeepCalm-Medium.ttf',
  'html/fonts/Azonix.otf',
  'html/fonts/keepcalm.otf',
  'html/fonts/*.woff',
  'html/fonts/*.ttf',
  'html/fonts/Roboto/*.ttf',
  'html/fonts/Snake/*.ttf',
  '@d-garage/html/images/icons/*.png',
  '@d-garage/html/css/categories.css',
}

escrow_ignore {
  "config/config.lua",
  "config/newconfigstuff.lua",
  "config/serverconfig.lua",
  "config/mailconfig.lua",
  "server/suser.lua",
  "server/serverconfig.lua",
  "server/apps/sphoto.lua",
  "client/cuser.lua",
  "client/animation.lua",
  "client/photo.lua",
  'locales/en.lua',
  'locales/de.lua',
}

dependency '/assetpacks'