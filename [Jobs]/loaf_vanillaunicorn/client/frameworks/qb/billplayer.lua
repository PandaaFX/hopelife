CreateThread(function()
    if Config.Framework ~= "qb" then return end

    RegisterNetEvent("loaf_vanillaunicorn:bill_closest_player")
    AddEventHandler("loaf_vanillaunicorn:bill_closest_player", function()
        local dialog = exports["qb-input"]:ShowInput({
            header = Strings["bill_closest"],
            submitText = "Bill",
            inputs = {
                {
                    text = Strings["player_id"],
                    name = "id",
                    type = "number",
                    isRequired = true
                },
                {
                    text = Strings["bill_reason"],
                    name = "reason",
                    type = "text",
                    isRequired = true
                },
                {
                    text = Strings["bill_amount"],
                    name = "amount",
                    type = "number",
                    isRequired = true
                },
            }
        })
        if not dialog then return end
        if not dialog.reason then return Notify(Strings["invalid_reason"]) end
        if not tonumber(dialog.amount) then return Notify(Strings["invalid_amount"]) end
        
        TriggerServerEvent("loaf_vanillaunicorn:send_bill", dialog.id, tonumber(dialog.amount), dialog.reason)
    end)
end)