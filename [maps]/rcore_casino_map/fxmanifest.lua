

fx_version 'adamant'
game 'gta5'
this_is_a_map 'yes'

client_scripts {
    'client/client.lua',
	'client/water.lua',
}

lua54 "yes"

escrow_ignore {
    'client/*.lua',
	"stream/**/*.ymap",	
	"stream/**/*.ymf",
	"stream/**/*.ybn",			
	"stream/**/*.ydr",			
	"stream/**/*.ytd",
	"stream/**/*.ytf",
	"stream/**/*.gfx",
	"stream/*.meta",
}

dependency '/assetpacks'
dependency '/assetpacks'
