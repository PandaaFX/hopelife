ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)		--Edit this if the resource is using too much resources.   
    local playerVeh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    if PlayerVeh ~= 0 then SetPedConfigFlag(GetPlayerPed(-1), 35, false) end
  end	
end)
