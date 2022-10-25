





fx_version "adamant"
game "gta5"
description "ESX Garage - By https://discord.gg/5zGgaBkZ7u"
author "Loaf Scripts"
version "0.1.0"

server_script "@oxmysql/lib/MySQL.lua"
shared_script "configuration/*.lua"
server_script "server/*.lua"
client_script "client/*.lua"

ui_page 'html/ui.html'
files {
    'html/ui.html',
    'html/assets/css/style.css',
    'html/assets/js/script.js',
    'html/assets/js/config.js'
}

dependency "es_extended"


