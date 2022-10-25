fx_version 'adamant'
games { 'gta5' }

author 'myScripts'
description 'myBilling'
version '1.3.0'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'client.lua',
  'server.lua',
}

client_scripts {
	'@NativeUI/NativeUI.lua',
	'config.lua',
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua',
    'escrow_server.lua',
}
dependency '/assetpacks'