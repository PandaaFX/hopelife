ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('hhfw:docOnline' , function(source, cb)
	local src = source
	local Ply = ESX.GetPlayerFromId(src)
	local xPlayers = ESX.GetPlayers()
	local doctor = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			doctor = doctor + 1
		end
	end

	cb(doctor)
end)

RegisterServerEvent('esx_hospital:price')
AddEventHandler('esx_hospital:price', function()
  	local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 75000
	
	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(75000)
		TriggerClientEvent("pNotify:SetQueueMax", -1, "lmao", 10)
        TriggerClientEvent("pNotify:SendNotification", _source, {
            text = "<b style = 'color:white'> Bezahlt: " .. "$" .. price .. "</b>",
            type = "success",
            queue = "lmao",
            timeout = 10000,
            layout = "centerLeft"
        })
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
            account.addMoney(price/2)
        end)
    else 
        if(xPlayer.getAccount('bank').money >= price) then
            xPlayer.removeAccountMoney('bank', 75000)
		    TriggerClientEvent("pNotify:SetQueueMax", -1, "lmao", 10)
            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = "<b style = 'color:white'> Bezahlt: " .. "$" .. price .. "</b>",
                type = "success",
                queue = "lmao",
                timeout = 10000,
                layout = "centerLeft"
            })
            TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
                account.addMoney(price/2)
            end)
        end
    end
    if(xPlayer.getAccount('bank').money <= price) then
        if(xPlayer.getMoney() <= price) then
            xPlayer.removeAccountMoney('bank', 75000)
		    TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
			    if account then
				    MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {xPlayer.identifier, xPlayer.identifier, 'society', "society_ambulance", 'Notfallmediziner', price},
				    function(rowsChanged)
					    xPlayer.showNotification("Nicht genug Bargeld, dir wurde eine Rechnung ausgestellt")
				    end)
			    end
		    end)
        end
	end
end)
