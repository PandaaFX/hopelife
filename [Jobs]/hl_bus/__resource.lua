



resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'FT Bus'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale/de.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locale/de.lua',
	'config.lua',
	'client/client.lua'
}

