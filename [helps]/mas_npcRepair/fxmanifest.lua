fx_version 'adamant'

game 'gta5'
author 'Masiko'
lua54 'yes'

shared_scripts {
    'config.lua'
}
client_scripts {
    'client/client.lua',
    'client/utils.lua'
}

server_scripts {
    'server.lua'
}

escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'