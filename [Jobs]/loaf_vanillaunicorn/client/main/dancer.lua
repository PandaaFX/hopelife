function PoledanceHandler(data, markerdata)
    local club, pole, poledata = table.unpack(data)
    if GetClubData(club, "pole_"..pole) then 
        return Notify(Strings["occupied"])
    end

    if not lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", true, "pole_", club, pole) then
        return Notify(Strings["occupied"])
    end
    while GetClubData(club, "pole_"..pole) ~= cache.source do
        Wait(50)
    end
    
    lib.RemoveMarker(cache.jobMarkers[club].poledance[pole])

    local refresh, scene = GetGameTimer()
    local function RefreshScene()
        local time = 0.0
        if scene then
            time = GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(scene))
        end
        scene = NetworkCreateSynchronisedScene(poledata.Position, vector3(0.0, 0.0, 0.0), 2, false, true, 1065353216, time, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict(poledata.dict or "mini@strip_club@pole_dance@pole_dance1"), poledata.anim or "pd_dance_01", 1.5, -4.0, 1, 1, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)

        refresh = GetGameTimer() + 5000
    end
    RefreshScene()

    AddTextEntry(GetCurrentResourceName().."poledancing_helptext", Strings["cancel_dance"])
    BeginTextCommandDisplayHelp(GetCurrentResourceName().."poledancing_helptext")
    EndTextCommandDisplayHelp(0, true, false, 0)

    while GetClubData(club, "pole_"..pole) == cache.source do
        Wait(0)

        if Config.RefreshPoledance and refresh <= GetGameTimer() then
            RefreshScene()
        end

        if IsDisabledControlJustReleased(0, 194) then
            lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", false, "pole_", club, pole)
        end
    end

    cache.jobMarkers[club].poledance[pole] = lib.AddMarker(markerdata, nil, nil, PoledanceHandler)
    NetworkStopSynchronisedScene(scene)
    ClearHelpText()
end

function LapdanceHandler(data, markerdata)
    local club, chair, chairdata = table.unpack(data)
    if GetClubData(club, "lap_"..chair) then 
        return Notify(Strings["occupied"])
    end

    if not lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", true, "lap_", club, chair) then
        return Notify(Strings["occupied"])
    end
    while GetClubData(club, "lap_"..chair) ~= cache.source do
        Wait(50)
    end

    lib.RemoveMarker(cache.jobMarkers[club].lapdance[chair])

    local player = PlayerPedId()

    local part = chairdata.part or 1
    if part < 1 or part > 3 then part = 1 end

    FreezeEntityPosition(player, true)
    SetEntityCoords(player, chairdata.dance.xyz) 
    SetEntityHeading(player, chairdata.dance.w)

    local dict, anim = LoadDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p"..part), "ld_girl_a_song_a_p"..part.."_f"
    TaskPlayAnim(player, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)


    AddTextEntry(GetCurrentResourceName().."poledancing_helptext", Strings["cancel_dance"])
    BeginTextCommandDisplayHelp(GetCurrentResourceName().."poledancing_helptext")
    EndTextCommandDisplayHelp(0, true, false, 0)

    while GetClubData(club, "lap_"..chair) == cache.source do
        Wait(0)

        if IsDisabledControlJustReleased(0, 194) then
            lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", false, "lap_", club, chair)
        end
    end

    FreezeEntityPosition(player, false)
    ClearHelpText()
    cache.jobMarkers[club].lapdance[chair] = lib.AddMarker(markerdata, nil, nil, LapdanceHandler)
    
    local dict, anim = LoadDict("mini@strip_club@lap_dance@ld_girl_a_exit"), "ld_girl_a_exit_f"
    TaskPlayAnim(player, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
    while not IsEntityPlayingAnim(player, dict, anim, 3) do Wait(0) end
    while IsEntityPlayingAnim(player, dict, anim, 3) do 
        Wait(0) 
        if GetEntityAnimCurrentTime(player, dict, anim) >= 0.95 then break end
    end
    TaskPlayAnim(player, LoadDict("mini@strip_club@lap_dance@ld_girl_a_wait"), "ld_girl_a_wait_f", 8.0, -8.0, -1, 1, 0, false, false, false)
    while true do
        Wait(0)

        if IsDisabledControlJustPressed(0, 32) or IsDisabledControlJustPressed(0, 33) or IsDisabledControlJustPressed(0, 34) or IsDisabledControlJustPressed(0, 35) then
            break
        end
    end
    ClearPedTasks(player)
end