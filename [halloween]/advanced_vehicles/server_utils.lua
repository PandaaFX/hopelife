ESX = nil
TriggerEvent(Config.ESX.ESXSHAREDOBJECT, function(obj) ESX = obj end)

-- Function to check if is a owned vehicle
function IsOwnedVehicle(plate)
	local vehiclequery = MySQL_Sync_fetchAll("SELECT owner as user_id FROM owned_vehicles WHERE plate = @vehicle_plate", {['@vehicle_plate'] = plate})
	if vehiclequery[1] then
		return vehiclequery[1].user_id
	else
		return false
	end
end

-- Change the mysql driver there. Remove the mysql-async from fxmanifest
function MySQL_Sync_execute(sql,params)
	MySQL.Sync.execute(sql, params)
	-- exports['ghmattimysql']:executeSync(sql, params)
end

function MySQL_Sync_fetchAll(sql,params)
	return MySQL.Sync.fetchAll(sql, params)
	-- return exports['ghmattimysql']:executeSync(sql, params)
end