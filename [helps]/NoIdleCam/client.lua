ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
    
end)


RegisterCommand('camoff', function() -- help2 31, 167, 9
  
  DisableIdleCamera(true)
  SetResourceKvp("idleCam", "off")
  ESX.ShowNotification("Idlecam Ausgeschalten")
end)

RegisterCommand('camon', function() -- help2 31, 167, 9
  
  DisableIdleCamera(false)
  SetResourceKvp("idleCam", "on")
  ESX.ShowNotification("Idlecam Angeschalten")
end)

Citizen.CreateThread(function()
  TriggerEvent("chat:addSuggestion", "/camon", "Re-enables the idle cam")
  TriggerEvent("chat:addSuggestion", "/camoff", "Disables the idle cam")
  
  local idleCamDisabled = GetResourceKvpString("idleCam") == "off" --- Idle Cam is on by default for new players / first time adding to server.
  DisableIdleCamera(idleCamDisabled)                               --- If you would prefer to have it off by default, change the value to "on"
end)
