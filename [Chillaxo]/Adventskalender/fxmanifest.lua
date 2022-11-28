fx_version 'adamant'
game 'gta5'

description 'ChillAdvent'
author 'Chillaxo#6245'
version '1.0.0'

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

files {
    'stream/gaudeee_xmas_tree.ydr',
    'stream/gaudeee_xmas_tree.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/gaudeee_xmas_tree.ytyp'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
} 

client_scripts {
    '@es_extended/locale.lua',
    'client/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server/server.lua'
}

escrow_ignore {
    'config.lua'
}

lua54 'yes'



dependencies {
    'es_extended',
    'cron',
    'esx_addonaccount'
}