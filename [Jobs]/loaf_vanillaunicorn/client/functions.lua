cache = {}

CreateThread(function()
    cache.menuAlign = Config.MenuAlign or "bottom-right"
    cache.source = GetPlayerServerId(PlayerId())
    lib = exports["loaf_lib"]:GetLib()

    -- functions
    function GetClubData(club, data)
        return GlobalState[GetCurrentResourceName() .. "_" .. data] 
    end

    function LoadDict(dict)
        lib.LoadAnimDict(dict)
        return dict
    end

    function ClearHelpText()
        ClearAllHelpMessages()
        ClearHelp(true)
    end

    function Teleport(coords)
        DoScreenFadeOut(500)
        Wait(750)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.xyz)
        if coords.w then SetEntityHeading(PlayerPedId(), coords.w) end
        DoScreenFadeIn(500)
    end

    -- sitting
    function SitChairHandler(data, markerdata)
        local club, chair, chairdata = table.unpack(data)

        if GetClubData(club, "sit_"..chair) then 
            return Notify(Strings["occupied"])
        end
        if not lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", true, "sit_", club, chair) then
            return Notify(Strings["occupied"])
        end
        while GetClubData(club, "sit_"..chair) ~= cache.source do
            Wait(50)
        end

        lib.RemoveMarker(Config.Locations[club].Lapdance[chair].marker)

        local player = PlayerPedId()
        FreezeEntityPosition(player, true)
        SetEntityCoords(player, chairdata.sit.xyz - vector3(0.0, 0.0, 1.0)) 
        SetEntityHeading(player, chairdata.sit.w)

        TaskPlayAnim(player, LoadDict("mini@strip_club@lap_dance@ld_reach"), "ld_sit_idle", 8.0, -8.0, -1, 1, 0, false, false, false)
        local part = chairdata.part or 1
        if part < 1 or part > 3 then part = 1 end

        local canTouch, touching = false, false
        local pov = GetFollowPedCamViewMode()
        while GetClubData(club, "sit_"..chair) == cache.source do
            Wait(0)

            if chairdata.allowTouching then
                canTouch = GetClubData(club, "lap_"..chair) ~= false
            end

            if touching then
                AddTextEntry(GetCurrentResourceName().."sitting_help", Strings["stop_touch"])
            elseif canTouch then
                AddTextEntry(GetCurrentResourceName().."sitting_help", Strings["cancel_sit_touch"])
            else
                AddTextEntry(GetCurrentResourceName().."sitting_help", Strings["cancel_sit"])
            end
            BeginTextCommandDisplayHelp(GetCurrentResourceName().."sitting_help")
            EndTextCommandDisplayHelp(0, true, false, 0)

            if not touching and canTouch and IsDisabledControlPressed(0, 76) then
                local dict, anim = LoadDict("mini@strip_club@lap_dance@ld_reach"), "ld_sit_reach_enter"
                pov = GetFollowPedCamViewMode()
                
                SetFollowPedCamViewMode(4)

                TaskPlayAnim(player, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                while not IsEntityPlayingAnim(player, dict, anim, 3) do Wait(0) end
                while IsEntityPlayingAnim(player, dict, anim, 3) do 
                    Wait(0)
                    if GetEntityAnimCurrentTime(player, dict, anim) >= 0.95 then break end
                end

                local dict, anim = LoadDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p" .. part), "ld_girl_a_song_a_p"..part.."_m"
                TaskPlayAnim(player, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
                while not IsEntityPlayingAnim(player, dict, anim, 3) do Wait(0) end

                local dancerTime = GetEntityAnimCurrentTime(GetPlayerPed(GetPlayerFromServerId(GetClubData(club, "lap_"..chair))), "mini@strip_club@lap_dance@ld_girl_a_song_a_p"..part, "ld_girl_a_song_a_p"..part.."_f")
                SetEntityAnimCurrentTime(player, dict, anim, dancerTime)

                touching = true
            end

            if touching then
                if GetFollowPedCamViewMode() ~= 4 then
                    SetFollowPedCamViewMode(4)
                end
            end

            if touching and (not IsDisabledControlPressed(0, 76) or not canTouch) then
                local dict, anim = LoadDict("mini@strip_club@lap_dance@ld_reach"), "ld_sit_reach_exit"
                TaskPlayAnim(player, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

                while not IsEntityPlayingAnim(player, dict, anim, 3) do Wait(0) end
                while IsEntityPlayingAnim(player, dict, anim, 3) do 
                    Wait(0) 
                    if GetEntityAnimCurrentTime(player, dict, anim) >= 0.95 then break end
                end
                TaskPlayAnim(player, LoadDict(dict), "ld_sit_idle", 8.0, -8.0, -1, 1, 0, false, false, false)

                touching = false
                SetFollowPedCamViewMode(pov)
            end

            if IsDisabledControlJustReleased(0, 194) then
                lib.TriggerCallbackSync("loaf_vanillaunicorn:occupy", false, "sit_", club, chair)
            end
        end

        ClearPedTasks(player)
        FreezeEntityPosition(player, false)
        ClearHelpText()
        Config.Locations[club].Lapdance[chair].marker = lib.AddMarker(markerdata, nil, nil, SitChairHandler)
    end
end)