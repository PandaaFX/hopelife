if Config.Rob then
    handsup = false

    -- handsup
    RegisterCommand('handsup', function()
        if IsEntityDead(PlayerPedId()) then 
            return
        end

        if IsPedInAnyVehicle(PlayerPedId(), false) then 
            return
        end 

        if not handsup then
            handsup = true
            LoadAnimDict("missminuteman_1ig_2", function()
                TaskPlayAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
            end) 
        else 
            ClearPedTasks(PlayerPedId())
            handsup = false
        end
    end)
    RegisterKeyMapping('handsup', 'Hands Up/Down', 'keyboard', Config.HandsupKey)
end