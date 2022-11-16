
ESX              = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local treatment = false
local timer = false
local pvp = false
local blips = {
    {name="Hospital", id=61, x = -666.000000, y = 320.149445, z = 82.081299, color = 1, heading=175.748032, scale=0.7 }
}

---------- FONCTIONS ----------
function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function ShowInfo(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

---------- CITIZEN ----------
Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_m_doctor_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
        Wait(1)
    end
    

    for _, item in pairs(blips) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipColour(item.blip, item.color)
        SetBlipAsShortRange(item.blip, true)
        SetBlipScale(item.blip, item.scale)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)

        dc = CreatePed(4, 0xd47303ac, item.x, item.y, item.z, item.heading, false, true)
        SetEntityHeading(dc, item.heading)
        FreezeEntityPosition(dc, true)
        SetEntityInvincible(dc, true)
        SetBlockingOfNonTemporaryEvents(dc, true)
        SetPedDiesWhenInjured(dc, false)
        SetPedCanPlayAmbientAnims(dc, true)
        SetPedCanRagdollFromPlayerImpact(dc, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, item in pairs(blips) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 20 then
                DrawMarker(0, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x,item.y,item.z, true) <= 5 then
                    ShowInfo("Drücke ~INPUT_VEH_HORN~ um behandelt zu werden ~r~(~h~~g~$75000~r~)", 0)
                    if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) < 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 5) then
                        TriggerEvent("pNotify:SetQueueMax", -1, "lmao", 10)
                        TriggerEvent("pNotify:SendNotification", {
                            text = "<b style = 'color:white'>Der Doktor behandelt dich, warte bitte....</b>",
                            type = "alert",
                            queue = "lmao",
                            timeout = 5000,
                            layout = "centerLeft"
                        })                        
                        treatment = true
                    end
                end
            end
            if (IsControlJustPressed(1,38)) and (GetEntityHealth(GetPlayerPed(-1)) == 200) and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 5) then
                TriggerEvent("pNotify:SendNotification", {
                    text = "<b style = 'color:red'>Du brauchst keine Behandlung.</b>",
                    type = "alert",
                    queue = "lmao",
                    timeout = 5000,
                    layout = "centerLeft"
                })
            end
            if treatment == true then
                Citizen.Wait(15000)
                timer = true
            end
            if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) <= 5) then
                ESX.TriggerServerCallback('hhfw:docOnline', function(EMSOnline)
                    if EMSOnline >= 1 then
                        TriggerEvent("pNotify:SendNotification", {
                            text = "<b style = 'color:white'>Es sind genug Medics Online.</b>",
                            type = "alert",
                            queue = "lmao",
                            timeout = 5000,
                            layout = "centerLeft"
                        })
                    else
                        TriggerServerEvent('hospital:price')
                        SetEntityHealth(GetPlayerPed(-1), 200)
                        if IsPedDeadOrDying(GetPlayerPed(-1), 1) then
                            TriggerEvent('ai_doc:revive', GetPlayerServerId(GetPlayerPed(-1)))
                            pvp = true
                        end
                        TriggerEvent("pNotify:SendNotification", {
                            text = "<b style = 'color:white'>Der Doktor hat dich behandelt.</b>",
                            type = "alert",
                            queue = "lmao",
                            timeout = 5000,
                            layout = "centerLeft"
                        })
                        treatment = false
                        timer = false  
                    end
                end)
                treatment = false
                timer = false
            end
            if treatment == true and timer == true and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), item.x, item.y, item.z, true) > 5) then
                TriggerEvent("pNotify:SendNotification", {
                    text = "<b style = 'color:white'>Du bist weggegangen, der Doktor kann dich so nicht behandeln!</b>",
                    type = "error",
                    queue = "lmao",
                    timeout = 5000,
                    layout = "centerLeft"
                })
                treatment = false
                timer = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if pvp then
            DisablePlayerFiring(PlayerPedId(), true)
            NetworkSetFriendlyFireOption(false)
            SetCanAttackFriendly(GetPlayerPed(-1), false, false)
            SetPlayerCanDoDriveBy(GetPlayerPed(-1), false)
            SetPedEnableWeaponBlocking(PlayerPedId(), true)
            SetCanPedEquipAllWeapons(PlayerPedId(), false)
            DisableControlAction(0, 140,true)
            BlockWeaponWheelThisFrame()
			DisableControlAction(0, 37,true)
            ESX.Progressbar("PVP deaktiviert", 900000,{
                FreezePlayer = false, 
                onFinish = function()
                DisablePlayerFiring(PlayerPedId(), false)
                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(GetPlayerPed(-1), true, true)
                SetPlayerCanDoDriveBy(GetPlayerPed(-1), true)
                SetPedEnableWeaponBlocking(PlayerPedId(), false)
                SetCanPedEquipAllWeapons(PlayerPedId(), true)
                DisableControlAction(0, 140,false)
                BlockWeaponWheelThisFrame()
				DisableControlAction(0, 37,false)
                ESX.ShowNotification('PVP aktiviert')
                pvp = false
            end})
        end
    end
end)
		
RegisterNetEvent("rechnung:notfallmediziner")
AddEventHandler("rechnung:notfallmediziner", function(price)
    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(-1), 'society_ambulance', 'Notfallmediziner', price)
end)

RegisterNetEvent('ai_doc:revive')
AddEventHandler('ai_doc:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	AnimpostfxStop('DeathFailOut')
	DoScreenFadeIn(800)
    TriggerServerEvent('esx_hospital:price')
end)


function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
    
end

