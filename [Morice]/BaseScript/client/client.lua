ESX = nil

vehicle, coords, ped = 0, 0, 0

Citizen.CreateThread(function()
  ped = PlayerPedId()
  coords = GetEntityCoords(ped)
  vehicle = GetVehiclePedIsIn(ped)
  vehtype = GetVehicleClass(vehicle)
  vehcoords = GetEntityCoords(vehicle)
  pid = PlayerId()

  while true do
    ped = PlayerPedId()
    coords = GetEntityCoords(ped)
    vehicle = GetVehiclePedIsIn(ped)
    vehtype = GetVehicleClass(vehicle)
    vehcoords = GetEntityCoords(vehicle)
    pid = PlayerId()
    Wait(100)
  end
end)

Citizen.CreateThread(function() 
  while ESX == nil do 
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
      Citizen.Wait(0) 
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- Schnee und Schneeball Anfang

local PlayerData = {}

-- Citizen.CreateThread(function()
--     local loaded = false
    
--     while true do
--         if Config.Snowactiv then
--             SetWeatherTypeNowPersist('XMAS')
--         end
--         Citizen.Wait(0)
--         if IsNextWeatherType('XMAS') then
--             N_0xc54a08c85ae4d410(3.0)
--             SetForceVehicleTrails(true)
--             SetForcePedFootstepsTracks(true)
--             if not loaded then
--                 RequestScriptAudioBank("ICE_FOOTSTEPS", false)
--                 RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
--                 RequestNamedPtfxAsset("core_snow")
--                 while not HasNamedPtfxAssetLoaded("core_snow") do
--                     Citizen.Wait(0)
--                 end
--                 UseParticleFxAssetNextCall("core_snow")
--                 loaded = true
--             end
--             RequestAnimDict('anim@mp_snowball')
--             if IsControlJustReleased(0, 306) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
--                 TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0)
--                 Citizen.Wait(2000)
--                 GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 2, false, true)
-- 				        ESX.ShowNotification("Du hast 1x Schneeball gesammelt") -- Notify hinzugefügt finde ich schöner
--             end
--             if not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) then
--             end
--         else
--             if loaded then N_0xc54a08c85ae4d410(0.0) end
--             loaded = false
--             RemoveNamedPtfxAsset("core_snow")
--             ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
--             ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
--             SetForceVehicleTrails(false)
--             SetForcePedFootstepsTracks(false)
--         end
--     end
-- end)

-- Schnee und Schneeball Ende

-- Items Benutzen Anfang

local itemReward = { -- 0 = 10 green life, 1 = 10 armor, 2 = schneller laufen, 3 = regeneration
  joint = 1,
  ecstasy = 3,
  heroin = 2,
  mdma = 0,
}


local regTick = 0
local speedTick = 0
CreateThread(function()
  while true do
    Wait(1000)
    if regTick > 0 then
      regTick = regTick - 5
      local health = GetEntityHealth(ped) + 5
      if health > 200 then
        health = 200
      end
      SetEntityHealth(ped, health)
    end
    if speedTick > 0 then
      SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
      speedTick = speedTick - 1
    else
      SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    end
  end
end)

RegisterNetEvent("morice:drogenbenutzen", function(animation, time, item)
  if itemReward[item:lower()] ~= nil then
    local typ = itemReward[item:lower()]
    if typ == 0 then
      regTick = regTick + 10
    elseif typ == 1 then
      local armor = GetPedArmour(ped) + 10
      SetPedArmour(ped, armor)
    elseif typ == 2 then
      speedTick = speedTick + 120
    elseif typ == 3 then
      regTick = regTick + 120
    end
  end

  local playerPed = ped

  RequestClipSet(animation) 
  while not HasClipSetLoaded(animation) do
    Citizen.Wait(0)
  end

  Wait(math.random(1000, 3000))
  SetPedMovementClipset(playerPed, animation, true)
  Wait(math.random(1000, 3000))
  SetPedMotionBlur(playerPed, true)
  Wait(math.random(1000, 3000))
  SetTimecycleModifier("spectator5")
  Wait(math.random(1000, 3000))

  local player = PlayerId()
  SetRunSprintMultiplierForPlayer(player, 1.3)
  Wait(time)
  SetRunSprintMultiplierForPlayer(player, 1.0)		
  SetPedMotionBlur(playerPed, false)
  ResetPedMovementClipset(ped, 3000)
  ClearTimecycleModifier()
end)

