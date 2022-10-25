ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
  while ESX.GetPlayerData().job == nil do
    Wait(1)
  end
  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setMetadata')
AddEventHandler('esx:setMetadata', function(md)
	PlayerData.metadata = md
end)

local badgeShown = false

RegisterNetEvent("an_badges:showBadge", function(design, avatar, fullname, number, rank)
  local player, distance = ESX.Game.GetClosestPlayer()
  local cs = Config.DefaultCallsign
  if PlayerData.metadata then
	cs = PlayerData.metadata.callsign
  end
  if design == "fib.png" then
    fullname = ""
  end
  local NUIdata = { action = "open", design = design, avatar = avatar, callsign = cs, rank = rank, name = fullname, number = number}
  local playerPed = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(playerPed))
  local prop = CreateObject(GetHashKey('prop_fib_badge'), x, y, z + 0.2, true, true, true)
  local boneIndex = GetPedBoneIndex(playerPed, 28422)
  if not IsPedInAnyVehicle(playerPed, false) then
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
  end
  RequestAnimDict("paper_1_rcm_alt1-9")
  while not HasAnimDictLoaded("paper_1_rcm_alt1-9") do
    Citizen.Wait(10)
  end
  TaskPlayAnim(playerPed, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 2.5, -8, 10.0, 49, 0, 0, 0, 0)
  Citizen.Wait(500)
  if distance ~= -1 and distance <= 5.0 then
    TriggerServerEvent('an_badges:showSV', GetPlayerServerId(player), NUIdata)
    TriggerEvent("an_badges:showCL", NUIdata)
  else
    TriggerEvent("an_badges:showCL", NUIdata)
  end
  Citizen.Wait(3000)
  ClearPedSecondaryTask(playerPed)
  DeleteObject(prop)
end)

RegisterNetEvent('an_badges:showCL')
AddEventHandler('an_badges:showCL', function(NUIdata)
  SendNUIMessage(NUIdata)
  badgeShown = true
end)

Citizen.CreateThread(function()
  local wait = 1500
  while true do
    Citizen.Wait(wait)
    if badgeShown then
      wait = 0
      if IsControlJustPressed(0, 202) or IsControlJustPressed(0, 194) then
        SendNUIMessage({ action = "close" })
        badgeShown = false
      end
    else
      wait = 1500
    end
  end
end)

RegisterNetEvent("an_badges:createBadge", function()
  exports['an_dialogBox']:showDialog("create_badge", "Enter your badge avatar URL:", "https://media.discordapp.net/attachments/941719085270577212/1026352374157152316/unknown.png", "Recommended size: 100px x 120px | Use https://imgur.com or Discord to upload your image and get the direct link by right-clicking on the photo after uploading it and click: Copy image address", submitURL, nil, true)
end)

RegisterNetEvent("an_badges:notify", function(msg, type)
  ESX.ShowNotification(msg, type, 15000)
end)

function sanitize_string(source)
  local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
  return source:gsub( "['\"]", replacements )
end

function submitURL(url)
  if url ~= ""  and url ~= nil then
    local url2 = sanitize_string(url)
    TriggerServerEvent("an_badges:updateBadge", url2)
  end
end

RegisterCommand("badgeavatar", function()
  TriggerEvent("an_badges:createBadge")
end)