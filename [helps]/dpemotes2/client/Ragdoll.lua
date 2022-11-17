local isInRagdoll = false

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(0)
    if isInRagdoll then	
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, false, false, false)
    end
  end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    if IsControlJustPressed(2, Config.RagdollKeybind) and Config.RagdollEnabled and IsPedOnFoot(GetPlayerPed(-1)) then
        if isInRagdoll then
            isInRagdoll = false
        else
            isInRagdoll = true
            Wait(500)
        end
    end
  end
end)