-- Items Benutzen Ende

-- Anti VDM Anfang

Citizen.CreateThread(function()
  N_0x4757f00bc6323cfe(-1553120962, 0.0) 
end)

-- Anti VDM Ende

-- Anti Heal Anfang

Citizen.CreateThread(function()
  while true do
      ToggleUsePickupsForPlayer(PlayerId(), `PICKUP_HEALTH_STANDARD`, false)
      Wait(1000)
  end
end)

-- Anti Heal Ende

-- AntiCheat Allgemeines Anfang

local lastCoords

CreateThread(function()
    while true do
        if vehicle ~= 0 then

            -- anti tp to hangar
            if lastCoords and #(vehcoords - vector3(-1991.32, 3200.94, 32.16)) <= 8.0 then
                SetEntityCoords(vehicle, lastCoords)
            else
                lastCoords = vehcoords
            end
        end
        Wait(500)
    end
end)

-- AntiCheat Allgemeines Ende

-- AI Erkennung Anfang


local w = {"COMPONENT_PISTOL_CLIP_01","COMPONENT_PISTOL_CLIP_02","COMPONENT_AT_PI_FLSH","COMPONENT_COMBATPISTOL_CLIP_01","COMPONENT_COMBATPISTOL_CLIP_02","COMPONENT_AT_PI_SUPP","COMPONENT_APPISTOL_CLIP_01","COMPONENT_APPISTOL_CLIP_02","COMPONENT_PISTOL50_CLIP_01","COMPONENT_PISTOL50_CLIP_02","COMPONENT_AT_AR_SUPP_02","COMPONENT_MICROSMG_CLIP_01","COMPONENT_MICROSMG_CLIP_02","COMPONENT_AT_SCOPE_MACRO","COMPONENT_SMG_CLIP_01","COMPONENT_SMG_CLIP_02","COMPONENT_AT_AR_FLSH","COMPONENT_ASSAULTSMG_CLIP_01","COMPONENT_ASSAULTSMG_CLIP_02","COMPONENT_ASSAULTRIFLE_CLIP_01","COMPONENT_ASSAULTRIFLE_CLIP_02","COMPONENT_CARBINERIFLE_CLIP_01","COMPONENT_CARBINERIFLE_CLIP_02","COMPONENT_AT_SCOPE_MEDIUM","COMPONENT_AT_AR_SUPP","COMPONENT_ADVANCEDRIFLE_CLIP_01","COMPONENT_ADVANCEDRIFLE_CLIP_02","COMPONENT_AT_SCOPE_SMALL","COMPONENT_MG_CLIP_01","COMPONENT_MG_CLIP_02","COMPONENT_COMBATMG_CLIP_01","COMPONENT_COMBATMG_CLIP_02","COMPONENT_PUMPSHOTGUN_CLIP_01","COMPONENT_AT_SR_SUPP","COMPONENT_SAWNOFFSHOTGUN_CLIP_01","COMPONENT_ASSAULTSHOTGUN_CLIP_01","COMPONENT_ASSAULTSHOTGUN_CLIP_02","COMPONENT_BULLPUPSHOTGUN_CLIP_01","COMPONENT_SNIPERRIFLE_CLIP_01","COMPONENT_AT_SCOPE_LARGE","COMPONENT_AT_SCOPE_MAX","COMPONENT_HEAVYSNIPER_CLIP_01","COMPONENT_GRENADELAUNCHER_CLIP_01","COMPONENT_RPG_CLIP_01","COMPONENT_MINIGUN_CLIP_01","POLICE_TORCH_FLASHLIGHT","COMPONENT_SNSPISTOL_CLIP_01","COMPONENT_SNSPISTOL_CLIP_02","COMPONENT_BULLPUPRIFLE_CLIP_01","COMPONENT_BULLPUPRIFLE_CLIP_02","COMPONENT_SPECIALCARBINE_CLIP_01","COMPONENT_SPECIALCARBINE_CLIP_02","COMPONENT_HEAVYPISTOL_CLIP_01","COMPONENT_HEAVYPISTOL_CLIP_02","COMPONENT_AT_MUZZLE_01","COMPONENT_AT_MUZZLE_02","COMPONENT_AT_MUZZLE_03","COMPONENT_AT_MUZZLE_04","COMPONENT_AT_MUZZLE_05","COMPONENT_AT_MUZZLE_06","COMPONENT_AT_MUZZLE_07","COMPONENT_AT_SIGHTS","COMPONENT_AT_SR_SUPP_03","COMPONENT_AT_MUZZLE_08","COMPONENT_AT_PI_FLSH_03","COMPONENT_AT_PI_RAIL_02","COMPONENT_AT_PI_COMP_02","COMPONENT_DOUBLEACTION_CLIP_01","COMPONENT_HOMINGLAUNCHER_CLIP_01","COMPONENT_AT_PI_COMP_03","COMPONENT_GUSENBERG_CLIP_01","COMPONENT_GUSENBERG_CLIP_02","COMPONENT_VINTAGEPISTOL_CLIP_01","COMPONENT_VINTAGEPISTOL_CLIP_02","COMPONENT_MUSKET_CLIP_01","COMPONENT_FIREWORK_CLIP_01","COMPONENT_RAILGUN_CLIP_01","COMPONENT_MARKSMANRIFLE_CLIP_01","COMPONENT_MARKSMANRIFLE_CLIP_02","COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM","COMPONENT_HEAVYSHOTGUN_CLIP_01","COMPONENT_HEAVYSHOTGUN_CLIP_02","COMPONENT_FLAREGUN_CLIP_01","COMPONENT_MARKSMANPISTOL_CLIP_01","COMPONENT_COMBATPDW_CLIP_01","COMPONENT_COMBATPDW_CLIP_02","COMPONENT_DBSHOTGUN_CLIP_01","COMPONENT_MACHINEPISTOL_CLIP_01","COMPONENT_MACHINEPISTOL_CLIP_02","COMPONENT_COMPACTRIFLE_CLIP_01","COMPONENT_COMPACTRIFLE_CLIP_02","COMPONENT_FLASHLIGHT_LIGHT","COMPONENT_REVOLVER_CLIP_01","COMPONENT_MINISMG_CLIP_01","COMPONENT_MINISMG_CLIP_02","COMPONENT_COMPACTLAUNCHER_CLIP_01","COMPONENT_AUTOSHOTGUN_CLIP_01","COMPONENT_AT_PI_RAIL","COMPONENT_AT_PI_FLSH_02","COMPONENT_AT_PI_COMP","COMPONENT_AT_SIGHTS_SMG","COMPONENT_AT_SCOPE_NV","COMPONENT_AT_SCOPE_THERMAL","COMPONENT_AT_MUZZLE_09"}

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(1000)
    end
    local data = json.decode('{"COMPONENT_VINTAGEPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":7,"rdm":0,"ca":7},"COMPONENT_AT_MRFL_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_AT_MUZZLE_09":{"rm":0,"rh":1061158912,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_AT_SCOPE_NV":{"rm":0,"rh":-1013321135,"ac":0,"dm":0,"cs":64309,"rdm":0,"ca":-1941898443},"COMPONENT_MARKSMANRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":16,"rdm":0,"ca":16},"COMPONENT_AT_SB_BARREL_02":{"rm":1.25,"rh":662,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_HEAVYSHOTGUN_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_PISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":16,"rdm":0,"ca":16},"COMPONENT_AT_SC_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_SNIPERRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":10,"rdm":0,"ca":10},"COMPONENT_RAILGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_MARKSMANRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":8,"rdm":0,"ca":8},"COMPONENT_AT_AR_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":1,"rdm":1.33333301544189,"ca":131073},"COMPONENT_FIREWORK_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_MILITARYRIFLE_SIGHT_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM":{"rm":0,"rh":-1013321135,"ac":0,"dm":0,"cs":35486,"rdm":0,"ca":-705656162},"COMPONENT_AT_SIGHTS":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_COMPACTLAUNCHER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_AT_SB_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_ADVANCEDRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_GUSENBERG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":50,"rdm":0,"ca":50},"COMPONENT_GADGETPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_AT_MUZZLE_05":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_COMBATSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_ASSAULTRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_AT_SCOPE_MACRO":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"POLICE_TORCH_FLASHLIGHT":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":1086324736},"COMPONENT_COMPACTRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_PISTOL50_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":9,"rdm":0,"ca":9},"COMPONENT_AT_SR_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_AT_PI_RAIL_02":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_GUSENBERG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_ASSAULTSHOTGUN_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":32,"rdm":0,"ca":32},"COMPONENT_SMG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_AT_PI_RAIL":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_AT_SCOPE_MAX":{"rm":0,"rh":-740620376,"ac":0,"dm":0,"cs":54088,"rdm":0,"ca":-333262008},"COMPONENT_AT_BP_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_BULLPUPRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AT_SCOPE_THERMAL":{"rm":0,"rh":-1013321135,"ac":0,"dm":0,"cs":64309,"rdm":0,"ca":-1941898443},"COMPONENT_AT_AR_FLSH":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":1086324736},"COMPONENT_ASSAULTRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AT_CR_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_AT_SCOPE_SMALL":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_COMPACTRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_HEAVYSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_AT_MG_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_DBSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":2,"rdm":0,"ca":2},"COMPONENT_MICROSMG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":16,"rdm":0,"ca":16},"COMPONENT_HEAVYPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":18,"rdm":0,"ca":18},"COMPONENT_AT_MUZZLE_03":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_ASSAULTSMG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_SAWNOFFSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":8,"rdm":0,"ca":8},"COMPONENT_AT_MUZZLE_08":{"rm":0,"rh":1061158912,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_CERAMICPISTOL_SUPP":{"rm":0,"rh":1065353216,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_AT_MUZZLE_04":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_MILITARYRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AT_PI_FLSH":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":1086324736},"COMPONENT_AT_PI_COMP_02":{"rm":0,"rh":1056964608,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_HEAVYPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":36,"rdm":0,"ca":36},"COMPONENT_CERAMICPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_AT_AR_SUPP":{"rm":0,"rh":1065353216,"ac":0,"dm":1,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_CARBINERIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_CERAMICPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":17,"rdm":0,"ca":17},"COMPONENT_COMBATPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":16,"rdm":0,"ca":16},"COMPONENT_GRENADELAUNCHER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":10,"rdm":0,"ca":10},"COMPONENT_AT_SC_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_HEAVYSNIPER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_COMBATMG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":100,"rdm":0,"ca":100},"COMPONENT_AT_SCOPE_LARGE":{"rm":0,"rh":-1013321135,"ac":0,"dm":0,"cs":64309,"rdm":0,"ca":-1941898443},"COMPONENT_APPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":36,"rdm":0,"ca":36},"COMPONENT_AT_SCOPE_MEDIUM":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_ASSAULTSMG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AT_SR_SUPP_03":{"rm":0,"rh":1065353216,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_MG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":54,"rdm":0,"ca":54},"COMPONENT_MACHINEPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":20,"rdm":0,"ca":20},"COMPONENT_CARBINERIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AUTOSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":10,"rdm":0,"ca":10},"COMPONENT_AT_PI_FLSH_03":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":1086324736},"COMPONENT_NAVYREVOLVER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_AT_SIGHTS_SMG":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_VINTAGEPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":14,"rdm":0,"ca":14},"COMPONENT_BULLPUPRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_AT_AR_BARREL_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_RPG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_AT_PI_SUPP":{"rm":0,"rh":1065353216,"ac":0,"dm":1,"cs":19851,"rdm":0,"ca":7556491},"COMPONENT_MUSKET_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_MG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":100,"rdm":0,"ca":100},"COMPONENT_SMG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_SNSPISTOL_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_MARKSMANPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_AT_MUZZLE_01":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_AT_CR_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_AT_AR_SUPP_02":{"rm":0,"rh":1065353216,"ac":0,"dm":1,"cs":19851,"rdm":0,"ca":7556491},"COMPONENT_ASSAULTSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":8,"rdm":0,"ca":8},"COMPONENT_SNSPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_AT_MG_BARREL_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":0},"COMPONENT_MINISMG_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":20,"rdm":0,"ca":20},"COMPONENT_AT_PI_COMP":{"rm":0,"rh":1056964608,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_PISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_PUMPSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":8,"rdm":0,"ca":8},"COMPONENT_PISTOL50_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_DOUBLEACTION_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_APPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":18,"rdm":0,"ca":18},"COMPONENT_HOMINGLAUNCHER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_MINIGUN_CLIP_01":{"rm":0,"rh":0,"ac":0,"dm":0,"cs":15000,"rdm":0,"ca":15000},"COMPONENT_AT_BP_BARREL_02":{"rm":1.25,"rh":0,"ac":0,"dm":0,"cs":0,"rdm":1.33333301544189,"ca":0},"COMPONENT_FLASHLIGHT_LIGHT":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":26214,"rdm":0,"ca":1088841318},"COMPONENT_SPECIALCARBINE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_AT_SR_SUPP":{"rm":0,"rh":1065353216,"ac":0,"dm":1,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_BULLPUPSHOTGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":14,"rdm":0,"ca":14},"COMPONENT_MACHINEPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_AT_MUZZLE_02":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_COMBATPDW_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_COMBATPDW_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_FLAREGUN_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":1,"rdm":0,"ca":1},"COMPONENT_AT_MUZZLE_07":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_SPECIALCARBINE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":60,"rdm":0,"ca":60},"COMPONENT_COMBATPISTOL_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":12,"rdm":0,"ca":12},"COMPONENT_AT_PI_COMP_03":{"rm":0,"rh":1056964608,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851},"COMPONENT_MINISMG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_MILITARYRIFLE_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":45,"rdm":0,"ca":45},"COMPONENT_MICROSMG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_REVOLVER_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":6,"rdm":0,"ca":6},"COMPONENT_AT_PI_FLSH_02":{"rm":0,"rh":1107296256,"ac":0,"dm":0,"cs":0,"rdm":0,"ca":1086324736},"COMPONENT_ADVANCEDRIFLE_CLIP_01":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":30,"rdm":0,"ca":30},"COMPONENT_COMBATMG_CLIP_02":{"rm":0,"rh":662,"ac":0,"dm":0,"cs":200,"rdm":0,"ca":200},"COMPONENT_AT_MUZZLE_06":{"rm":0,"rh":1059481190,"ac":0,"dm":0,"cs":19851,"rdm":0,"ca":19851}}')
    local detected = {}
    for i=1, #w do
        local g = w[i]
        local ac = GetWeaponComponentAccuracyModifier(GetHashKey(g))
        local cs = GetWeaponComponentClipSize(GetHashKey(g))
        local dm = GetWeaponComponentDamageModifier(GetHashKey(g))
        if ac ~= data[g].ac or cs ~= data[g].cs or dm ~= data[g].dm then
            table.insert(detected, g)
        end
    end
    if #detected > 0 then
        TriggerServerEvent('mxs:customban','Es wurde bei diesem Spieler AI erkannt', detected)
    end
