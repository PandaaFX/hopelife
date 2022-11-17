



fx_version 'bodacious'
game 'gta5'

name 'mySpeedcam'
author 'myScripts and DaBurner'
version '1.0.0'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua', 
  }

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua',
	'escrow_server.lua'
}
  
client_scripts {
	'@NativeUI/NativeUI.lua',
	'config.lua',
	'client.lua'
}
  
ui_page('html/index.html')
  
files {
	'html/index.html'
}
dependency '/assetpacks'

