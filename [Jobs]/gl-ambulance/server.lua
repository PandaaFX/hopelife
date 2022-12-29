ESX = nil
local lastResponder = 0
local playersHealing, deadPlayers = {}, {}


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})


RegisterServerEvent('gl-ambulance:getItemForEMS',function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(item).count

	if count < 1 then 
		xPlayer.addInventoryItem(item,1)
	end
end)

RegisterServerEvent('gl-ambulance:treatPlayerWounds',function(player,wound)
	local player = ESX.GetPlayerFromId(player).source
		TriggerClientEvent('gl-ambulance:treatAnimations',player,wound)
		TriggerClientEvent('gl-ambulance:treatTargetWound',source,wound)

		Citizen.Wait(5000)
		if wound == 'bullet' then
			TriggerClientEvent('hopelife:notify', player, 1, 'green', 'Wunde Versorgt', "Die Kugel/n wurde/n aus dem Körper entfernt!", 5000)
		elseif wound == 'stitch' then
			TriggerClientEvent('hopelife:notify', player, 1, 'green', 'Wunde Versorgt', "Die Stichverletzung/en wurde/n genäht!", 5000)
		elseif wound == 'burn' then
			TriggerClientEvent('hopelife:notify', player, 1, 'green', 'Wunde Versorgt', "Die Verbrennung/en wurde/n behandelt", 5000)
		end
end)

RegisterServerEvent('gl-ambulance:checkPlayerWounds',function(target,wound)
	local player = ESX.GetPlayerFromId(source).source
	local targetPlayer = ESX.GetPlayerFromId(target).source

	TriggerClientEvent('gl-ambulance:checkPlayerWounds',targetPlayer,player,wound)

end)

RegisterServerEvent('gl-ambulance:revivePlayer',function(target)
	TriggerClientEvent('gl-ambulance:revivePlayer',target)
end)


RegisterServerEvent('gl-ambulance:deleteBag', function(netId)
    TriggerClientEvent("gl-ambulance:deleteBag", -1, netId)
end)

RegisterServerEvent('gl-ambulance:delStretcher', function(netId)
    TriggerClientEvent("gl-ambulance:delStretcher", -1, netId)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('stretcher',1)
end)


RegisterServerEvent('gl-ambulance:goNightNight',function(player)
	local player = ESX.GetPlayerFromId(player).source
	TriggerClientEvent('gl-ambulance:goNightNight',player)
end)

RegisterServerEvent('gl-ambulance:putInVehicle',function(target,vehicle)

	TriggerClientEvent('gl-ambulance:putInVehicle', target,vehicle)
end)

RegisterServerEvent('gl-ambulance:getOutVehicle',function(target)
	TriggerClientEvent('gl-ambulance:getOutVehicle', target)
end)

RegisterServerEvent('gl-ambulance:putOnStretcher',function(target)
	TriggerClientEvent('gl-ambulance:putOnStretcher', target)
end)

RegisterServerEvent('gl-ambulance:getupKICK',function(target)
	TriggerClientEvent('gl-ambulance:getupKICK', target)
end)
RegisterServerEvent('gl-ambulance:checkInNancy',function(target)
	TriggerClientEvent('gl-ambulance:checkInNancy', target)
end)



RegisterServerEvent('gl-ambulance:bodyBag',function(target)
	TriggerClientEvent('gl-ambulance:bodyBag', target)
end)

RegisterServerEvent('gl-ambulance:checkPulse',function(target)
	print('Checking Pulse')
	TriggerClientEvent('gl-ambulance:sendPulseBack',target,source)
end)

RegisterServerEvent('gl-ambulance:reportPulseBack',function(target,pulse,status)
	-- TriggerClientEvent("swt_notifications:caption",target,status,"Pulse: " .. pulse,'top',15000,'blue-10','grey-1',true)
    TriggerClientEvent('hopelife:notify', target, 1, '#5f0085', 'Pulse', "Status: ".. status .. "<br />Pulse: ".. pulse, 15000)
end)

