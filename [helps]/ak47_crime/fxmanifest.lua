fx_version 'adamant'
game 'gta5'
name "ak47_crime"
author "MenanAk47 (MenanAk47#3129)"
version "1.0"

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/assets/images/blindfold.png',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
}

server_scripts {
	'config.lua',
	'server/utils.lua',
	'server/cuff.lua',
	'server/drag.lua',
	'server/trunk.lua',
	'server/bind.lua',
	'server/blindfold.lua',

	'locales/locale.lua',
	'locales/en.lua',
}

client_scripts {
	'config.lua',
	'client/utils.lua',
	'client/cuff.lua',
	'client/drag.lua',
	'client/trunk.lua',
	'client/bind.lua',
	'client/blindfold.lua',
	'client/menu.lua',

	'locales/locale.lua',
	'locales/en.lua',
}

escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'server/utils.lua',
    'client/menu.lua',
    'client/utils.lua',
}

lua54 'yes'

dependencies {
    '/server:5181', -- requires at least server build 5181
}
dependency '/assetpacks'