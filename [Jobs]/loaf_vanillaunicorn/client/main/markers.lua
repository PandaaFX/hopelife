function InitMarkers()
    cache.lean = {}
    for i, v in pairs(Config.Locations) do
        v.blip = lib.AddBlip({
            coords = v.Location,
            sprite = Config.Blip.sprite,
            color = Config.Blip.colour,
            scale = Config.Blip.scale,
            label = Strings["blip"]
        })
    
        if v.Bar.Teleport then
            v.Bar.teleportOutMarker = lib.AddMarker({
                coords = v.Bar.Teleport.Out.xyz - vector3(0.0, 0.0, 1.0),
                type = 1,
                callbackData = {press = v.Bar.Teleport.In},
                scale = Config.Marker.scale,
                r = Config.Marker.colour[1],
                g = Config.Marker.colour[2],
                b = Config.Marker.colour[3],
                alpha = Config.Marker.colour[4],
                key = "primary",
                text = Strings["exit_bar"],
            }, nil, nil, Teleport)
        end

        cache.lean[i] = {}
        for lean, location in pairs(v.Lean) do
            cache.lean[i][lean] = lib.AddMarker({
                coords = location.xyz - vector3(0.0, 0.0, 1.0),
                type = 1,
                callbackData = {
                    enter = {"enter", i, lean},
                    press = {"use", i, lean},
                    exit = {"exit", i, lean}
                },
                r = Config.LeanMarker.colour[1],
                g = Config.LeanMarker.colour[2],
                b = Config.LeanMarker.colour[3],
                alpha = Config.LeanMarker.colour[4],
                scale = Config.LeanMarker.scale,
                key = "primary",
                text = Strings["lean"],
            }, nil, nil, LeanHandler)
        end

        for chair, data in pairs(v.Lapdance) do
            data.marker = lib.AddMarker({
                coords = data.sit.xyz,
                type = 1,
                callbackData = {press = {i, chair, data}},
                alpha = 0,
                scale = vector3(1.5, 1.5, 0.5),
                key = "primary",
                text = Strings["sit"],
            }, nil, nil, SitChairHandler)
        end
    end
end

