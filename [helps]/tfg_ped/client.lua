local ped
local isSpawned = false
local frak = GetHashKey("BadFrak")
local respawnid = nil
local life = {}

local function spawnped(id)
    local pedModel = Config.Peds[id].model
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
    Wait(10)
    end
    ped = CreatePed(4, pedModel, Config.Peds[id].position.x, Config.Peds[id].position.y, Config.Peds[id].position.z, 100, false, false)
    SetEntityHeading(ped, Config.Peds[id].heading)
    FreezeEntityPosition(ped, Config.Peds[id].freeze)
    SetBlockingOfNonTemporaryEvents(ped, false)
    SetEntityInvincible(ped, Config.Peds[id].invincible)
    SetPedArmour(ped, 100)

    if Config.Peds[id].aggresiv then
        SetPedRelationshipGroupHash(ped, frak)
        SetPedCombatAttributes(ped, 0, true)
        SetPedCombatAttributes(ped, 5, true)
        SetPedCombatAttributes(ped, 46, true)
        SetRelationshipBetweenGroups(5, frak, GetHashKey("PLAYER"))
        SetPedFleeAttributes(ped, 0, true)
        SetPedAccuracy(ped, 100)
        GiveWeaponToPed(ped, GetHashKey('weapon_pistol'), 2000, true, false)

    end
    table.insert(life,{PedID= ped, ID = id})
end

local function contains(array, value)
    for i, v in ipairs(array) do
        if v.PedID == value then
            respawnid = v.ID
            return true
        end
    end
    return false
end  

local function checkdeath(cPed, pos)
    if contains(life, cPed) then
        if IsEntityDead(cPed) then

            spawnped(respawnid)
            DeleteEntity(cPed)
            table.remove(life, pos)

        end
    else
        print('Nix Tot')
    end
end

Citizen.CreateThread(function ()
    while true do
        if not isSpawned then
            for k, _ in pairs(Config.Peds) do
                spawnped(k)
            end
            isSpawned = true
        else
            for k, v in ipairs(life) do
                local cPed = v.PedID
                local position = k
                checkdeath(cPed, position)
            end
        end
        Citizen.Wait(1000)
    end
end)
