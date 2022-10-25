ESX.RegisterUsableItem('angel', function(source)
	TriggerClientEvent('rtd_fisher:caña', source)
end)

RegisterNetEvent('rtd_fisher:daritem')
AddEventHandler('rtd_fisher:daritem', function(x, y)
	local xPlayer = ESX.GetPlayerFromId(source)
	local weight1 = 1
	local weight2 = 2
	local weight3 = 3
	local weight = math.random(1,3)
	if xPlayer then
		if xPlayer.canCarryItem(x, weight3) then
			if weight == weight1 then
				xPlayer.showNotification('Du fängst einen Fisch mit '..weight1..' KG!')
				xPlayer.addInventoryItem(x, y)
			elseif weight == weight2 then
				xPlayer.showNotification('Du fängst einen Fisch mit '..weight2..' KG!')
				xPlayer.addInventoryItem(x, 2)
			elseif weight == weight3 then
				xPlayer.showNotification('Du fängst einen Fisch mit '..weight3..' KG!')
				xPlayer.addInventoryItem(x, 3)
			end
		else
			xPlayer.showNotification('Für einen Großen Fang hast du keinen Platz')
		end
	end
end)

RegisterNetEvent('breaking')
AddEventHandler('breaking', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("angel", 1)
end)

RegisterNetEvent('rtd_fisher:vendermenos10')
AddEventHandler('rtd_fisher:vendermenos10', function(cantidad)
	local xPlayer = ESX.GetPlayerFromId(source)
    local item = RTD.nombrepez
	local count = cantidad
	local pricepu = RTD.preciopez
	local price = count * RTD.preciopez
	local xPescado = xPlayer.getInventoryItem(item)

	if xPlayer then
		if xPescado.count >= count then
			xPlayer.removeInventoryItem(item, count)
		    xPlayer.addAccountMoney('money', price)
		    xPlayer.showNotification('Du verkaufst '..count..' Fisch!')
		else
			xPlayer.showNotification('Du hast keinen Fisch')
		end
	end
end)

RegisterNetEvent('rtd_fisher:terminarmision')
AddEventHandler('rtd_fisher:terminarmision', function(cantidad)
	local xPlayer = ESX.GetPlayerFromId(source)
    local item = RTD.nombrepez
	local count = cantidad
	local pricepu = RTD.preciopez
	local price = count * pricepu
	local xPescado = xPlayer.getInventoryItem(item)

	if xPlayer then
		if xPescado.count >= count then
			xPlayer.removeInventoryItem(item, count)
		    xPlayer.addAccountMoney('money', price)
		    xPlayer.showNotification('Fertig, hier ist Ihre Zahlung !')
			xPlayer.showNotification('Du hast verkauft '..count.. ' Fisch, und bekommst $ '..price..'')
		else
			xPlayer.showNotification('Kein Fisch mehr')
		end
	end
end)

RegisterNetEvent('rtd_fisher:comprarobjeto')
AddEventHandler('rtd_fisher:comprarobjeto', function(cantidad)
	local xPlayer = ESX.GetPlayerFromId(source)
    local item = RTD.ncanap
	local count = cantidad
	local price = count * RTD.preciocanap

	if xPlayer then
		if xPlayer.canCarryItem(item, count) then
			if xPlayer.getMoney() >= price then
				xPlayer.removeAccountMoney('money', price)
				xPlayer.addInventoryItem(item, count)
			else
				xPlayer.showNotification('Du hast nicht genug Geld')
			end
		else
			xPlayer.showNotification('Sie haben nicht genug Platz')
		end
	end
end)
