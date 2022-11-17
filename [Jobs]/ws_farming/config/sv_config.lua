WS_S = {}

-- check verkauf_config.lua, to enable for each zone
WS_S.marktplatz = false

-- checks if the player is near the farming zone
-- can use some server performance, when farming is used a lot
WS_S.checkDistance = true

WS_S.discord = {
    enabled = true,
    servername = "web.services.io",
    url = "https://web-services.io/",
    icon = "https://tobias.isfucking.pro/4zzE5A.png",
    color = "3447003",
    username = "WS - Farming"
}

WS_S.webhooks = {
    farmer = "YOUR-DISCORD-WEBHOOK-URL",
    verarbeiter = "YOUR-DISCORD-WEBHOOK-URL",
    verkauf = "YOUR-DISCORD-WEBHOOK-URL",
    marktpreis = "YOUR-DISCORD-WEBHOOK-URL"
}