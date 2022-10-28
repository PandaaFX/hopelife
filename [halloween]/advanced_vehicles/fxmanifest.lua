fx_version 'adamant'
game 'gta5'
author 'Lixeiro Charmoso#1104'

ui_page 'nui/index.html'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client.lua',
	'utils.lua',
	'server_utils.lua',
	'lang/*.lua',
}

files {
	'nui/lang/*',
	'nui/font/*',
	'nui/images/*',
	'nui/images/repair/*',
	'nui/images/maintenance/*',
	'nui/images/upgrades/*',
	'nui/jquery-3.5.1.min.js',
	'nui/animations.css',
	'nui/style.css',
	'nui/index.html',
	'nui/script.js',
	"audio/*",
	"audio/**/*"
}

client_scripts{
	'lang/*.lua',
	
	'config.lua',
	'utils.lua',
	'client.lua',
}

server_scripts{
	'@mysql-async/lib/MySQL.lua',

	'lang/*.lua',
	'config.lua',
	'server_utils.lua',
	'server.lua',
}

dependency {
	"mysql-async"
}

data_file "AUDIO_GAMEDATA" "audio/k20a_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/k20a_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_k20a"

data_file "AUDIO_GAMEDATA" "audio/rb26dett_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/rb26dett_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_rb26dett"

data_file "AUDIO_GAMEDATA" "audio/toysupmk4_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/toysupmk4_sounds.dat"
data_file "AUDIO_WAVEPACK" "audio/sfx/dlc_toysupmk4"
dependency '/assetpacks'