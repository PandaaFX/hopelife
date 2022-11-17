



fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

description 'ESX DataStore'

version '1.0.1'

escrow_ignore {
  'server/main.lua',
  'server/classes/datastore.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/classes/datastore.lua',
  'server/main.lua'
}

dependency '/assetpacks'

