RegisterNetEvent('tfg_peds:checkpeds')
AddEventHandler('tfg_peds:checkpeds', function()
    local src = source
    for p = 0, #GetAllPeds() do
        local cPed = GetAllPeds()[p]
        TriggerClientEvent('tfg_peds:client:checkpeds', src, cPed)
    end
end)
