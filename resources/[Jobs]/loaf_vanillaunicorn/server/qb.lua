CreateThread(function()
    if Config.Framework ~= "qb" then return end

    local lib = exports["loaf_lib"]:GetLib()
    local QBCore = exports["qb-core"]:GetCoreObject()

    RegisterNetEvent("loaf_vanillaunicorn:send_bill")
    AddEventHandler("loaf_vanillaunicorn:send_bill", function(id, amount, reason)
        -- thanks CrypticOG#0420
        local biller, billed = QBCore.Functions.GetPlayer(source), QBCore.Functions.GetPlayer(tonumber(id))
        if not biller or not billed then return end
        if biller.PlayerData.job.name ~= "unicorn" then return end
        if amount <= 0 then return end

        exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
            ['citizenid'] = billed.PlayerData.citizenid,
            ['amount'] = amount,
            ['society'] = biller.PlayerData.job.name,
            ['sender'] = biller.PlayerData.charinfo.firstname
        })

        TriggerClientEvent('QBCore:Notify', biller.PlayerData.source, 'Invoice Successfully Sent', 'success')

        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
    end)

    lib.RegisterCallback("loaf_vanillaunicorn:throw_money", function(source, cb, dancer, tosstype)
        local Player = QBCore.Functions.GetPlayer(source)
        local price = Config.ThrowMoney[tosstype]
        if Player.Functions.GetMoney("cash") < price then return cb(false) end
        local dancerPlayer = QBCore.Functions.GetPlayer(dancer)
        if dancerPlayer then 
            Player.Functions.RemoveMoney("cash", price, "toss-money")
            dancerPlayer.Functions.AddMoney("cash", price, "stripper-money")

            TriggerClientEvent('QBCore:Notify', dancer, Strings["threw"]:format(price))
        end
        cb(true)
    end)
end)