fx_version 'cerulean'
game 'gta5'
author 'WGC Systems UG'
description 'Ressource zum integrieren von Copnet usw. in FiveM'
version '3.1.1'


client_scripts {
  'config.lua',
  'client.lua',
}

ui_page "html/index.html"

server_scripts {
  --Im falle eines Fehlers, bezüglich der MySQL verbindung, aktivert bitte @mysql-async/lib/MySQL.lua.
  --Das macht Ihr, indem Ihr die zwei "-" zeichen entfernt.
  --Ihr müsst anschließend noch die "-" zeichen vor   '@oxmysql/lib/MySQL.lua', einfügen!
  
  '@oxmysql/lib/MySQL.lua',
  --'@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server.lua',
}

files {
  "html/index.html",
  "html/script.js",
  "html/style.css",
  "html/tablet.png",
  "html/FMS.jpg",
  "html/tablet-s.png"
}



lua54 'yes'

escrow_ignore {
  'config.lua',
  'vpc-ls.sql'

}

dependency '/assetpacks'