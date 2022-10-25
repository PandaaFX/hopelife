local function FindClosestPoledancer(club)
    local dist, closest = 9999.0
    
    for pole, coords in pairs(Config.Locations[club].Poledance) do
        local dancer = GetClubData(club, "pole_"..pole)
        
        if dancer and #(GetEntityCoords(PlayerPedId()) - coords.Position) < dist then
            closest = GetClubData(club, "pole_"..pole)
            dist = #(GetEntityCoords(PlayerPedId()) - coords.Position)
        end
    end

    return closest
end

function LeanHandler(data, markerdata)
    local action, club, lean = table.unpack(data)

    if GetClubData(club, "lean_"..lean) then 
        return Notify(Strings["occupied"])
    end

    if not lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", true, "lean_", club, lean) then
        return Notify(Strings["occupied"])
    end
    while GetClubData(club, "lean_"..lean) ~= cache.source do
        Wait(50)
    end

    lib.RemoveMarker(cache.lean[club][lean])

    local player = PlayerPedId()
    local leanData = Config.Locations[club].Lean[lean]
    local female = GetEntityModel(player) == `mp_f_freemode_01` and "_female" or ""

    SetEntityCoordsNoOffset(player, leanData.xyz)
    SetEntityHeading(player, leanData.w)
    FreezeEntityPosition(player, true)
    Wait(50)

    TaskPlayAnim(player, LoadDict("mini@strip_club@leaning@enter"), "enter"..female, 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(2750)
    TaskPlayAnim(player, LoadDict("mini@strip_club@leaning@base"), "base"..female, 8.0, -8.0, -1, 1, 0, false, false, false)

    AddTextEntry(GetCurrentResourceName().."leaning_helptext", Strings["cancel_lean"]:format(Config.ThrowMoney.toss, Config.ThrowMoney.rain))
    BeginTextCommandDisplayHelp(GetCurrentResourceName().."leaning_helptext")
    EndTextCommandDisplayHelp(0, true, false, 0)
    while GetClubData(club, "lean_"..lean) == cache.source do
        Wait(0)
        DisableControlAction(0, 194, true)
        DisableControlAction(0, 47, true)

        local throw, rain = IsDisabledControlJustReleased(0, 47), IsDisabledControlJustReleased(0, 51)
        if throw or rain then
            --local dancer = FindClosestPoledancer(club)
            -- local dancer = 1
            --if not dancer then
            --    Notify(Strings["no_dancer"])
            --else
                local threw = lib.TriggerCallbackSync("loaf_vanillaunicorn:throw_money", throw and "toss" or "rain")
                if not threw then
                    Notify(Strings["no_money"])
                else
                    if throw then
                        TossAnimation()
                    else
                        MakeItRainAnimation()
                    end
                    TaskPlayAnim(player, LoadDict("mini@strip_club@leaning@base"), "base"..female, 8.0, -8.0, -1, 1, 0, false, false, false)
                end
            --end
        end

        if IsDisabledControlJustReleased(0, 194) then 
            lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", false, "lean_", club, lean)
        end
    end
    ClearHelpText()

    cache.lean[club][lean] = lib.AddMarker(markerdata, nil, nil, LeanHandler)
    FreezeEntityPosition(player, false)

    TaskPlayAnim(player, LoadDict("mini@strip_club@leaning@exit"), "exit"..female, 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(2000)
    ClearPedTasks(player)
end