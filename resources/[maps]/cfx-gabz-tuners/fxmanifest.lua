

fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Tuners'
version '8.0.0'
lua54 'yes'
this_is_a_map 'yes'

dependencies {
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

server_scripts {
    'version_check.lua',
}

client_script {
    'gabz_entityset_tuners.lua',
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_tuners.xml'

files {
	'gabz_timecycle_tuners.xml',
}

escrow_ignore {
    'stream/**/*.ytd',
    'tunershop.lua',
    'gabz_entityset_tuners.lua'
}
dependency '/assetpacks'

