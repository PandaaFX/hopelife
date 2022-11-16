CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(250)
    end

    if Config.Options then
        if Config.Options.Stripper.PoleDancing then
            CreateThread(function()
                while true do
                    Wait(1000)

                        local stripping_pole = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("prop_strip_pole_01"), false, false, false)

                        if DoesEntityExist(stripping_pole) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(stripping_pole)) <= 1.5 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(stripping_pole) + vector3(0.0, 0.0, 1.0), "Drücke ~r~E~w~ zum Tanzen")
                                if IsControlJustReleased(0, 51) then
                                    local dance = GetOffsetFromEntityInWorldCoords(stripping_pole, 0.15, -0.2, 1.0)
                                    local randomdance = tostring(math.random(1, 3))
                                    local scene = NetworkCreateSynchronisedScene(dance, vector3(0.0, 0.0, 0.0), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@pole_dance@pole_dance" .. randomdance), "pd_dance_0" .. randomdance, 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)
                
                                    while true do
                                        Wait(0)
                                        
                                        HelpText("Drücke ~r~X~w~ um Aufzuhören", true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                end
                            end
                        end

                end
            end)
        end

        if Config.Options.Stripper.PoleDancing then
            CreateThread(function()
                while true do
                    Wait(1000)

                        local pole = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("v_19_strip3pole"), false, false, false)

                        if DoesEntityExist(pole) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(pole)) <= 1.5 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(pole) + vector3(0.0, 0.0, 1.0), "Drücke ~r~E~w~ zum Tanzen")
                                if IsControlJustReleased(0, 51) then
                                    local dance = GetOffsetFromEntityInWorldCoords(pole, -0.3, -1.75, -0.7)
                                    local randomdance = tostring(math.random(1, 3))
                                    local scene = NetworkCreateSynchronisedScene(dance, vector3(0.0, 0.0, 0.0), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@pole_dance@pole_dance" .. randomdance), "pd_dance_0" .. randomdance, 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)
                
                                    while true do
                                        Wait(0)
                                        
                                        HelpText("Drücke ~r~X~w~ um Aufzuhören", true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                end
                            end
                        end

                end
            end)
        end

        if Config.Options.Stripper.LapDance then
            CreateThread(function()
                while true do
                    Wait(1000)

                        local chair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("ex_mp_h_off_chairstrip_01"), false, false, false)

                        if DoesEntityExist(chair) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(chair)) <= 1.5 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(chair) + vector3(0.0, 0.0, 1.0), "Drücke ~r~E~w~ zum Tanzen/Drücke ~r~F~w~ zum hinsetzen")
                                if IsControlJustReleased(0, 51) then
                                    local dance_offset = GetOffsetFromEntityInWorldCoords(chair, 0.0, -1.25, 1.0)
                                    local randomlapdance = tostring(math.random(1, 3))
                                    local scene = NetworkCreateSynchronisedScene(dance_offset, vector3(0.0, 0.0, GetEntityHeading(chair)), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@private_dance@part" .. randomlapdance), "priv_dance_p" .. randomlapdance, 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)

                                    while true do
                                        Wait(0)
                                        
                                        HelpText("Drücke ~r~X~w~ um Beenden", true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                elseif IsControlJustReleased(0, 75) then
                                    local sit_offset = GetOffsetFromEntityInWorldCoords(chair, 0.0, -0.25, 0.6)

                                    local heading = GetEntityHeading(chair)
                                    if heading >= 180.0 then
                                        heading = heading - 179.9
                                    else
                                        heading = heading + 179.9
                                    end

                                    local scene = NetworkCreateSynchronisedScene(sit_offset, vector3(0.0, 0.0, heading), 2, false, true, 1065353216, 0, 1.3)
                                    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, LoadDict("mini@strip_club@lap_dance_2g@ld_2g_reach"), "ld_2g_sit_idle", 1.5, -4.0, 1, 1, 1148846080, 0)
                                    NetworkStartSynchronisedScene(scene)

                                    while true do
                                        Wait(0)
                                        
                                        HelpText("Drücke ~r~X~w~ um Beenden", true)
                                        if IsControlJustReleased(0, 73) or IsDisabledControlJustReleased(0, 73) then
                                            break
                                        end
                                    end
                    
                                    NetworkStopSynchronisedScene(scene)
                                end
                            end
                        end

                end
            end)
        end
        if Config.Options.Stripper.Zigarreten then
            CreateThread(function()
                while true do
                    Wait(1000)

                        local vend = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey("prop_vend_fags_01"), false, false, false)

                        if DoesEntityExist(vend) then
                            while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vend)) <= 1.5 do
                                Wait(0)
                                DrawTxt3D(GetEntityCoords(vend) + vector3(0.0, 0.0, 1.0), "Drücke ~r~E~w~ um Zigaretten zu kaufen ($50)")
                                if IsControlJustReleased(0, 51) then
                                    TriggerServerEvent("myShops:buyItemZigaretten")
                                end
                            end
                        end
                end
            end)
        end
    end
end)

LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end

    return Dict
end

DrawTxt3D = function(coords, text, sound, force)
    if not Config.Use3DText and not force then
        HelpText(text, (sound == true))
        return
    end

    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+2, stop-2) .. string.sub(text, stop, #text)
    end

    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)

	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

HelpText = function(text, sound)
    AddTextEntry(GetCurrentResourceName(), text)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 150)

    ClearDrawOrigin()
end


RegisterNetEvent('cigarett:startSmoke')
AddEventHandler('cigarett:startSmoke', function(source)
	SmokeAnimation()
end)



RegisterNetEvent('cohiba:startSmoke')
AddEventHandler('cohiba:startSmoke', function(source)
	SmokeCigarAnimation()
end)


RegisterNetEvent('ring:anziehen')
AddEventHandler('ring:anziehen', function(source)
	if not ring then
        ringON()
        ring = true
    else
        ringOFF()
        ring = false
    end
end)


function ringON()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, {['chain_1'] = 241,  ['chain_2'] = 0})
        else
            TriggerEvent('skinchanger:loadClothes', skin, {['chain_1'] = 177,  ['chain_2'] = 0})
        end  
    end)
end

function ringOFF()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, {['chain_1'] = -1,  ['chain_2'] = 0})
        else
            TriggerEvent('skinchanger:loadClothes', skin, {['chain_1'] = -1,  ['chain_2'] = 0})
        end  
    end)
end


function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)               
	end)
end

function SmokeCigarAnimation()
    Citizen.CreateThread(function()
	    local playerPed = GetPlayerPed(-1)
        ExecuteCommand("e cigar2")
    end)
end

