ESX = nil
QBCore = nil
PlayerData = nil
PlayerJob = nil
PlayerGrade = nil

local VehicleData = nil


RegisterNetEvent('angelicxs-flipcar:Notify', function(message, type)
	if Config.UseCustomNotify then
        TriggerEvent('angelicxs-flipcar:CustomNotify',message, type)
	elseif Config.UseESX then
		ESX.ShowNotification(message)
	elseif Config.UseQBCore then
		QBCore.Functions.Notify(message, type)
	end
end)

CreateThread(function()
	if Config.UseESX then
		while ESX == nil do
			TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
			Wait(0)
		end
	
		while not ESX.IsPlayerLoaded() do
			Wait(100)
		end
	
		PlayerData = ESX.GetPlayerData()
		PlayerJob = PlayerData.job.name
		PlayerGrade = PlayerData.job.grade

		RegisterNetEvent("esx:setJob", function(job)
			PlayerJob = job.name
			PlayerGrade = job.grade
		end)

	elseif Config.UseQBCore then

		QBCore = exports["qb-core"]:GetCoreObject()

		CreateThread(function ()
			while true do
				PlayerData = QBCore.Functions.GetPlayerData()
				if PlayerData.citizenid ~= nil then
					PlayerJob = PlayerData.job.name
					PlayerGrade = PlayerData.job.grade.level
					break
				end
				Wait(100)
			end
		end)

		RegisterNetEvent("QBCore:Client:OnJobUpdate", function(job)
			PlayerJob = job.name
			PlayerGrade = job.grade.level
		end)
	end

    
    if Config.UseChatCommand then
        RegisterCommand(Config.ChatCommand, function()
            TriggerEvent('angelicxs-flipcar:flipcar')
        end)
    end
end)

function hasRequiredJob()
    local jobs = Config.Jobs == nil or next(Config.Jobs)
	if jobs then
		for jobName, gradeLevel in pairs(Config.Jobs) do
			if PlayerJob == jobName and PlayerGrade >= gradeLevel then
				return true
			end
		end
		return false
    else
        return true
	end
end

RegisterNetEvent('angelicxs-flipcar:flipcar')
AddEventHandler('angelicxs-flipcar:flipcar', function()
    local ped = PlayerPedId()
    local inside = IsPedInAnyVehicle(ped, true)
    if inside then
        TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['in_vehicle'], Config.LangType['error'])
    elseif hasRequiredJob() then
        local pedcoords = GetEntityCoords(ped)
        if Config.UseESX then
            VehicleData = ESX.Game.GetClosestVehicle()
        elseif Config.UseQBCore then
            VehicleData = QBCore.Functions.GetClosestVehicle()
        end
        local dist = #(pedcoords - GetEntityCoords(VehicleData))
        if dist <= 3 then
            RequestAnimDict('missfinale_c2ig_11')
            while not HasAnimDictLoaded("missfinale_c2ig_11") do
                Wait(10)
            end
            TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
            Wait(Config.TimetoFlip*1000)
            local carCoords = GetEntityRotation(VehicleData, 2)
            SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
            SetVehicleOnGroundProperly(VehicleData)
            TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['flipped'], Config.LangType['success'])
            ClearPedTasks(ped)
        else
            TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['far_away'], Config.LangType['error'])
        end
    else
        TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['not_allowed'], Config.LangType['error'])
    end
end)

CreateThread(function()
    if Config.UseThirdEye then
            exports[Config.ThirdEyeName]:Vehicle({
                options = {
                    {
                        event = "angelicxs-flipcar:flipcar",
                        icon = "fas fa-arrow-up",
                        label = "Flip Vehicle",
                        distance = 2
                    },
                },
            })
    end
end)

-- Vehicles to enable/disable air control
local vehicleClassDisableControl = {
    [0] = true,     --compacts
    [1] = true,     --sedans
    [2] = true,     --SUV's
    [3] = true,     --coupes
    [4] = true,     --muscle
    [5] = true,     --sport classic
    [6] = true,     --sport
    [7] = true,     --super
    [8] = false,    --motorcycle
    [9] = true,     --offroad
    [10] = true,    --industrial
    [11] = true,    --utility
    [12] = true,    --vans
    [13] = false,   --bicycles
    [14] = false,   --boats
    [15] = false,   --helicopter
    [16] = false,   --plane
    [17] = true,    --service
    [18] = true,    --emergency
    [19] = false    --military
}

-- Main thread
Citizen.CreateThread(function()
    while true do
        -- Loop forever and update every frame
        Citizen.Wait(0)

        -- Get player, vehicle and vehicle class
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehicleClass = GetVehicleClass(vehicle)

        -- Disable control if player is in the driver seat and vehicle class matches array
        if ((GetPedInVehicleSeat(vehicle, -1) == player) and vehicleClassDisableControl[vehicleClass]) then
            -- Check if vehicle is in the air and disable L/R and UP/DN controls
            if IsEntityInAir(vehicle) then
                DisableControlAction(2, 59)
                DisableControlAction(2, 60)
            end
        end
    end
end)
