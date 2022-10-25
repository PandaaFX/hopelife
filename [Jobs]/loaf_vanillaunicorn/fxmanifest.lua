



fx_version "cerulean"
game "gta5"
lua54 "yes"
version "2.0.1"

shared_script "config/*.lua"
client_script {
    "client/*.lua",
    "client/frameworks/esx/*.lua",
    "client/frameworks/qb/*.lua",
    "client/main/*.lua",
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    "client/bar2.lua",
}
server_script "server/*.lua"

dependency "loaf_lib"

escrow_ignore {
    -- client
    "src/*.lua",
    "client/*.lua",
    "client/main/*.lua",
    "client/frameworks/**/*.lua",

    -- various
    "config/*.lua",
    "qbcore-outfit-converter.lua",

    -- server
    "server/esx.lua",
    "server/qb.lua"
}

dependency '/assetpacks'

