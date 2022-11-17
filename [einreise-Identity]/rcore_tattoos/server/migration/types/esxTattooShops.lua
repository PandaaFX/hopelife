--Example of data structure
--[
--    {
--    "texture": 1,
--    "collection": "mpbusiness_overlays"
--    },
--    {
--    "texture": 3,
--    "collection": "mpbusiness_overlays"
--    },
--    {
--    "texture": 3,
--    "collection": "mpbusiness_overlays"
--    },
--    {
--    "texture": 5,
--    "collection": "mpbusiness_overlays"
--    }
--]
--{"RCore":{"createdAt":1658072822,"opacity":1,"expiration":false,"name":"RCore"},"Panda":{"createdAt":1658072838,"opacity":1,"expiration":false,"name":"Panda"}}
Citizen.CreateThread(function()
    local migration = Migration()
    migration.name = "esxTattooShops"
    migration.apply = function()
        --Find resource and get tattoo list
        local resName = "esx_tattooshop"
        local filePath = "client/tattooList.lua"
        local tattooList = LoadResourceFile(resName, filePath)
        if tattooList == nil then
            dbg.print("Cant find resource %s file %s - you can edit these values in server/migrations/type/esxTatooShops.lua", resName, filePath)
            return
        end

        --Load tattoo list lua file
        pcall(load(tattooList))

        if Config.TattooList == nil then
            dbg.print("Config.TattooList is nil, are u sure that this is right migrations?")
            return
        end

        local oldTattoos = MySQL.Sync.fetchAll("SELECT identifier, tattoos FROM users")
        for _, row in pairs(oldTattoos) do
            local playerTattoos = {}
            for _, tattoo in pairs(json.decode(row.tattoos) or {}) do
                local collectionTattoos = Config.TattooList[tattoo.collection]
                if collectionTattoos == nil then
                    dbg.print("Skipping tattoo %s - cannot found collection %s", tattoo.texture, tattoo.collection)
                else
                    local tattooData = collectionTattoos[tattoo.texture]
                    if tattooData ~= nil then
                        local rTattooData = foundTattooByHash(tattooData.nameHash)
                        if rTattooData == nil then
                            dbg.print('Cannot found tattoo in our storage with hash %s, did you register all addon tattoos?', tattooData.nameHash)
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
                    else
                        dbg.print("Cannot found texture data for %s %s", tattoo.texture, tattoo.collection)
                    end
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
