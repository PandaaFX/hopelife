


fx_version 'cerulean'
games { 'gta5' }

name 'myProperties'
author 'myScripts'
version '3.1.2'

lua54 'yes'

escrow_ignore {
  'config.lua',
  'client.lua',
  'server.lua', 
}

client_scripts {
	"@NativeUILua_Reloaded/src/NativeUIReloaded.lua", -- disable this when you do not want to use NativeUIReloaded
    --'@NativeUI/NativeUI.lua', -- if you want to use NativeUI instead of NativeUI Reloaded -> Activate this!
	'client_escrow.lua',
	'config.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua',
	'server_escrow.lua',
}


dependency '/assetpacks'

