PLT = plt_plants
Plants = PLT.Plants
U = PLT.U
Changed = false
Now = os.time()
PlantList = {}
LastSaveJson = Now
ESX = nil
QBCore = nil

Citizen.CreateThread(function(...) 
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  if ESX == nil then  Citizen.Wait(500)
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end) 
  end 
  if ESX == nil then 
    QBCore = exports['qb-core']:GetCoreObject()
  end
  Citizen.CreateThread(function() 
    for k,v in pairs(Plants) do
      if ESX ~= nil then
          ESX.RegisterUsableItem(k, function(source)
            local src = source
            TriggerClientEvent("plt_plants:CanNewPlants",src,k)
          end)
      elseif QBCore ~= nil then
         QBCore.Functions.CreateUseableItem(k, function(source, item)
          local src = source
          TriggerClientEvent("plt_plants:CanNewPlants",src,k)
        end) 
      end
    end
  end)
  Citizen.Wait(1000)
  if PLT.GiveInfoWhenStart then
    local itemTablo = {}
    local items = "^3'^9"..PLT.Water.dbName.."^3', '^9"..PLT.Fertilizer.dbName.."^3', "
    for k,v in pairs(Plants) do
      itemTablo[k] = true
      itemTablo[v.exportItem] = true
      if v.extraItem then itemTablo[v.extraItem] = true end
    end
    for k,v in pairs(itemTablo) do
      items = items.."^3'^9"..k.."^3', "
    end
   -- print("^2plt_plants is ready for work. There are "..tableNum(PlantList).." plant. \n^2Make sure the following items are added to items list in the framework.\n^3"..items.."^7")
  end
end)

RegisterCommand("saveplants", function(source, args, rawCommand)
  if (source == 0) then
    SavePlantList()
    --print("^2all plants saved manuel: ^3"..os.date("%X").."^7")
  else
      --print("This command was executed by the server console, RCON client, or a resource. command:'saveplants'")
  end
end, true)

AddEventHandler('onResourceStop', function(resourceName)
   if (GetCurrentResourceName() ~= resourceName) then
    return
  end 
  SavePlantList()
  --print("^2all plants saved automatic: ^3"..os.date("%X").."^7")
end)
  
function PltAddItem(source,item,count)
  local src = source
  if ESX ~= nil then
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem(item,count)
  elseif QBCore ~= nil then
    local xPlayer = QBCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(10) end
    xPlayer.Functions.AddItem(item, count)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
  end
end

function PltRemoveItem(source,item,count,delete)
  local src = source
  if ESX ~= nil then
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem(item).count >= count then
      if delete == true then
        xPlayer.removeInventoryItem(item,count)
      end
      return true
    end
  elseif QBCore ~= nil then
    local xPlayer = QBCore.Functions.GetPlayer(src)
    while xPlayer == nil do Wait(10) end
    if xPlayer.Functions.GetItemByName(item) ~= nil then
      if xPlayer.Functions.GetItemByName(item).amount >= count then
        if delete == true then
          xPlayer.Functions.RemoveItem(item, count)
          TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
        end
        return true
      end
    end
  end
  return false
end

function PltCanHarvest(source,item,count,seedName,plantId)
--[[    local src = source
  if ESX ~= nil then
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem(item,count) then
      return true
    else
      sinleNotify(src,"error","You can't carry more item" ,5000)
      return false
    end
  elseif QBCore ~= nil then
    -------------------
  end  ]]
  return true
end

function PltGetIdentifier(source)
  local src = source 
  local ident = GetPlayerName(src)
  for k,v in ipairs(GetPlayerIdentifiers(src))do if string.sub(v, 1, string.len("steam:")) == "steam:" then ident = v break end end
  if ESX ~= nil then
    while ESX.GetPlayerFromId(src) == nil or  ESX.GetPlayerFromId(src).identifier == nil do Citizen.Wait(250) end
    ident =  ESX.GetPlayerFromId(src).identifier 
  elseif QBCore ~= nil then
    while QBCore.Functions.GetPlayer(src) == nil or  QBCore.Functions.GetPlayer(src).PlayerData == nil or QBCore.Functions.GetPlayer(src).PlayerData.citizenid == nil do   Citizen.Wait(250) end
    ident = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
  end
  return ident
end

RegisterNetEvent('plt_plants:SendLog')
AddEventHandler('plt_plants:SendLog', function(src,action,type,plantId,owner)  
  if PLT.PrintActionInfoToServerConsole then 
    --print(src.." / "..action.." / "..type.." / "..plantId.." / "..owner)
  end
--[[   if action == "deleted" then
  elseif action == "newPlant" then
  elseif action == "fire" then
  elseif action == "addWater" then
  elseif action == "addFertilizer" then
  elseif action == "Harvested" then
  end ]]
end)