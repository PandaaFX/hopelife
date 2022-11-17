

fx_version 'adamant'
author 'CommandExecutor'
description 'Yeet Custom Marry'

game 'gta5'

client_scripts {
	'client/client.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

ui_page {
	'html/index.html'
}

files {
    'html/*.*',
    'html/img/*.*'
}


