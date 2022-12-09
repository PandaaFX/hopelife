Config = {}

Config.Reset = {
    hour = 23,
    min = 58,
}

Config.CollectPositions = {
    vector4(174.448349, -941.934082, 28.448364, 120.889763) 
}

Config.Notify = function(msg)
    ESX.ShowNotification(msg)
end

Config.DailyRewards = {
    {type = "item", item = "scratch_ticket", amount = 25},
    {type = "item", item = "cocktail", amount = 20},
    {type = "item", item = "schrauben", amount = 50},
}




-- Config.DailyRewards = { -- RANDOM REWARDS
--     {type = "account", account = "money", amount = 10000},
--     {type = "account", account = "money", amount = 20000},
--     {type = "item", item = "phone", amount = 2},
--     {type = "item", item = "repairkit", amount = 10},
-- }

Config.Locales = {
    notReady = "Du hast deine Belohnung bereits abgeholt.",
    gotMoney = "Du hast %s$ in %s erhalten.",
    gotItem = "Du hast %sx %s erhalten.",
    gotWeapon = "Du hast ein/e %s mit %s Schuss erhalten."
}