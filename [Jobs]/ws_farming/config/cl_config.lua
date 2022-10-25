WS = {}

WS.esxPrefix = "esx"
WS.getSharedObject = "getSharedObject"

-- if your server uses es_extended 1.2 or Legacy make this true
-- otherwise if your server uses es_extended 1.1, in this case make it false
WS.es1_2 = true

-- enables "loopfarming", the player can start/stop farming
WS.loopFarming = false

WS.server = { -- edit the ui logos and headlines
    primary = "WEB",
    secondary = "SERVICES",
    subTitle = "WS-FARMING",
    logoUrl = "https://cdn.discordapp.com/attachments/773618377738027029/928743477917925386/Logo_1.png"
}

WS.Language = {
    disallowedJob = "Mach dich hier ab! Mit dir arbeite ich nicht zusammen ...",
    startHarvest = "Farmen ...",
    harvestSuccess = "+ %sx %s",
    harvestFaild = "Du hast keinen Platz mehr in deinen Taschen",
    startProcessing = "Verarbeiten ... (%ss)",
    processSuccess = "Du hast %sx %s zu %sx %s verarbeitet",
    processFailed = "Du hast nicht genug %s",
    processFailedInventory = "Deine Taschen sind voll",
    cantExit = "Du kannst den Prozess nicht abbrechen",
    startSelling = "Verkaufen ... (%ss)",
    soldSuccess = "Du hast %sx %s verkauft und %s$ erhalten",
    soldFaild = "Du hast nicht genug %s",
    errorUi = "Es ist ein Fehler aufgetreten",
    cancelLoopFarming = "~INPUT_VEH_DUCK~ zum Abbrechen",
    cooldownActive = "Warte einen Moment..."
}

-- https://docs.fivem.net/docs/game-references/controls/
WS.disabledControllActions = {
    140, 2, 263, 45, 22, 44, 37, 288, 289, 170, 167, 254, 47, 38
}

function Notify(msg)
    ESX.ShowNotification(msg)
end