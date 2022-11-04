Config = {}
--------------------
Config.Locale = 'en'
--------------------
Config.Debug = false
--------------------
Config.WaitBeforeOpenMenu = 200
Config.CheckPlayerPosition = 2000
Config.NearObjectDistance = 5.0
--------------------
Config.DatastoreName = 'property'
Config.UseESXDataStore = true
--------------------
Config.TitleShop = "Kleidungsladen"
--------------------
Config.SkipClothesPieces = {
    "skin",
    "hair_1",
    "hair_2",
}
--------------------
-- what framework will be used?
-- ESX = 1
-- QB  = 2
Framework = "1"
-- or use you need to uncomment this first!
-- deprecated array will be removed in future
--[[
Framework = {
    ESX = true,
    QBCore = false,
}
--]]

--------------------

-- skinchanger       = 1
-- cui_character     = 2
-- qb_clothing       = 3

-- Alot of fivem_appearance does not offer save / load. This resource **DOES NOT take care of the saving/loading**
-- you will have to edit this string to the event you're using for saving.
-- fivem_appearance  = 4
Config.Fivem_AppearanceSaveEvent = ""

SkinChanger = "1"
-- or use you need to uncomment this first!
-- deprecated array will be removed in future
--[[
SkinChanger = {
    skinchanger = false,
    cui_character = false,
    qb_clothing = false,
    fivem_appearance = true,
}
--]]

--------------------
Config.QBCoreCallbacks = {
    ['QBCore:Client:OnJobUpdate'] = 'QBCore:Client:OnJobUpdate',
    ['QBCore:Player:SetPlayerData'] = 'QBCore:Player:SetPlayerData',
}

if Config.Fivem_AppearanceSaveEvent == "" then
    if Framework == "1" then Config.Fivem_AppearanceSaveEvent = "fivem-appearance:save" end
    if Framework == "2" then Config.Fivem_AppearanceSaveEvent = "fivem-appearance:server:saveAppearance" end
end

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = "1"

    if objectType == "1" then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == "2" then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == "3" then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj)
                QBCore = obj
            end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end
