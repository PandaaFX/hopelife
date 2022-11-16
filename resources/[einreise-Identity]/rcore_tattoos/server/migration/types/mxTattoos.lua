--Example of data structure
--[{"nameHash":"MP_MP_Biker_Tat_027_M","Count":1,"collection":"mpbiker_overlays"},{"nameHash":"MP_MP_Biker_Tat_044_M","Count":1,"collection":"mpbiker_overlays"}]
--{"RCore":{"createdAt":1658072822,"opacity":1,"expiration":false,"name":"RCore"},"Panda":{"createdAt":1658072838,"opacity":1,"expiration":false,"name":"Panda"}}
Citizen.CreateThread(function()
    local migration = Migration()
    migration.name = "mxTattoos"
    migration.apply = function()
        local oldTattoos = MySQL.Sync.fetchAll("SELECT identifier, tattoos FROM tattoos")
        for _, row in pairs(oldTattoos) do
            local playerTattoos = {}
            for _, tattoo in pairs(json.decode(row.tattoos) or {}) do
                local rTattooData = foundTattooByHash(tattoo.hash)
                if rTattooData == nil then
                    dbg.print('Cannot found tattoo in our storage with hash %s, did you register all addon tattoos?', tattoo.nameHash)
                else
                    local tattooIdentifier = rTattooData.hashMale..'-'..rTattooData.hashFemale
                    playerTattoos[tattooIdentifier] = {
                        createdAt = os.time(),
                        expiration = false,
                        name = rTattooData.name,
                        identifier = tattooIdentifier,
                        opacity = 1,
                    }
                end
            end

            MySQL.Sync.execute('REPLACE INTO rcore_tattoos (tattoos, identifier) VALUES (@tattoos, @id)', {
                ['tattoos'] = json.encode(playerTattoos),
                ['id'] = row.identifier,
            })
            dbg.print("Insert player %s tattoos", row.identifier)
        end
    end

    registerMigration(migration)
end)
