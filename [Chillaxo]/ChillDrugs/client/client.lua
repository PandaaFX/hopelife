ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

local function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

local function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
end

local function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

local function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, false, false, false)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

RegisterNetEvent('ChillDrugs:UseDrug', function(data)
    if data == 'weed' then
        ESX.Streaming.RequestAnimDict('amb@world_human_smoking@male@male_a@enter', function()
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER", 0, true)            
            Wait(20000)
            ClearPedTasksImmediately(PlayerPedId())
        end)
        CokeBaggyEffect()
    elseif data == 'lsd' then
        ESX.Streaming.RequestAnimDict('switch@trevor@trev_smoking_meth', function()
            TaskPlayAnim(PlayerPedId(), "switch@trevor@trev_smoking_meth","trev_smoking_meth_loop", 8.0, 1.0, 5000, 1, 1, false, false, false)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)
        EcstasyEffect()
    elseif data == 'meth' then
        ESX.Streaming.RequestAnimDict('switch@trevor@trev_smoking_meth', function()
            TaskPlayAnim(PlayerPedId(), "switch@trevor@trev_smoking_meth","trev_smoking_meth_loop", 8.0, 1.0, 5000, 1, 1, false, false, false)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)        
        MethBagEffect()
    elseif data == 'koks' then
        ESX.Streaming.RequestAnimDict('switch@trevor@trev_smoking_meth', function()
            TaskPlayAnim(PlayerPedId(), "switch@trevor@trev_smoking_meth","trev_smoking_meth_loop", 8.0, 1.0, 5000, 1, 1, false, false, false)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)
        CokeBaggyEffect()
    elseif data == 'hero' then
        ESX.Streaming.RequestAnimDict('switch@trevor@trev_smoking_meth', function()
            TaskPlayAnim(PlayerPedId(), "switch@trevor@trev_smoking_meth","trev_smoking_meth_loop", 8.0, 1.0, 5000, 1, 1, false, false, false)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)
        CrackBaggyEffect()
    elseif data == 'lean' then
        ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
            TaskPlayAnim(PlayerPedId(), 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)
        EcstasyEffect()
    elseif data == 'psilocybin' then
        ESX.Streaming.RequestAnimDict('switch@trevor@trev_smoking_meth', function()
            TaskPlayAnim(PlayerPedId(), "switch@trevor@trev_smoking_meth","trev_smoking_meth_loop", 8.0, 1.0, 5000, 1, 1, false, false, false)
            Wait(5000)
            ClearPedSecondaryTask(PlayerPedId())
        end)        
        MethBagEffect()
    end
end)
