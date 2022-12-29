Config = {
    webhook = "server.lua", --Discord Webhook
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
            coords = vector3(-1083.16, -245.78, 37.75), -- No need to substract the Z coordinate by 1.
            heading = 206.929138
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