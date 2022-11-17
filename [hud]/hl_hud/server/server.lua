ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- TriggerEvent('es:addCommand', 'toggleui', function()
-- end, { help = _U('toggleui') })

--[[RegisterServerEvent('hl_hud:getServerInfo')
AddEventHandler('hl_hud:getServerInfo', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		local info = {
			money = xPlayer.getMoney(),
			bankMoney = xPlayer.getAccount('bank').money,
			blackMoney = xPlayer.getAccount('black_money').money,
		}
		
		TriggerClientEvent('hl_hud:setInfo', source, info)
	else
		return
	end
end)]]--

