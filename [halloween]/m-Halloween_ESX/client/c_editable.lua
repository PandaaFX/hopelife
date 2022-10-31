ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Core, function(obj) ESX = obj end)
        Wait(0)
    end
end)

local Display = "3dtext"
local activ = false
local zone = 0
function ExportTargets()
    if Display == "target" then
        for k,v in pairs(Config.Doors) do
            zone = zone+1
            exports.qtarget:AddBoxZone(zone, v.coords, 2.0, 2.0, {
                name=zone, heading=0, debugPoly=false, minZ=v.z, maxZ=v.z+10
            }, {
                options = { { event = "m-Halloween:Client:KnockDoor", icon = "fas fa-door", label = Config.Language.qbTarget.knockDoor },}, distance = 2.5
            })             
        end

        exports.qtarget:AddTargetModel(`prop_veg_crop_03_pump`, {
            options = {
                {
                    event = "m-Halloween:Client:PickPumpkin",
                    icon = "fa-solid fa-apple-whole",
                    label = Config.Language.qbTarget.pickPumpkin,
                },
            },
            distance = 2.5
        })
        
        exports.qtarget:AddTargetModel(`prop_water_corpse_02`, {
            options = {
                {
                    event = "m-Halloween:Client:MenuTrading",
                    icon = "fa-solid fa-ghost",
                    label = Config.Language.qbTarget.tradePumpkins,
                },
            },
            distance = 2.5
        })
    elseif Display == "3dtext" then

        CreateThread(function() 
            while true do
            local inRange = false
            Wait(1) 
            local playerPed = PlayerPedId()
            local pos = GetEntityCoords(playerPed)
                for k,v in pairs(Config.Doors) do
                    local dist = #(pos - vector3(v.coords))
                    if dist < 3 then
                    inRange = true
                        if dist < 2 then
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z+1, "~g~[E]~s~ - An der Tür klopfen")
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent('m-Halloween:Client:KnockDoor')
                            end
                        end
                    end
                end
        
                for k,v in pairs(Config.Objects) do
                    local dist = #(pos - vector3(v.Location))
                        if dist < 3 then
                            inRange = true
                                if dist < 2.5 then
                                    local pumpkin = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.5, GetHashKey('prop_veg_crop_03_pump'), false, false, false)
                                    if DoesEntityExist(pumpkin) then
                                    DrawText3Ds(v.Location.x, v.Location.y, v.Location.z+1, "~g~[E]~s~ - Kürbis sammeln")
                                    if IsControlJustPressed(0, 38) and activ == false then
                                       
                                        
                                            activ = true
                                            TriggerEvent('m-Halloween:Client:PickPumpkin')
                                        
                                        
                                    end
                                end
                                end
                            
                        end
                end
                if inRange == false then
                    activ = false
                    Wait(1000)
                end
            end
    

        end)
        end
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end