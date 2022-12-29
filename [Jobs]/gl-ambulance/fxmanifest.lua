fx_version 'cerulean'
game 'gta5'

author 'Kallock - The Goodlife RP Server, edited manifest to APPEASE OVERLORD KAKAROT'
version '1.0.0'
lua54 'yes'

escrow_ignore {
    'client.lua',
    'server.lua',
    'shared.lua',
    'locales/en.lua'
}


dependencies "bt-target"


client_script {
	'@NativeUI/NativeUI.lua',
	'client.lua',
	'@es_extended/locale.lua',
	'locales/en.lua'
}


server_script 'server.lua'

shared_script 'shared.lua'

dependency '/assetpacks'