version '2.5.1' -- THIS IS THE SCRIPT VERSION

author 'jaksam1074'

shared_scripts {
    "shared/streamed_props_remover.lua",
    "shared/objects.lua",
}

client_scripts {
    -- Callbacks
    "utils/callbacks/cl_callbacks.lua",

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/cl_miscellaneous.lua",

    -- Framework
    "utils/framework/sh_framework.lua",
    "utils/framework/cl_framework.lua",

    -- Integrations
    'integrations/cl_*.lua',
    'integrations/sh_*.lua',

    -- Settings
    "utils/settings/cl_settings.lua",

    -- Dialogs
    "utils/dialogs/cl_dialogs.lua",

    -- Police
    "utils/police/cl_police.lua",

    -- Interaction points
    "utils/interaction_points/cl_interaction_points.lua",

    -- Locales
    "locales/*.lua",

    -- Script client files
    "client/main.lua",
    "client/menu.lua",
    "client/npc_mugging.lua",
    "client/heists.lua",
    "client/animations.lua",
    "client/lethal_gas.lua",
    "client/guards.lua",
    "client/cargo_robberies.lua",
    "integrations/minigames/*.lua", -- all minigames
}

server_scripts {
    -- Dependency
    '@oxmysql/lib/MySQL.lua',

    -- Callbacks
    "utils/callbacks/sv_callbacks.lua",
    
    -- Database
    "utils/database/database.lua",

    -- Miscellaneous
    "utils/miscellaneous/sh_miscellaneous.lua",
    "utils/miscellaneous/sv_miscellaneous.lua",

    -- Framework
    "utils/framework/sh_framework.lua",
    "utils/framework/sv_framework.lua",

    -- Integrations
    'integrations/sv_*.lua',
    'integrations/sh_*.lua',

    -- Settings
    "utils/settings/sv_settings.lua",

    -- Dialogs
    "utils/dialogs/sv_dialogs.lua",

    -- Police
    "utils/police/sv_police.lua",

    -- Interaction points
    "utils/interaction_points/sv_interaction_points.lua",

    -- Locales
    "locales/*.lua",

    -- Script server files
    "server/main.lua",
    "server/menu.lua",
    "server/npc_mugging.lua",
    "server/heists.lua",
    "server/clear_streamed_props.lua",
    "server/lethal_gas.lua",
    "server/cargo_robberies.lua",
}

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    "html/menu_translations/*.json",
    "utils/dialogs/dialogs.js",

    "stream/*.*",
}


data_file "DLC_ITYP_REQUEST" "stream/trolleys.ytyp"
files {
    "stream/trolleys/*.*"
}

data_file "DLC_ITYP_REQUEST" "stream/paintings/paintings.ytyp"
files {
    "stream/paintings/*.*"
}

data_file 'DLC_ITYP_REQUEST' 'stream/L1_1.ytyp' 

files {
    'stream/L1_1.ytyp',
    'stream/L1_1.ydr',
}

fx_version 'cerulean' -- (This is NOT the script version)
game 'gta5'

dependencies {
    '/onesync',
    '/server:4752',
}

lua54 'yes' 

escrow_ignore {
    -- Integration files
    "integrations/*.lua",
    "integrations/minigames/*.lua",

    -- Locales
    "locales/*.lua",

    -- Extra files
}
dependency '/assetpacks'