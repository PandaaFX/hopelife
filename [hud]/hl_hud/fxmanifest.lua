
fx_version 'adamant'
game 'gta5'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/main.css',
	'html/ui_bumbs.css',
	'html/canvas_css/styles.css',
	'html/app.js',
	'html/listener.js',
	'html/js/*.js',
	'html/assets/icons.svg',
	'html/img/*.png',
	'html/img/weapons/*.png',
	'html/sounds/*.ogg',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua'
}

dependencies {
	'es_extended'
}

