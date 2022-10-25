-- polat
fx_version 'cerulean'
game 'gta5'
name 'plt Planting System'
version '1.0.12'
description 'Fivem Planting System'
author 'p0lat'
contact 'pltrdgms@hotmail.com'
discord 'https://discord.gg/3h8tebmBeD'
lua54 'yes'

ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/ui.css",
    "html/ui.js",
	'html/img/*.png',
	'html/img/*.svg',
}

server_scripts {
	'locale.lua',
	'config.lua',
	'server.lua',
	'lockedserver.lua'
}

client_scripts {
	'locale.lua',
	'config.lua',
	'client.lua',
	'lockedclient.lua',
}

escrow_ignore {
	'locale.lua',
	'config.lua',
	'client.lua',
	'server.lua',
  }


dependency '/assetpacks'