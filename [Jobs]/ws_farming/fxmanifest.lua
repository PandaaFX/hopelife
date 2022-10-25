fx_version 'adamant'
game 'gta5'
 
server_scripts {
    'config/cl_config.lua',
    'config/sv_config.lua',
    'config/zones/farmer_config.lua',
    'config/zones/verarbeiter_config.lua',
    'config/zones/verkauf_config.lua',
    'server/server.lua'
}

client_scripts { 
    'config/cl_config.lua',
    'config/zones/farmer_config.lua',
    'config/zones/verarbeiter_config.lua',
    'config/zones/verkauf_config.lua',
    'client/client.lua'
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/assets/css/*.*',
    'html/assets/images/*.*',
    'html/assets/js/*.*'
}