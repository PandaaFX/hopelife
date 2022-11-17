if Framework == Frameworks.ESX then
    AddEventHandler('esx:playerSpawned', function()
        resetPedDecorations()
    end)
else
    AddEventHandler('playerSpawned', function()
        resetPedDecorations()
    end)
end
