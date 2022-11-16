local esx_service = exports["esx_service"]
local currentLaunderer = math.random(1, #Config.launderLocations)
local conversionRate = Config.baseRate
local copsCalled = false
local updatingLaunderer = false
local launderers = {}

ESX = nil
TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

-- Launderer Logic
RegisterServerEvent("otaku_moneylaunderer:getLaunderer")
AddEventHandler(
    "otaku_moneylaunderer:getLaunderer",
    function()
        if updatingLaunderer ~= true then
            TriggerClientEvent("otaku_moneylaunderer:updateLaunderer", source, currentLaunderer)
        end
    end
)

RegisterServerEvent("otaku_moneylaunderer:setLaunderer")
AddEventHandler(
    "otaku_moneylaunderer:setLaunderer",
    function()
        if updatingLaunderer ~= true then
            updatingLaunderer = true
            launderers = {}
            TriggerClientEvent("otaku_moneylaunderer:removeLaunderer", -1)
            setNewlaunderer()
        end
    end
)

function setNewlaunderer()
    local oldLaunderer = currentLaunderer
    local newLaunderer = oldLaunderer -- At this point, all launderers should be the same
    while newLaunderer == oldLaunderer do -- ensure new launderer is different from current
        local rn = math.random(1, #Config.launderLocations)
        newLaunderer = rn
    end

    currentLaunderer = newLaunderer
    copsCalled = false
    TriggerClientEvent("otaku_moneylaunderer:updateLaunderer", -1, currentLaunderer)
    updatingLaunderer = false
end

-- Laundering Logic
local flagged = false
CreateThread(
    function()
        while true do
            Wait(Config.policeCooldown)

            if flagged then
                copsCalled = false
            end

            if copsCalled then
                flagged = true
            end
        end
    end
)

RegisterServerEvent("otaku_moneylaunderer:launderMoney")
AddEventHandler(
    "otaku_moneylaunderer:launderMoney",
    function(launderer)
        local source = source
        local launderer = launderer
        launderers[source] = true
        SetTimeout(
            Config.launderSpeed,
            function()
                getCleanMoney(source, launderer)
            end
        )
    end
)

RegisterServerEvent("otaku_moneylaunderer:stopLaundering")
AddEventHandler(
    "otaku_moneylaunderer:stopLaundering",
    function()
        launderers[source] = false
    end
)

function getCleanMoney(source, launderer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = source
    local launderer = launderer
    local moneyLaundered = 0
    local moomoo = 0

    local ped = GetPlayerPed(source)
    local currentCoord = GetEntityCoords(ped)
    local originalCoord = Config.launderLocations[currentLaunderer].pos

    if not Timer or ((GetGameTimer() - Timer) > 90000) then --- 90s
        Timer = GetGameTimer()
    end

    conversionRate = Config.baseRate
    conversionRate = (conversionRate + (0 * Config.bonusPerCop)) / 100
    if conversionRate > Config.maxRate then
        conversionRate = Config.maxRate
    end

    local callThePigs = math.random(1, Config.callPoliceChance)
    if copsCalled == false and callThePigs == 5 then
        local ped = GetPlayerPed(player)
        local pCoord = GetEntityCoords(ped)
        local notification = {
            subject = "[10-21] Kriminelle Aktivität",
            msg = "Verdächtige Personen",
            icon = "fas fa-headset",
            iconStyle = "red",
            locationX = pCoord.x,
            locationY = pCoord.y,
            caller = 0
        }
        TriggerEvent("esx_service:callAllInService", notification, "police")
        copsCalled = true
    end

    if launderer == currentLaunderer and #(currentCoord.xy - originalCoord.xy) < 8.0 and launderers[source] then
        SetTimeout(
            Config.launderSpeed,
            function()
                local dirty_money = xPlayer.getAccount("black_money").money
                if dirty_money > Config.maxStack then
                    moneyLaundered = math.random(Config.minStack, Config.maxStack)
                elseif dirty_money > 0 then
                    moneyLaundered = dirty_money
                end

                if moneyLaundered > 0 then
                    xPlayer.removeAccountMoney("black_money", moneyLaundered, "Money launderer")
                    moomoo = math.floor(moneyLaundered * conversionRate)
                    TriggerEvent("Acountant:makeEntry", player, "Money Launderer", moomoo)
                    xPlayer.addMoney(moomoo, "Dirty money laundered")

                    TriggerClientEvent(
                        "esx:showAdvancedNotification",
                        player,
                        "Money Laundering",
                        "Info <b>$" ..
                        "Info",
                        moneyLaundered .. "</b> in <b>$" .. moomoo .. "</b> für dich.. ich versuche mehr zu waschen",
                        "CHAR_HUMANDEFAULT"
                    )
                    getCleanMoney(player, launderer)
                else
                    TriggerClientEvent(
                        "esx:showAdvancedNotification",
                        player,
                        "Money Laundering",
                        "Info",
                        "Das War's, mehr kann ich nicht waschen",
                        "CHAR_HUMANDEFAULT"
                    )
                end
            end
        )
    elseif launderer ~= currentLaunderer then
        SetTimeout(
            Config.launderSpeed,
            function()
                TriggerClientEvent(
                    "esx:showAdvancedNotification",
                    player,
                    "Money Laundering",
                    "Info",
                    "Ich hab gewaschen was ich konnte.. aber das wird mir alles zu heiß hier",
                    "CHAR_HUMANDEFAULT"
                )
            end
        )
    else
        TriggerClientEvent("esx:showAdvancedNotification", player, "Money Laundering", "Info", "Hey wohin gehst du?.. ich behalte deine Kohle mann!", "red")
    end
end

Citizen.CreateThread(
    function()
        local vRaw = LoadResourceFile(GetCurrentResourceName(), "version.json")
        if vRaw and Config.versionCheck then
            local v = json.decode(vRaw)
            PerformHttpRequest(
                "https://raw.githubusercontent.com/Sojobo/otaku_moneylaunderer/main/version.json",
                function(code, res, headers)
                    if code == 200 then
                        local rv = json.decode(res)
                        if rv.version ~= v.version then
                            print(
                                ([[^1

-------------------------------------------------------
otaku_moneylaunderer
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
^0]]):format(
                                    rv.version,
                                    rv.changelog
                                )
                            )
                        end
                    else
                        print("otaku_moneylaunderer unable to check version")
                    end
                end,
                "GET"
            )
        end
    end
)
