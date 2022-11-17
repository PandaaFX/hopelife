function OnPlayerSip(drinkName, leftSips, drinkData)
    AddPlayerDrunkPercentage(drinkData.eachSipGiveDrunk)
    ShowHelpNotification(_U("drink_help_text", leftSips), false, false, 99999999)

    SendNUIMessage({
        type = "drunk",
        value = GetPlayerDrunkPercentage(),
    })

    AddPlayerHeadachePercentage(drinkData.eachSipGiveDrunk / 2)

    SendNUIMessage({
        type = "headache",
        value = GetPlayerHeadachePercentage(),
    })
end