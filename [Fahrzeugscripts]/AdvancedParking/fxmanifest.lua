
fx_version "cerulean"
games { "gta5" }

author "Philipp Decker"
description "Saves and respawns vehicles during sessions and across server restarts."
version "3.2.1"

lua54 "yes"

escrow_ignore {
	"Log.lua",
	"config.lua",
	"server/timerTasks.lua",
	"server/sv_utils.lua",
	"server/server.lua",
	"client/cl_utils.lua",
	"client/client.lua"
}

dependencies {
	"/onesync",
	"mysql-async",
	"kimi_callbacks"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",

	"Log.lua",
	"server/timerTasks.lua",

	"config.lua",

	"server/server_encrypted.lua",

	"server/sv_utils.lua",
	"server/server.lua"
}

client_scripts {
	"Log.lua",

	"config.lua",

	"client/client_encrypted.lua",

	"client/cl_utils.lua",
	"client/client.lua"
}

dependency '/assetpacks'