end)

RegisterNetEvent('esx:playerLoaded', function()
  local ped = PlayerPedId()
  local selectedWeapon = GetSelectedPedWeapon(ped)
  if (selectedWeapon == -1569615261) then
  else
      TriggerServerEvent('mxs:customban','Loadout AI erkannt '..selectedWeapon)
  end
end)

-- AI Erkennung Ende

-- Autos werfen Anfang

CreateThread(function()
  while true do
    Wait(1000)

    if IsPedJumpingOutOfVehicle(PlayerPedId()) then
     Wait(20000)
    end

    local coords = GetEntityCoords(PlayerPedId())
    local vehicles = ESX.Game.GetVehiclesInArea(coords, 200)
    for i = 1, #vehicles, 1 do

        if not IsPedInAnyVehicle(PlayerPedId(), false) then
          owner = NetworkGetEntityOwner(vehicles[i])
          ownerID = GetPlayerServerId(owner)
          ped = GetPlayerServerId(PlayerId())

          if ped == ownerID then
  
            if GetEntitySpeed(vehicles[i]) > 70 then
              TriggerServerEvent('aw:discord', 'Dieser Spieler hat Script Freecam benutzt', 'Script Freecam', 'https://discord.com/api/webhooks/1032005577125138473/KOJVbbdOhSF5WzTlDjEv84t2aePhgkAUMx03rvNKKuWrOAe3W-SAZYOnajGeQzULVpA5')
              exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1032005577125138473/KOJVbbdOhSF5WzTlDjEv84t2aePhgkAUMx03rvNKKuWrOAe3W-SAZYOnajGeQzULVpA5', 'files[]', function(data)
                  local resp = json.decode(data)
              end)
              Citizen.Wait(1000)
              TriggerServerEvent('mxs:customban','Skript GG Freecam')
            end
          end
      end
    end
  end
end)

-- Autos werfen Ende

-- Sonstige Sachen Anfang

Citizen.CreateThread(function()
    SetPlayerTargetingMode(3)
    while true do
    Citizen.Wait(5000)
    RestorePlayerStamina(PlayerId(), 1.0)
    N_0xf4f2c0d4ee209e20() 
  end
end)

-- Sonstige Sachen Ende

