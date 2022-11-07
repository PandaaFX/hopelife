
fx_version 'adamant'
game 'gta5'

author 'c8re'
description 'Original realistic vehicle experiance for FiveM'
version '1.4.0'

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/img/*.png',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

client_scripts{
    'config.lua',
    'client/manual.lua',
    'client/main.lua',
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua',
}

lua54 'yes'


escrow_ignore {
  'client/main.lua',
  'server/main.lua',
  'config.lua'
}

dependency '/assetpacks'