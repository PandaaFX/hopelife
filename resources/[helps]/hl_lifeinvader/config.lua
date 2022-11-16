Config = {
    webhook = "https://discord.com/api/webhooks/962271594305163264/aYBPgywSxBDTEMTU1qatJ8UJCV1kZjYmcqzs1sLYP6GEEkgYzgaiXYSQi8J3A02IqS-u", --Discord Webhook
    cost = 500, -- How much should the Player need to pay.
    cooldown = 1.2, -- Cooldown in Minutes
    pedModel = "ig_lifeinvad_01",
    name     = "LifeInvader",
    blips = {
        sprite  = 77,
        color   = 1,
        scale   = 0.66
    },
    locations = {
        {
            coords = vector3(-1083.47, -245.96, 37.76), -- No need to substract the Z coordinate by 1.
            heading = 208.65
        }
    },
    locale = {
        PressE = "Drücke ~INPUT_PICKUP~ um Werbung zu schalten ~n~(Kosten: ~g~$%s~s~)",
        Menu = {
            title           = "LifeInvader",
            description     = "Sende deine Werbung an alle Einwohner!",
            SendTitle       = "Werbung schalten ->",
            SendDescription = "Um eine Nachricht zu senden zahle $%s.",
        },
        adDescription = "Werbung",
        NotEnoughMoney  = "Du hast nicht genug Geld",
        CurrentlyOnCooldown = "Es wurde bereits eine Werbung geschaltet ~n~ Zeit übrig: %sminutes",
        PostedAdvertisementLog = "**[LifeInvader] %s hat eine Werbung geschaltet**"
    }

}