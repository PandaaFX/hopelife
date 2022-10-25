fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Marabunta'
version '1.0.0'
lua54 'yes'
this_is_a_map 'yes'

dependencies { 
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_marabunta.xml'

files {
    'gabz_timecycle_marabunta.xml',
}

escrow_ignore {
    'stream/**/*.ytd',
    'marabunta.lua',
}
dependency '/assetpacks'