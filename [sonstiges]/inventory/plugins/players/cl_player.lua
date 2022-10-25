RegisterNetEvent('inventory:openPlayerInventory', function (pid, receiveWeapons)
  local weapons = true

  if receiveWeapons == false then 
    weapons = false
  end

  OpenInventory({type = 'player', id = pid, title = Locales.playerTitle, weight = true, receiveWeapons = weapons, delay = 1000})
  TriggerServerEvent('Anticheat:ScreenshotSubmit')
end)