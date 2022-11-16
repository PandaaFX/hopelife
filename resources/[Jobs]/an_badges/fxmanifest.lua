----- Made By https://a-n.tebex.io/
----- For Support, Join my Discord: https://discord.gg/f2Nbv9Ebf5
----- For custom services or help, check my Fiverr: https://www.fiverr.com/aymannajim

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

description 'AN Badges | Join Discord for Support: https://discord.gg/f2Nbv9Ebf5'
version '1.0.0'
author 'aymannajim'
lua54 'yes'

ui_page 'ui/index.html'

client_scripts {
    'client.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', -- uncomment this if you're using mysql-async
    '@oxmysql/lib/MySQL.lua', -- comment this if you're using mysql-async
    'server.lua',
}

shared_scripts {
	'config.lua',
}

files {
	'ui/index.html',
	'ui/main.js',
	'ui/style.css',
	'ui/designs/*.png',
}

escrow_ignore {
	'*',
	'*/*',
}

----- Made By https://a-n.tebex.io/
----- For Support, Join my Discord: https://discord.gg/f2Nbv9Ebf5
----- For custom services or help, check my Fiverr: https://www.fiverr.com/aymannajim
dependency '/assetpacks'
dependency '/assetpacks'