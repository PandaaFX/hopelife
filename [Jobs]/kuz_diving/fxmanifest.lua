



fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Diving Script with advanced selling mechanics for ESX'
version '1.2.0'

--
-- Server
--

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'shared/config.lua',
    'server/server.lua',
}

--
-- Client
--

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'shared/config.lua',
    'client/client.lua',
}

escrow_ignore {
    'shared/config.lua',
    'locales/*.lua',
    'client/client.lua',
    'server/server.lua',
}