function ReloadMarkers()
    for club, locations in pairs(Config.Locations) do
        if not cache.hasJob and cache.jobMarkers then
            for i, marker in pairs(cache.jobMarkers[club].poledance or {}) do
                lib.RemoveMarker(marker)
            end
            cache.jobMarkers[club].poledance = nil

            if cache.jobMarkers[club].locker then
                lib.RemoveMarker(cache.jobMarkers[club].locker)
                cache.jobMarkers[club].locker = nil
            end

            for i, marker in pairs(cache.jobMarkers[club].lapdance or {}) do
                lib.RemoveMarker(marker)
            end
            cache.jobMarkers[club].lapdance = nil
        end

        if not cache.allowedLapdance then
            for chair, data in pairs(locations.Lapdance) do
                if not data.marker then
                    data.marker = lib.AddMarker({
                        coords = data.sit.xyz,
                        type = 1,
                        callbackData = {press = {club, chair, data}},
                        alpha = 0,
                        scale = vector3(1.5, 1.5, 0.5),
                        key = "primary",
                        text = Strings["sit"],
                    }, nil, nil, SitChairHandler)
                end
            end
        else
            for chair, data in pairs(locations.Lapdance) do
                if data.marker then
                    lib.RemoveMarker(data.marker)
                    data.marker = nil
                end
            end
        end

        if not cache.allowedBar then
            if locations.Bar.Teleport and locations.Bar.teleportInMarker then
                lib.RemoveMarker(locations.Bar.teleportInMarker)
                locations.Bar.teleportInMarker = nil
            end

            if locations.Bar.fridgeMarker then
                lib.RemoveMarker(locations.Bar.fridgeMarker)
                locations.Bar.fridgeMarker = nil
            end

            if locations.Bar.mixMarker then
                lib.RemoveMarker(locations.Bar.mixMarker)
                locations.Bar.mixMarker = nil
            end
        else
            if locations.Bar.Teleport and not locations.Bar.teleportInMarker then
                locations.Bar.teleportInMarker = lib.AddMarker({
                    coords = locations.Bar.Teleport.In.xyz - vector3(0.0, 0.0, 1.0),
                    type = 1,
                    callbackData = {press = locations.Bar.Teleport.Out},
                    scale = Config.Marker.scale,
                    r = Config.Marker.colour[1],
                    g = Config.Marker.colour[2],
                    b = Config.Marker.colour[3],
                    alpha = Config.Marker.colour[4],
                    key = "primary",
                    text = Strings["enter_bar"],
                }, nil, nil, Teleport)
            end

            if locations.Bar.Fridge and not locations.Bar.fridgeMarker and Config.Framework ~= "qb" then
                locations.Bar.teleportInMarker = lib.AddMarker({
                    coords = locations.Bar.Fridge - vector3(0.0, 0.0, 1.0),
                    type = 1,
                    callbackData = {press = club},
                    scale = Config.Marker.scale,
                    r = Config.Marker.colour[1],
                    g = Config.Marker.colour[2],
                    b = Config.Marker.colour[3],
                    alpha = Config.Marker.colour[4],
                    key = "primary",
                    text = Strings["open_fridge"],
                }, nil, nil, AccessFridge)
            end

            if locations.Bar.Mix and not locations.Bar.mixMarker then
                locations.Bar.mixMarker = lib.AddMarker({
                    coords = locations.Bar.Mix.xyz - vector3(0.0, 0.0, 1.0),
                    type = 1,
                    callbackData = {press = locations.Bar.Mix},
                    scale = Config.Marker.scale,
                    r = Config.Marker.colour[1],
                    g = Config.Marker.colour[2],
                    b = Config.Marker.colour[3],
                    alpha = Config.Marker.colour[4],
                    key = "primary",
                    text = Strings["mix_drink"],
                }, nil, nil, MixMenu)
            end
        end

        --[[if not cache.boss then
            if locations.bossMarker then
                lib.RemoveMarker(locations.bossMarker)
                locations.bossMarker = nil
            end
        else
            if not locations.bossMarker then
                locations.bossMarker = lib.AddMarker({
                    coords = locations.BossMenu - vector3(0.0, 0.0, 1.0),
                    type = 1,
                    callbackData = {},
                    scale = Config.Marker.scale,
                    r = Config.Marker.colour[1],
                    g = Config.Marker.colour[2],
                    b = Config.Marker.colour[3],
                    alpha = Config.Marker.colour[4],
                    key = "primary",
                    text = Strings["boss_actions"],
                }, nil, nil, OpenBossMenu)
            end
        end]]--

        if not cache.allowedStorage then
            if locations.storageMarker then
                lib.RemoveMarker(locations.storageMarker)
                locations.storageMarker = nil
            end
        else
            if not locations.storageMarker then
                locations.storageMarker = lib.AddMarker({
                    coords = locations.Storage - vector3(0.0, 0.0, 1.0),
                    type = 1,
                    callbackData = {press = club},
                    scale = Config.Marker.scale,
                    r = Config.Marker.colour[1],
                    g = Config.Marker.colour[2],
                    b = Config.Marker.colour[3],
                    alpha = Config.Marker.colour[4],
                    key = "primary",
                    text = Strings["inventory"],
                }, nil, nil, OpenStorage)
            end
        end
    end
    
    if not cache.hasJob or not cache.hasJob2 then return end
    if not cache.jobMarkers then
        cache.jobMarkers = {}
        for club = 1, #Config.Locations do
            cache.jobMarkers[club] = {}
        end
    end

    local hasOutfit = Outfits[cache.gradeName] ~= nil

    for club, location in pairs(Config.Locations) do
        if cache.jobMarkers[club].locker then
            if not hasOutfit then
                lib.RemoveMarker(cache.jobMarkers[club].locker)
                cache.jobMarkers[club].locker = nil
            end
        elseif hasOutfit then
            cache.jobMarkers[club].locker = lib.AddMarker({
                coords = location.Locker - vector3(0.0, 0.0, 1.0),
                type = 1,
                callbackData = {},
                r = Config.Marker.colour[1],
                g = Config.Marker.colour[2],
                b = Config.Marker.colour[3],
                alpha = Config.Marker.colour[4],
                scale = Config.Marker.scale,
                key = "primary",
                text = Strings["change_clothes"],
            }, nil, nil, LockerHandler)
        end

        if cache.allowedPoledance then
            if not cache.jobMarkers[club].poledance then
                cache.jobMarkers[club].poledance = {}
                for i, v in pairs(location.Poledance) do
                    cache.jobMarkers[club].poledance[i] = lib.AddMarker({
                        coords = v.Position,
                        type = 1,
                        callbackData = {press = {club, i, v}},
                        scale = vector3(1.5, 1.5, 1.0),
                        alpha = 0,
                        key = "primary",
                        text = Strings["poledance"],
                    }, nil, nil, PoledanceHandler)
                end
            end
        else
            for i, marker in pairs(cache.jobMarkers[club].poledance or {}) do
                lib.RemoveMarker(marker)
            end
            cache.jobMarkers[club].poledance = nil
        end

        if cache.allowedLapdance then
            if not cache.jobMarkers[club].lapdance then
                cache.jobMarkers[club].lapdance = {}
                for i, v in pairs(location.Lapdance) do
                    cache.jobMarkers[club].lapdance[i] = lib.AddMarker({
                        coords = v.dance.xyz,
                        type = 1,
                        callbackData = {press = {club, i, v}},
                        scale = vector3(1.5, 1.5, 1.0),
                        alpha = 0,
                        key = "primary",
                        text = Strings["lapdance"],
                    }, nil, nil, LapdanceHandler)

                    if v.marker then
                        lib.RemoveMarker(v.marker)
                        v.marker = nil
                    end
                end
            end
        else
            for i, marker in pairs(cache.jobMarkers[club].lapdance or {}) do
                lib.RemoveMarker(marker)
            end
            cache.jobMarkers[club].lapdance = nil
        end
    end
end