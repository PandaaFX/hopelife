fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'sh-scripts <sh-store.tebex.io>'

shared_scripts {
    'cfg.lua',
    'utils.lua',
    'shared.lua',
}

client_script 'client.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    -- '@mysql-async/lib/MySQL.lua',
    'server.lua',
}
data_file 'DLC_ITYP_REQUEST' 'stream/qua_elec_cuff.ytyp'
ui_page 'nui/index.html'
files {
    'nui/index.html',
    'nui/app.js',
    'nui/style.css'
}

escrow_ignore {
    'cfg.lua',
    'utils.lua',
    'shared.lua',
}

dependency '/onesync'

dependency '/assetpacks'