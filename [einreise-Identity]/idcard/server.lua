local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						elseif type =='bauamt' then
							if licenses[i].type == 'bauamt' then
								show = true
							end
						elseif type =='anwalt' then
							if licenses[i].type == 'anwalt' then
								show = true
							end
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('jsfour-idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "You don't have that type of license..")
				end
			end)
		end
	end)
end)

RegisterCommand('stumm', function(source, args)
	local src = source
	TriggerClientEvent('StummCmd', src)
end)

RegisterNetEvent('StummCMDServer', function(source, targetID, type)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false


		MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
		function (user)
			if (user[1] ~= nil) then
				MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
				function (licenses)
					if type ~= nil then
						for i=1, #licenses, 1 do
							if type == 'driver' then
								if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
									show = true
								end
							elseif type =='weapon' then
								if licenses[i].type == 'weapon' then
									show = true
								end
							elseif type =='bauamt' then
								if licenses[i].type == 'bauamt' then
									show = true
								end
							elseif type =='anwalt' then
								if licenses[i].type == 'anwalt' then
									show = true
								end
							elseif type == 'stumm' then
								if licenses[i].type == 'stumm' then
									show = true
								end
							end
						end
					else
						show = true
					end
	
					if show then
						local array = {
							user = user,
							licenses = licenses
						}
						TriggerClientEvent('jsfour-idcard:open', _source, array, type)
					else
						TriggerClientEvent('esx:showNotification', _source, "You don't have that type of license..")
					end
				end)
			end
		end)
end)