RegisterServerEvent('gl-ambulance:removeDefib',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('defib',1)
end)

RegisterServerEvent('gl-ambulance:removeDeathItems',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('linden_inventory:clearPlayerInventory', xPlayer)


--[[	
	if xPlayer.getMoney() > 0 then
		xPlayer.removeMoney(xPlayer.getMoney())
	end
	if xPlayer.getAccount('black_money').money > 0 then
		xPlayer.setAccountMoney('black_money', 0)
	end
	]]


end)


-- RegisterServerEvent('gl-ambulance:send911',function(message,pedID, coords)
-- 	lastResponder = pedID
-- 	TriggerClientEvent('gl-ambulance:receive911',-1,message,coords)
-- end)


-- RegisterServerEvent('gl-ambulance:911r', function(message)
-- 	if message ~= nil then
-- 		 TriggerClientEvent("swt_notifications:default",lastResponder,"Emergency Responder: " .. message ,'top','red','white',15000,true)
-- 		--TriggerClientEvent('hopelife:notify', lastResponder, 1, '#5f0085', 'Notruf gesendet!', 'Eine Verletzte Person bitte sofort reagieren!', 15000)
-- 	end
-- end)

-- Callbacks


ESX.RegisterServerCallback("gl-ambulance:getEMSCount", function(source, cb)
	local Players = ESX.GetPlayers()
	local ambulanceCount = 0
	for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer["job"]["name"] == 'ambulance' then
        	ambulanceCount = ambulanceCount + 1
        end
    end
    cb(ambulanceCount)
end)

-- Items
ESX.RegisterUsableItem('tweezers',function(source)
	TriggerClientEvent('gl-ambulance:tryTreatingPlayer',source,'bullet')
end)


ESX.RegisterUsableItem('suturekit',function(source)
	TriggerClientEvent('gl-ambulance:tryTreatingPlayer',source,'stitch')
end)

ESX.RegisterUsableItem('burncream',function(source)
	TriggerClientEvent('gl-ambulance:tryTreatingPlayer',source,'burn')
end)

ESX.RegisterUsableItem('defib',function(source)
	TriggerClientEvent('gl-ambulance:tryRevivePlayer',source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('defib',1)
end)

ESX.RegisterUsableItem('medbag',function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('medbag',1)
	TriggerClientEvent('gl-ambulance:useMedBag',source)
end)

ESX.RegisterUsableItem('sedative',function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sedative',1)
	TriggerClientEvent('gl-ambulance:useSedative',source)
end)

ESX.RegisterUsableItem('stretcher',function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('stretcher',1)
	TriggerClientEvent('gl-ambulance:useStretcher',source)
end)

ESX.RegisterUsableItem('wheelchair',function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('gl-ambulance:useWheelChair',source)
end)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('gl-ambulance:useItem', source, 'medikit')

		Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('gl-ambulance:useItem', source, 'bandage')

		Wait(10000)
		playersHealing[source] = nil
	end
end)

-- Commands

ESX.RegisterCommand('revive', {'admin', 'dev', 'mod', 'support'}, function(source, args)
	args = table.concat(args, ' ')
	if args == "me" then
		args = source.playerId
	end
	TriggerClientEvent('gl-ambulance:revivePlayer', args)
end, true)


ESX.RegisterCommand('heal', 'admin', function(source, args)
	args = table.concat(args, ' ')
	if args == "me" then
		args = source.playerId
	end
	TriggerClientEvent('gl-ambulance:adminHeal',args)
end, true)

ESX.RegisterServerCallback('gl-ambulance:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end

		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end


		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end


	cb()
end)



AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end
	if deadPlayers[eventData.id] then
		TriggerClientEvent('gl-ambulance:revivePlayer', eventData.id)
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	-- TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)