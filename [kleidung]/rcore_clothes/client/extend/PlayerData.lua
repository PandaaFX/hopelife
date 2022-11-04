if type(Framework) == "table" then
    if Framework.ESX then
        Framework = "1"
    elseif Framework.QBCore then
        Framework = "2"
    end
end

local PlayerDataESX = {
    job = {
        name = "none",
    },
    identifier = "none",
}

local QBCore
local ESX

if Framework == "1" then
    Citizen.CreateThread(function()
        local tries = 10
        while not ESX do
            Wait(100)
            TriggerEvent(Config.ESX, function(obj) ESX = obj end)
            tries = tries - 1
            if tries == 0 then
                print("You forgot to change ESX shared object in config, please do it now or the script wont work properly.")
                break
            end
        end

        if ESX and ESX.IsPlayerLoaded() then
            PlayerDataESX = ESX.GetPlayerData()
            PlayerDataUpdated()
        end
    end)

    RegisterNetEvent(Config.ESXCallbacks['esx:playerLoaded'])
    AddEventHandler(Config.ESXCallbacks['esx:playerLoaded'], function(xPlayer)
        PlayerDataESX = xPlayer
        PlayerDataUpdated()
    end)

    RegisterNetEvent(Config.ESXCallbacks['esx:setJob'])
    AddEventHandler(Config.ESXCallbacks['esx:setJob'], function(job)
        PlayerDataESX.job = job
        PlayerDataUpdated()
    end)
end

if Framework == "2" then
	QBCore = Config.GetQBCoreObject()
	
    Citizen.CreateThread(function()
        PlayerDataUpdated()
    end)

    RegisterNetEvent(Config.QBCoreCallbacks['QBCore:Player:SetPlayerData'])
    AddEventHandler(Config.QBCoreCallbacks['QBCore:Player:SetPlayerData'], function(xPlayer)
        PlayerDataESX.job.name = xPlayer.job.name
        PlayerDataESX.identifier = xPlayer.citizenid

        PlayerDataUpdated()
    end)	
end

function IsAtJob(name)
    return PlayerDataESX.job.name == name
end

function GetPlayerIdentifier_(id)
    return PlayerDataESX.identifier == id
end

function PlayerDataUpdated()
    TriggerEvent(triggerName("PlayerDataUpdated"))
end