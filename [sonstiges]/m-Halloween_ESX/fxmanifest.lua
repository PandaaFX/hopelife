fx_version 'bodacious'
game 'gta5'

author 'marcinhu#0001'
version '1.0.0'

client_script {
    'client/**.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
}

server_script {
	'server/**.lua',
}

shared_script 'configs/**.lua'
shared_script '@ox_lib/init.lua'

escrow_ignore {
    "client/c_editable.lua",
    "images/**",
    "configs/**",
    "Sounds/**",
    "README.lua",
}

lua54 'yes'

dependency '/assetpacks'