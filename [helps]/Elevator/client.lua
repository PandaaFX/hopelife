--[[

    Elevators for FiveM
    By DoJoMan18 (DoJoMan18.com).

    You can change the keys here, if you change them you have to also change them in the notifications on line 78. For more information see: (https://docs.fivem.net/docs/game-references/controls/)

--]]

key_floor_up = 188 -- ARROW UP
key_floor_down = 187 -- ARROW DOWN

--[[

The numbers in the elevators array (line 29) should always count up. Do not leave a gap like this:

    [1] = {
        (coords here)
    },
    [4] = {
        (coords here)
    },
    [10] = {
        (coords here)
    },

]]--

elevators = {
   --[[ [1] = { -- CASINO
        -- Floor 1
        {977.56, 74.03, 70.23, "Lobby"},
        -- Floor 2
        {967.24, 7.39, 81.16, "Garage"},
        -- Floor 3
        {981.78, 54.29, 115.16, "Penthouse"},
        ---Safe
        {949.92, 56.95, 59.88, "Safe"},
        ---Lager
        {967.26, 16.04, 59.88, "Lager"},
        --HOTEL
        {979.13, 38.59, 91.44, "Hotel"},
        --Warenannahme
        {965.36, 17.58, 65.84, "Liefereingang"},
        ---Security
        {967.27, 15.96, 71.84, "Sec/Manag"},
    },
    [2] = { -- CASINO
        -- Floor 1
        {953.36, 58.45, 75.43, "Bossraum"},
        -- Floor 3
        {965.22, 58.56, 112.55, "Penthouse"},
    },]]--
    [1] = { -- MD
        {-664.35, 326.05, 78.12, "Garage"},
        {-664.35, 326.05, 83.09, "Lobby"},
        {-664.35, 326.05, 88.02, "X-Ray"},
        {-664.35, 326.05, 92.74, "Manager"},
        {-664.35, 326.05, 140.12, "Dach"},
    },
}

Citizen.CreateThread(function()
    -- turn positions into vectors for faster calculations
    for i = 1, #elevators do
        for k,floor in ipairs(elevators[i]) do
            elevators[i][k] = {vector3(floor[1], floor[2], floor[3]), floor[4]}
        end
    end
    while true do
        Citizen.Wait(5)
        local player = PlayerPedId()
        local PlayerLocation = GetEntityCoords(player)

        for i = 1, #elevators do
            for k,floor in ipairs(elevators[i]) do
                -- New floor
                local Level = floor[1]
                local distance = #(PlayerLocation - Level)
                if distance < 2.0 then
                    -- Get the total amount of floors
                    local numFloors = #elevators[i]

                    -- Check if there are floors above and below our current floor
                    local floorUp = nil
                    if k < numFloors then
                        floorUp = elevators[i][k + 1]
                    end
                    local floorDown = nil
                    if k > 1 then
                        floorDown = elevators[i][k - 1]
                    end

                    -- Text to show
                    -- Show current floor
                    local message = "Aufzug (" .. (floor[2] or "Floor " .. k) .. ")"
                    if floorUp then
                        -- Show prompt to go up
                        message = message .. "~n~" .. "~INPUT_FRONTEND_UP~ " .. (floorUp[2] or "Floor " .. k + 1)
                    end
                    if floorDown then
                        -- Show prompt to go down
                        message = message .. "~n~" .. "~INPUT_FRONTEND_DOWN~ " .. (floorDown[2] or "Floor " .. k - 1)
                    end

                    -- Sent information how to use
                    MessageUpLeftCorner(message)

                    if floorUp ~= nil then
                        if IsControlJustReleased(1, key_floor_up) then
                            Citizen.Wait(1500)
                            -- Lets freeze the user so he can't get away..
                            FreezeEntityPosition(player, true)
                            Citizen.Wait(500)
                            -- Play some sounds the make the elevator extra cool! :D
                            PlaySoundFrontend(-1, "CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);
                            Citizen.Wait(4500)
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
                            Citizen.Wait(500)
                            PlaySoundFrontend(-1, "OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);

                            -- Is elevator a vehicle elevator?
                            if IsPedInAnyVehicle(player, true) then
                                -- Lets teleport the user / vehicle and unfreeze the user.
                                SetEntityCoords(GetVehiclePedIsUsing(player), floorUp[1])
                                FreezeEntityPosition(player, false)
                            else
                                -- Lets teleport the user / vehicle and unfreeze the user.
                                SetEntityCoords(player, floorUp[1])
                                FreezeEntityPosition(player, false)
                            end
                        end
                    end

                    if floorDown ~= nil then
                        if IsControlJustReleased(1, key_floor_down) then
                            Citizen.Wait(1500)
                            -- Lets freeze the user so he can't get away..
                            FreezeEntityPosition(player, true)
                            Citizen.Wait(500)
                            -- Play some sounds the make the elevator extra cool! :D
                            PlaySoundFrontend(-1, "CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);
                            Citizen.Wait(4500)
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
                            Citizen.Wait(500)
                            PlaySoundFrontend(-1, "OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", 1);

                            -- Is elevator a vehicle elevator?
                            if IsPedInAnyVehicle(player, true) then
                                -- Lets teleport the user / vehicle and unfreeze the user.
                                SetEntityCoords(GetVehiclePedIsUsing(player), floorDown[1])
                                FreezeEntityPosition(player, false)
                            else
                                -- Lets teleport the user / vehicle and unfreeze the user.
                                SetEntityCoords(player, floorDown[1])
                                FreezeEntityPosition(player, false)
                            end
                        end
                    end
                    -- Get to here but you haven't been teleported? You are not close to an elevator ingame.
                end
            end
            -- New building
        end
    end
end)

-- Message in left up corner.
function MessageUpLeftCorner(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


-- Message above radar.
function MessageAboveRadar(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end
