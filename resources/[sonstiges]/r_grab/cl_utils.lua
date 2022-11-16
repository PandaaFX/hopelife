/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-police-grab-ped
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Compatibility init ]]

if Config.ESX.enabled then
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.QB.enabled then
    QBdata = {}

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBdata = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        QBdata.job = JobInfo
    end)
end

-- [[ Functions ]]

-- Compare the player's job with the one in the script configuration (only if ESX or QB is enabled)
function verifyJobPlayer()
    if Config.ESX.enabled then
        local ESXdata = ESX.GetPlayerData()
        for i = 1, #Config.ESX.jobs do
            if ESXdata.job ~= nil then
                if ESXdata.job.name == Config.ESX.jobs[i] then
                    return true
                end
            end
        end
    elseif Config.QB.enabled then
        for i = 1, #Config.QB.jobs do
            if QBdata.job and QBdata.job.name == Config.QB.jobs[i] then
                return true
            end
        end
    else
        return true
    end

    return false
end

-- You can modify the notification system of the script (do not change the name of the function)
function Hint(message)
    AddTextEntry('r_grab', message)
    BeginTextCommandDisplayHelp('r_grab')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

-- Blocks the player when he is dragged
function DisableControl()
    DisableControlAction(0, 24, true) -- Scroll Down
    DisableControlAction(0, 25, true) -- Scroll Down
    DisableControlAction(0, 14, true) -- Scroll Down
    DisableControlAction(0, 15, true) -- Scroll Up
    DisableControlAction(0, 23, true) -- Enter vehicle
    DisableControlAction(0, 24, true) -- Attack (LMB)
    DisableControlAction(0, 25, true) -- Aim (RMB)
    DisableControlAction(0, 37, true) -- Weapon Select (Tab)
    DisableControlAction(0, 44, true) -- Take Cover (Q)
    DisableControlAction(0, 140, true) -- Attack (R)
    DisableControlAction(0, 141, true) -- Attack (Q)
    DisableControlAction(0, 142, true) -- Attack (LMB)
    DisableControlAction(0, 257, true) -- Attack (LMB)
    DisableControlAction(0, 263, true) -- Attack (R)
    DisableControlAction(0, 264, true) -- Attack (Q)
end

-- [[ Command ]]

-- Command to control the resource (when CommandEnabled is activated)
if Config.CommandEnabled then
    RegisterCommand(Config.GrabCommand, function(_, args)
        if verifyJobPlayer() then
            fGrab(GetPedInFront())
        end
    end)

    RegisterCommand(Config.PutCarCommand, function(_, args)
        if verifyJobPlayer() then
            fPutCar(true)
        end
    end)

    RegisterCommand(Config.ExitCarCommand, function(_, args)
        if verifyJobPlayer() then
            fExitCar(true)
        end
    end)
else
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            if jobPlayer or grab ~= nil then
                if IsControlJustPressed(1, Config.Keys.GrabAndDropKey) then
                    fGrab(GetPedInFront())
                end
            end
        end
    end)
end

-- [[ Exports ]]

-- Export to drag the player
exports('GrabPlayer', function(player)
    if verifyJobPlayer() then
        fGrab(player)
    end
end)

-- Export to put the dragged player in the nearby vehicle
exports('PutCar', function()
    if verifyJobPlayer() then
        fPutCar(true)
    end
end)

-- Export to get out the player of the nearby vehicle
exports('ExitCar', function()
    if verifyJobPlayer() then
        fExitCar(true)
    end
end)

-- Export to get out the player of the nearby vehicle
exports('IsGrabbed', function()
    if draggedBy ~= nil then
        return true
    else
        return false
    end
end)