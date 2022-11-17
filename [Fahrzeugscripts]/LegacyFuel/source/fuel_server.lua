ESX 					= nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

RegisterServerEvent("LegacyFuel:pagamento01")
AddEventHandler("LegacyFuel:pagamento01",function(price,galao,vehicle,fuel,fuel2,key)
	local source = source
	local output = {}
	local query = nil
	if key then
		local sql = "SELECT stock,price FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.defaultGasPrice,
				['stock'] = Config.defaultGasStock,
			}
		end
	else
		output = {
			['price'] = Config.defaultGasPrice, 	-- Default price
			['stock'] = Config.defaultGasStock,	-- Default amount
		}
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	if price > 0 then
		local amount = 0
		if galao then
			amount = price
		else
			amount = math.round(price/output.price)
			fuel = math.round(fuel/output.price)
		end
		if galao or output.stock > amount then
			money = xPlayer.getMoney()
			if money >= price then
				xPlayer.removeMoney(price)
				if galao then
					TriggerClientEvent('LegacyFuel:galao01',source)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid <b>$"..price.." </b> for the <b>jerry can</b>.",8000)
				else
					if key and query and query[1] then
						local sql = "UPDATE `gas_station_business` SET stock = @stock, customers = customers + 1, money = money + @price, total_money_earned = total_money_earned + @price, gas_sold = gas_sold + @amount WHERE gas_station_id = @gas_station_id";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@stock'] = ((output.stock) - amount), ['@price'] = price, ['@amount'] = amount});
						
						local sql = "INSERT INTO `gas_station_balance` (gas_station_id,income,title,amount,date) VALUES (@gas_station_id,@income,@title,@amount,@date)";
						MySQL.Sync.execute(sql, {['@gas_station_id'] = key, ['@income'] = 0, ['@title'] = "Fuel sold ("..amount.." Liters)", ['@amount'] = price, ['@date'] = os.time()});
					end
					
					TriggerClientEvent('fuel:setvehiclefuel',source,vehicle,fuel)
					TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid <b>$"..price.." </b> in "..amount.." liters.",8000)
				end
			else
				TriggerClientEvent("gas_station:Notify",source,"negado","Insuficient money.",8000)
			end
		else
			TriggerClientEvent("gas_station:Notify",source,"negado","Insuficient fuel stock (Max: "..output.stock.." liters).",8000)
		end
	end
end)

RegisterServerEvent('LegacyFuel:PandaaFXCB01')
AddEventHandler('LegacyFuel:PandaaFXCB01', function(key)
	local source = source
	if key then
		local sql = "SELECT stock,price,gas_station_name FROM gas_station_business WHERE gas_station_id = @gas_station_id";
		local query = MySQL.Sync.fetchAll(sql, {['@gas_station_id'] = key});
		local output = {}
		if query and query[1] then
			output = {
				['price'] = (query[1].price/100),
				['stock'] = query[1].stock,
				['gas_station_name'] = query[1].gas_station_name,
			}
			local sql = "UPDATE `gas_station_business` SET total_visits = total_visits + 1 WHERE gas_station_id = @gas_station_id";
			MySQL.Sync.execute(sql, {['@gas_station_id'] = key});
		else
			output = {
				['price'] = Config.defaultGasPrice,
				['stock'] = Config.defaultGasStock,
				['gas_station_name'] = 'Default',
			}
		end

		TriggerClientEvent('LegacyFuel:PandaaFXCB01', source, output)
	else
		local output = {
			['price'] = Config.defaultGasPrice,
			['stock'] = Config.defaultGasStock,
			['gas_station_name'] = 'Default',
		}
		TriggerClientEvent('LegacyFuel:PandaaFXCB01', source, output, nil)
	end
end)

RegisterServerEvent('LegacyFuel:PandaaFXSB02')
AddEventHandler('LegacyFuel:PandaaFXSB02', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	money = xPlayer.getMoney()
	if money >= Config.RefuelWithJerryCanCost then
		xPlayer.removeMoney(Config.RefuelWithJerryCanCost)
		TriggerClientEvent("gas_station:Notify",source,"sucesso","Paid $"..Config.RefuelWithJerryCanCost,8000)
		TriggerClientEvent('LegacyFuel:PandaaFXCB02', source, true)
	else
		TriggerClientEvent("gas_station:Notify",source,"negado","Nicht genügend Geld.",8000)
		TriggerClientEvent('LegacyFuel:PandaaFXCB02', source, false)
	end
end)