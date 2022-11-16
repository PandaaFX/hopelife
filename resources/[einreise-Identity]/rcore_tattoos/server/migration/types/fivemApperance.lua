--//{
--//  "tattoos": {
--//    "ZONE_HEAD": [
--//      {
--//        "name": "TAT_H3_003",
--//        "label": "Assault Rifle",
--//        "hashFemale": "mpHeist3_Tat_003_F",
--//        "zone": "ZONE_HEAD",
--//        "hashMale": "mpHeist3_Tat_003_M",
--//        "collection": "mpheist3_overlays"
--//      }
--//    ],
--//    "ZONE_LEFT_ARM": [
--//      {
--//        "name": "TAT_BB_024",
--//        "label": "Tiki Tower",
--//        "hashFemale": "",
--//        "zone": "ZONE_LEFT_ARM",
--//        "hashMale": "MP_Bea_M_LArm_000",
--//        "collection": "mpbeach_overlays"
--//      },
--//      {
--//        "name": "TAT_BI_024",
--//        "label": "Live to Ride",
--//        "hashFemale": "MP_MP_Biker_Tat_024_F",
--//        "zone": "ZONE_LEFT_ARM",
--//        "hashMale": "MP_MP_Biker_Tat_024_M",
--//        "collection": "mpbiker_overlays"
--//      }
--//    ]
--//  },
--//}

Citizen.CreateThread(function()
    local migration = Migration()
    migration.name = "fivemApperance"
    migration.apply = function()
        local oldTattoos = MySQL.Sync.fetchAll("SELECT citizenid, skin FROM playerskins WHERE active=1")
        for _, row in pairs(oldTattoos) do
            local playerTattoos = {}
            local skin = json.decode(row.skin)
            for _, parts in pairs(skin.tattoos or {}) do
                for part, tattoo in pairs(parts) do
                    local rTattooData = foundTattooByHash(tattoo.hashMale)
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
                    ['id'] = row.citizenid,
                })
                dbg.print("Insert player %s tattoos", row.citizenid)
            end
        end
    end

    registerMigration(migration)
end)
