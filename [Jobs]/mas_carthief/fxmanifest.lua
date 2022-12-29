fx_version 'adamant'

game 'gta5'
author 'CMRP'
version '1.0'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_script {
    'client/client.lua',
    'client/helper.lua',
    'client/menu.lua'
}

server_scripts {
    'server/server.lua'
}

escrow_ignore {
    'config.lua',
    'client/helper.lua'
}
dependency '/assetpacks'