



fx_version 'bodacious'
games { 'gta5' }

dependencies {
    '/server:4752',
    '/onesync',
}

client_scripts {
    "config.lua",

    "Utils/Utils.lua",
    "Utils/Camera.lua",
    "shared/*.lua",
    "locales/*.lua",
    "Utils/CallBack/client.lua",

    "client/AnimLib/AnimLib.lua",
    "client/AnimLib/AnimList.lua",

    "client/OnStart.lua",

    "client/TableDrinks/OnStart.lua",

    "client/TableDrinks/Utils.lua",

    "client/TableDrinks/LeaveAnimation.lua",
    "client/TableDrinks/DrinkAgainAnimation.lua",
    "client/TableDrinks/TakeADrinkAnimation.lua",

    "client/MiniGame/*.lua",

    "client/Drunk/DrivingEvents.lua",
    "client/Drunk/DrunkLogic.lua",
    "client/Drunk/DrunkMovement.lua",
    "client/BreathTestAnimation.lua",
    "client/BreathTestPickPlayer.lua",
    "client/PlayerJob.lua",
    "client/DrunkerType.lua",

    "client/Headache/HeadacheLogic.lua",

    "client/DrinkingBottle/PlayerSipLogic.lua",
    "client/DrinkingBottle/OnPlayerSip.lua",
    "client/DrinkingBottle/OnEquipDrink.lua",

    "client/TextStatus/DrunkStatus.lua",
    "client/TextStatus/RenderThread.lua",

    "client/BackwardsCompatibility.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",

    "config.lua",

    "shared/*.lua",

    "locales/*.lua",

    "Utils/CallBack/server.lua",

    "server/DrunkLabelStatus.lua",
    "server/OnStart.lua",
    "server/Framework/QBCore.lua",
    "server/Framework/Standalone.lua",
    "server/Minigame.lua",
    "server/LoadPlayer.lua",
    "server/SavePlayer.lua",
    "server/RegisterItems.lua",
    "server/PlayerTest.lua",
}

escrow_ignore {
    "config.lua",
    "locales/*.lua",
    "shared/*.lua",
    "server/*.lua",

    "server/Framework/QBCore.lua",
    "server/Framework/Standalone.lua",

    "client/TextStatus/DrunkStatus.lua",
    "client/TextStatus/RenderThread.lua",

    "client/DrinkingBottle/OnPlayerSip.lua",
    "client/DrinkingBottle/OnEquipDrink.lua",

    "client/*.lua",
}

lua54 "yes"


files {
    "html/*.html",
    "html/scripts/*.js",
    "html/css/*.css",
    "html/sounds/*.mp3",
    "html/css/*.png",
    "html/css/*.woff",
}

ui_page "html/index.html"
dependency '/assetpacks'
