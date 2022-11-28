fx_version 'bodacious'
game 'gta5'

author 'Morice'

server_script {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/server.lua'
}
client_scripts {
    'config.lua',
    'client/client.lua'
}