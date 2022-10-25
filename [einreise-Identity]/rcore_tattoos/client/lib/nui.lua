function closeForm()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'ui',
        value = false,
    })

    closeMenu()
    resetSkin()

    --When close menu reset tattoos and apply owned one
    resetPedDecorations()
end

RegisterNUICallback('close', function(data, cb)
    closeForm()
    start3dTextsRenderAll()
    cb('ok')
end)

RegisterNUICallback('moveCameraToBodyPart', function(data, cb)
    moveCameraToBodyPart(data.part)
    cb('ok')
end)

RegisterNUICallback('previewTattoo', function(data, cb)
    previewTattoo(data.currentCategory, data.tattooIdentifier, data.onlySaveData, data.opacity)
    cb('ok')
end)

RegisterNUICallback('resetPedDecorations', function(data, cb)
    resetPedDecorations()
    cb('ok')
end)

RegisterNUICallback('buyTattoo', function(data, cb)
    buyTattoo(data.useHenna)
    cb('ok')
end)

RegisterNUICallback('removeTattoo', function(data, cb)
    removeTattoo(data.identifier)
    cb('ok')
end)

RegisterNUICallback('handleCamSlider', function(data, cb)
    handleCamSlider(data.value)
    cb('ok')
end)
