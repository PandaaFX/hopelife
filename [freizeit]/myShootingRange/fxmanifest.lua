



fx_version 'bodacious'
game 'gta5'

name 'myShootingrange'
author 'DaBurnerGermany for myScripts'
version '1.3.2'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'client/main.lua',
  'server/main.lua', 
}

client_scripts {
	'@NativeUI/NativeUI.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'config.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/escrow_serverfunctions.lua',
	'server/main.lua'
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/js/script.js",
    "html/css/styles.css",
    "html/css/bootstrap.css",
    "html/localization/locales.js"
}


dependency '/assetpacks'

