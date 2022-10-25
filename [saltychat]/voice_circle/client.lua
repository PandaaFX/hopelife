local Config = {
    positionOfText = {
        x = 0.169,
        y = 0.940,
    },
    textScale = 0.35,
}

local CurrentDistance = 0
local isTalking = false
local showTime = 0

RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index, availableVoiceRanges)
    CurrentDistance = voiceRange
    showTime = 0
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if showTime < 1000 then
            local pedCoords = GetEntityCoords(PlayerPedId())
            DrawMarker(1, pedCoords.x, pedCoords.y, pedCoords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, CurrentDistance * 2.0, CurrentDistance * 2.0, 1.0, 40, 140, 255, 150, false, false, 2, false, nil, nil, false)
            showTime = showTime + 5
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        isTalking = NetworkIsPlayerTalking(PlayerId())
    end
end)

function displayText(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(Config.textScale / 0.59, Config.textScale / 0.59)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()
    SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(Config.positionOfText.x, Config.positionOfText.y)
end