--------------------
Config.ESX = 'esx:getSharedObject'
Config.ESXCallbacks = {
    ['esx_datastore:getDataStore'] = 'esx_datastore:getDataStore',
    ['esx:playerLoaded'] = 'esx:playerLoaded',
    ['esx:setJob'] = 'esx:setJob',
    ['esx_addonaccount:getSharedAccount'] = 'esx_addonaccount:getSharedAccount',
    ['skinchanger:getSkin'] = 'skinchanger:getSkin',
    ['skinchanger:loadClothes'] = 'skinchanger:loadClothes',
    ['esx_skin:setLastSkin'] = 'esx_skin:setLastSkin',
    ['esx_skin:save'] = 'esx_skin:save',
    ['skinchanger:loadSkin'] = 'skinchanger:loadSkin',
}
--------------------
Config.GlobalBlacklist = {
    ['boots'] = { --Name of section of shop
        ['shoes_1'] = { --Name of skinchanger field
            ['male'] = {  }, --Specific sex blacklist
            ['female'] = { 136,137,138,139,140 },
        }
    },
    ['tshirt'] = { --Name of section of shop
        ['torso_1'] = { --Name of skinchanger field
            ['male'] = { 1,4,5,6,187}, --Specific sex blacklist
            ['female'] = {1,4,5,620,621,622,623,624,625,626 },
        }
    },
    ['tshirt'] = { --Name of section of shop
        ['chain_1'] = { --Name of skinchanger field
            ['male'] = { 171,205,243}, --Specific sex blacklist
            ['female'] = {179 },
        }
    },
    ['pants'] = { --Name of section of shop
        ['pants_1'] = { --Name of skinchanger field
            ['male'] = { 172}, --Specific sex blacklist
            ['female'] = {11,50,51,52,56,64,72,79,80,81,231,232,233,234,235,236,237,238,239,240,241 },
        }
    },
    ['bags'] = {--Numbers of blacklisted items for bags for both sex
    },
    ['glasses'] = {--Numbers of blacklisted items for bags for both sex
        ['pants_1'] = { --Name of skinchanger field
            ['male'] = { }, --Specific sex blacklist
            ['female'] = {214},
        }
    },
    ['tshirt'] = {--Numbers of blacklisted items for bags for both sex
        ['bproof_1'] = { --Name of skinchanger field
            ['male'] = {79}, --Specific sex blacklist
            ['female'] = {93},
        }
    }
}
--------------------
Config.GlobalWhitelist = {--Same as blacklist you can do with whitelist
    --['hats'] = {
    --    ['helmet_1'] = {
    --        ['male'] = {}, --Specific sex blacklist
    --        ['female'] = {},
    --    }
    --},
    --['bags'] = {
    --    --Numbers of blacklisted items for bags for both sex
    --}
}
--------------------
-- Where player can change his clothes at store or anywhere
Config.ChangePoint = {
    title = 'Kleidung wechseln', -- menu title
    label = 'Umkleide\n~r~[E]~w~', --3D text
    help = 'Drücke ~INPUT_CONTEXT~ um auf deine Outfits zuzugreifen',
    key = 38, --E https://docs.fivem.net/docs/game-references/controls/
    menualign = 'right',
    heightMenu = "middle",
    renderDistance = 5.0,
    size = 0.5,
    points = {
        vector3(429.75, -811.41, 29.49),
        vector3(71.19, -1387.76, 29.38),
        vector3(-819.66, -1067.17, 11.33),
        vector3(3.63, 6505.58, 31.88),
        vector3(1699.01, 4817.92, 42.06),
        vector3(1201.89, 2714.5, 38.22),
        vector3(-1100.45, 2717.04, 19.11),
        vector3(-703.51, -151.62, 37.42),
        vector3(-168.3, -299.38, 39.73),
        vector3(-1447.35, -242.73, 49.82),
        vector3(118.18, -232.61, 54.56),
        vector3(617.72, 2773.41, 42.09),
        vector3(-1182.54, -765.13, 17.33),
        vector3(-3178.37, 1035.77, 20.86),
        vector3(-571.05, -198.66, 42.76),
        vector3(365.2, 4819.63, -59),
        vector3(151.01, -768.22, 50.14),
        vector3(461.55, -996.48, 30.69), --PD
    }
}
--------------------
-- key that will open shop with clothes
-- E https://docs.fivem.net/docs/game-references/controls/
Config.KeyToOpenShop = 38
--------------------
Config.Stores = {
    {
        position = vector3(422.86, -808.31, 29.49),
        label = 'Binco - Clothes',
        sprite = 73, -- to disable blip make this -1
        scale = 1.0,
        Farbe = 1,
        sections = {
            boots = {
                --job = { "police" },
                pos = vector3(419.55, -802.77, 29.49),
                label = '👞',
                title = "Schuhe shop!",
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 50,
                        customPrices = {
                            [1] = 100,
                            [2] = 200,
                        },
                        reset = {
                            'shoes_2'
                        },
                        customPrices = {
                            ['1'] = 50,
                            ['2'] = 200,
                            ['5'] = 1500,
                        },
                        --whitelist = { --Specific for female & male
                        --    ['female'] = {5,6,7},
                        --    ['male'] = {1,2,3}
                        --},
                        --blacklist = { --Global for male & female
                        --    1,2,3
                        --},
                        --customCamera = {
                        --    pointOffset = {
                        --        x = 0.0,
                        --        y = 0.0,
                        --        z = 0.0
                        --    }
                        --},
                    },
                    {
                        label = 'Schuhfarbe',
                        name = 'shoes_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 354.66
                },
                size = 1.2, --Default 1
                renderDistance = 10.0,
            },
            hats = {
                pos = vector3(427.51, -798.89, 29.49),
                label = '👒 ',
                title = "Hut shop!",
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                        customPrices = {
                            ['male'] = {
                                ['2'] = 20,
                                ['3'] = 35,
                                ['5'] = 1500,
                            },
                            ['female'] = {},
                        }
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 174.66
                }
            },
            pants = {
                pos = vector3(430.58, -800.13, 29.5),
                label = '👖',
                title = "Hosen shop!",
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 86.66
                }
            },
            glasses = {
                pos = vector3(425.69, -808.11, 29.49),
                label = '👓',
                title = "Glasses shop!",
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
            tshirt = {
                pos = vector3(425.41, -798.9, 29.49),
                label = '👕',
                title = "T-shirt shop!",
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        hideCompoment = {
                            ["bproof_1"] = -1,
                        },
                        price = 150,
                    },
                    {
                        label = 'Weste',
                        name = 'bproof_1',
                        from = 0,
                        to = 160,
                        current = 1,
                        reset = {
                            'bproof_2'
                        },
                        price = 150,
                    },
                    
                    {
                        label = 'Weste Farbe',
                        name = 'bproof_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },

                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },

                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    
                    --[[
                    {
                        label = 'shoes',
                        name = 'shoes_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,

                        customCamera = {
                            pointOffset = {
                                x = 0,
                                y = 0,
                                z = -0.8
                            },
                        },
                    },
                    --]]
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 180.66
                }
            }
        }
    },
    {
        position = vector3(77.77, -1391.3, 29.38),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(81.21, -1396.5, 29.38),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhfarbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 354.66
                }
            },
            hats = {
                pos = vector3(73.44, -1400.25, 29.38),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 355.66
                }
            },
            pants = {
                pos = vector3(69.76, -1399.06, 29.38),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 275.66
                }
            },
            glasses = {
                pos = vector3(75.21, -1391.22, 29.38),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 275.06
                }
            },
            tshirt = {
                pos = vector3(75.53, -1399.99, 29.38),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 3.66
                }
            }
        }
    },
    {
        position = vector3(-715.03, -145.58, 37.42),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-715.03, -145.58, 37.42),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhfarbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 195.66
                }
            },
            pants = {
                pos = vector3(-712.93, -147.71, 37.42),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 130.66
                }
            },
            tshirt = {
                pos = vector3(-707.98, -161.21, 37.42),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 23.66
                }
            }
        }
    },
    {
        position = vector3(-165.69, -311.55, 39.73),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-165.69, -311.55, 39.73),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 331.66
                }
            },
            pants = {
                pos = vector3(-165.75, -308.54, 39.73),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 252.66
                }
            },
            tshirt = {
                pos = vector3(-158.68, -295.79, 39.73),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 160.66
                }
            }
        }
    },
    {
        position = vector3(-822.42, -1080.5, 11.33),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-822.42, -1080.5, 11.33),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 26.66
                }
            },
            hats = {
                pos = vector3(-829.79, -1075.68, 11.33),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 299.66
                }
            },
            pants = {
                pos = vector3(-830.46, -1072.01, 11.34),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 203.66
                }
            },
            glasses = {
                pos = vector3(-821.0, -1072.71, 11.33),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 210.25
                }
            },
            tshirt = {
                pos = vector3(-828.63, -1077.37, 11.33),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 298.66
                }
            }
        }
    },
    {
        position = vector3(-1444.74, -230.44, 49.81),
        label = 'Ponsonbys - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-1444.74, -230.44, 49.81),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 122.66
                }
            },
            pants = {
                pos = vector3(-1446.13, -233.26, 49.81),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 51.66
                }
            },
            tshirt = {
                pos = vector3(-1457.65, -242.21, 49.81),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 317.66
                }
            }
        }
    },
    {
        position = vector3(3.3, 6519.29, 31.88),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(3.3, 6519.29, 31.88),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 224.66
                }
            },
            hats = {
                pos = vector3(11.62, 6516.03, 31.88),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 126.66
                }
            },
            pants = {
                pos = vector3(12.76, 6512.48, 31.89),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 47.66
                }
            },
            glasses = {
                pos = vector3(3.74, 6511.35, 31.88),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 58.99
                }
            },
            tshirt = {
                pos = vector3(9.95, 6517.47, 31.88),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 129.66
                }
            }
        }
    },
    {
        position = vector3(119.08, -222.55, 54.56),
        label = 'Suburban - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(119.08, -222.55, 54.56),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 244.66
                }
            },
            hats = {
                pos = vector3(121.87, -221.85, 54.56),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 252.66
                }
            },
            pants = {
                pos = vector3(122.99, -229.27, 54.56),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 341.66
                }
            },
            glasses = {
                pos = vector3(126.77, -221.2, 54.56),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 37.99
                }
            },
            tshirt = {
                pos = vector3(121.91, -212.01, 54.56),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 249.66
                }
            }
        }
    },
    {
        position = vector3(1687.45, 4825.47, 42.06),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(1687.45, 4825.47, 42.06),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 275.66
                }
            },
            hats = {
                pos = vector3(1694.85, 4830.45, 42.06),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 187.66
                }
            },
            pants = {
                pos = vector3(1698.32, 4829.52, 42.07),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 95.66
                }
            },
            glasses = {
                pos = vector3(1694.12, 4820.95, 42.06),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 127.99
                }
            },
            tshirt = {
                pos = vector3(1692.77, 4829.9, 42.06),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 183.66
                }
            }
        }
    },
    {
        position = vector3(620.66, 2764.38, 42.09),
        label = 'Suburban - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(620.66, 2764.38, 42.09),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 84.66
                }
            },
            hats = {
                pos = vector3(618.46, 2762.72, 42.09),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 105.66
                }
            },
            pants = {
                pos = vector3(614.29, 2768.7, 42.09),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 184.19
                }
            },
            glasses = {
                pos = vector3(614.52, 2759.92, 42.09),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 239.5
                }
            },
            tshirt = {
                pos = vector3(622.64, 2753.04, 42.09),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 95.66
                }
            }
        }
    },
    {
        position = vector3(1193.16, 2704.16, 38.22),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(1193.16, 2704.16, 38.22),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 0.66
                }
            },
            hats = {
                pos = vector3(1189.36, 2712.21, 38.22),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 271.66
                }
            },
            pants = {
                pos = vector3(1190.59, 2715.4, 38.23),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 174.66
                }
            },
            glasses = {
                pos = vector3(1198.08, 2710.11, 38.22),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 188.99
                }
            },
            tshirt = {
                pos = vector3(1189.42, 2710.09, 38.22),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 267.66
                }
            }
        }
    },
    {
        position = vector3(-1188.25, -772.88, 17.33),
        label = 'Suburban - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-1188.25, -772.88, 17.33),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 34.66
                }
            },
            hats = {
                pos = vector3(-1190.88, -771.61, 17.33),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 46.66
                }
            },
            pants = {
                pos = vector3(-1188.0, -764.68, 17.32),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 127.19
                }
            },
            glasses = {
                pos = vector3(-1195.17, -769.83, 17.32),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 191.5
                }
            },
            tshirt = {
                pos = vector3(-1196.72, -780.13, 17.33),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 38.66
                }
            }
        }
    },
    {
        position = vector3(-3176.96, 1045.31, 20.86),
        label = 'Suburban - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-3176.96, 1045.31, 20.86),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 242.66
                }
            },
            hats = {
                pos = vector3(-3174.22, 1045.9, 20.86),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 254.66
                }
            },
            pants = {
                pos = vector3(-3173.77, 1038.34, 20.86),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 337.19
                }
            },
            glasses = {
                pos = vector3(-1369.34, 1046.35, 20.86),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 41.5
                }
            },
            tshirt = {
                pos = vector3(-3173.57, 1056.11, 20.86),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 245.66
                }
            }
        }
    },
    {
        position = vector3(-1100.05, 2703.59, 19.11),
        label = 'Binco - Clothes',
        sprite = 73,
        Farbe = 59,
        sections = {
            boots = {
                pos = vector3(-1100.05, 2703.59, 19.11),
                label = '👞',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Schuhe',
                        name = 'shoes_1',
                        from = 1,
                        to = 88,
                        current = 1,
                        price = 150,
                    },
                    {
                        label = 'Schuhe Farbe',
                        name = 'shoes_2',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 50,
                    }
                },
                cam = {
                    offset = {
                        x = -0.5,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.8
                    },
                    taskHeading = 42.66
                }
            },
            hats = {
                pos = vector3(-1108.31, 2707.01, 19.11),
                label = '👒 ',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hüte',
                        name = 'helmet_1',
                        from = -1,
                        to = 160,
                        current = 1,
                        reset = {
                            'helmet_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hut Farbe',
                        name = 'helmet_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 305.66
                }
            },
            pants = {
                pos = vector3(-1109.48, 2710.53, 19.12),
                label = '👖',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Hosen',
                        name = 'pants_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'pants_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Hosen Farbe',
                        name = 'pants_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = -0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = -0.4
                    },
                    taskHeading = 225.66
                }
            },
            glasses = {
                pos = vector3(-1100.14, 2711.7, 19.11),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 224.99
                }
            },
            tshirt = {
                pos = vector3(-1106.73, 2705.6, 19.11),
                label = '👕',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'TShirt',
                        name = 'tshirt_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'tshirt_2'
                        },
                        price = 150,
                    },
                    {
                        label = 'TShirt Farbe',
                        name = 'tshirt_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Jacken',
                        name = 'torso_1',
                        from = 1,
                        to = 289,
                        current = 1,
                        reset = {
                            'torso_2'
                        },
                        price = 300,
                    },
                    {
                        label = 'Jacken Farbe',
                        name = 'torso_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Arme',
                        name = 'arms',
                        from = 1,
                        to = 20,
                        current = 1,
                        price = 0,
                    },
                    {
                        label = 'Ketten',
                        name = 'chain_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Ketten Farbe',
                        name = 'chain_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren',
                        name = 'watches_1',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                    {
                        label = 'Uhren Farbe',
                        name = 'watches_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 50,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 309.66
                }
            }
        }
    },
    {
        position = vector3(-1210.92, -1531.72, 4.25),
        label = 'Vespuci - Glasses',
        sprite = 73,
        Farbe = 15,
        sections = {
            glasses = {
                pos = vector3(-1210.92, -1531.72, 4.25),
                label = '👓',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Glasses',
                        name = 'glasses_1',
                        from = 1,
                        to = 160,
                        current = 1,
                        reset = {
                            'glasses_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Glasses Farbe',
                        name = 'glasses_2',
                        from = 0,
                        to = 20,
                        current = 1,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-1255.740601, -1447.476929, 4.342163),
        label = 'Vespuci - Mask',
        sprite = 362,
        Farbe = 60,
        sections = {
            glasses = {
                pos = vector3(-1255.740601, -1447.476929, 4.342163),
                label = '🙈',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Mask',
                        name = 'mask_1',
                        from = -1,
                        to = 160,
                        current = -1,
                        reset = {
                            'mask_2'
                        },
                        price = 50,
                    },
                    {
                        label = 'Mask Farbe',
                        name = 'mask_2',
                        from = 0,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.7
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.8
                    },
                    taskHeading = 100.66
                }
            },
        }
    },
    {
        position = vector3(-1226.68, -1445.17, 4.28),
        label = 'Vespuci - Bags',
        sprite = 440,
        Farbe = 60,
        sections = {
            bags = {
                pos = vector3(-1226.68, -1445.17, 4.28),
                label = '🎒',
                help = 'Drücke ~INPUT_CONTEXT~ um dir die Auswahl anzuschauen',
                components = {
                    {
                        label = 'Bags',
                        name = 'bags_1',
                        from = -1,
                        to = 160,
                        current = -1,
                        reset = {
                            'bags_2'
                        },
                        price = 120,
                    },
                    {
                        label = 'Bags Farbe',
                        name = 'bags_2',
                        from = 0,
                        to = 20,
                        current = 0,
                        price = 10,
                    },
                },
                cam = {
                    offset = {
                        x = 0.0,
                        y = 1.0,
                        z = 0.5
                    },
                    pointOffset = {
                        x = 0,
                        y = 0,
                        z = 0.4
                    },
                    taskHeading = 211.66
                }
            },
        }
    },
}
--------------------
