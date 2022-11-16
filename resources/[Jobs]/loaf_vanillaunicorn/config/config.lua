--[[
    Some information:
      * vector3 is in the format x, y, z 
      * vector4 is in the frmat x, y, z, heading
--]]

esx = {
    client = "esx:getSharedObject", -- the event to load esx
    server = "esx:getSharedObject", -- the server event to load esx
    society_event = "esx_society:openBossMenu",
    inventory = "default", -- the inventory to use. supported: default & ox_inventory
    societyOptions = {
        wash = false,
    },
}

Config = {
    MenuAlign = "center",
    Framework = "esx", -- esx or qb
    
    Items = true, -- if you can store items
    Weapons = false, -- if you can store weapons

    RefreshPoledance = false, -- if enabled, poledance anim will refresh every 5 seconds (should fix desync)

    Marker = {
        colour = {255, 240, 0, 200}, -- colour, format: red, green, blue, alpha
        scale = vector3(0.75, 0.75, 0.4), -- the size of the marker
    },

    LeanMarker = {
        colour = {255, 240, 0, 0},
        scale = vector3(0.75, 0.75, 0.5),
    },

    Blip = {
        sprite = 121,
        colour = 8,
        scale = 0.75
    },

    JobGrades = {
        Boss = 12, -- boss menu

        -- grades should be in order, first one being the lowest allowed grade and the last one the highest allowed grade.
        Poledance = {0,3}, -- these grades can poledance
        Lapdance ={0,3}, -- these grades can lapdance
        Bar =  {2,3,4,5,6,7,8,9,10,11,12}, -- these grades can mix drinks & access the fridge
        PurchaseIngredients = {2,3,4,5,6,7,8,9,10,11,12}, -- these grades can purchase items for the bar
        Storage = {2,3,4,5,6,7,8,9,10,11,12}, -- these grades can access the storage
    },

    ThrowMoney = {
        toss = 400, -- how much it costs to throw money
        rain = 2000, -- how much it costs to make it rain
        dancerCut = 75, -- how many % the dancer takes, rest goes to the club
    },

    Locations = {
        {
            Location = vector3(101.617584, -1300.694458, 29.246094), -- the blip location
            Locker = vector3(113.221977, -1302.435181, 29.8460943), -- change outfit location
            --BossMenu = false, -- boss menu location (fire employees etc)
            Storage = vector3(124.378021, -1278.962646, 29.246094),
            Lean = {
                vector4(111.639557, -1289.195557, 28.252075, 31.181103),
                vector4(110.136261, -1290.065918, 28.252075, 28.346457),
                vector4(106.443962, -1291.107666, 28.252075, 28.346457),

                vector4(111.679123, -1286.505493, 28.252075, 147.401581),
                vector4(111.046158, -1285.411011, 28.252075, 130.393707),
                vector4(110.189011, -1283.907715, 28.252075, 136.062988),
                vector4(108.026375, -1283.709839, 28.252075, 209.763779),
                vector4(106.549454, -1284.580200, 28.252075, 209.763779),
                vector4(105.613190, -1286.228516, 28.252075, 206.929138),
                vector4(103.648361, -1287.336304, 28.252075, 206.929138),
                vector4(101.815384, -1288.391235, 28.252075, 201.259842),
                vector4(100.298904, -1288.206543, 28.252075, 147.401581),
            },

            Bar = {
                --Teleport = {
                 --   In = vector4(132.89, -1293.76, 29.27, 117.28),
                --    Out = vector4(131.85, -1287.66, 29.27, 9.69),
                --},

                Fridge = vector3(135.257141, -1286.149414, 29.246094),
                Mix = vector4(129.863739, -1285.450562, 29.246094, 121.889763)
            },

            Poledance = {
            },

            Lapdance = {

            },
        },
    },

    Bar = {
        Items = {
            -- {"item", price},
            {"cointreau", 200, "Cointreau"},
            {"cranberry_juice", 100, "Cranberry juice"},
            {"fresh_mix", 70, "Fresh sour mix"},

            {"mint", 20, "Mint"},
            {"lime", 30, "Lime"},
            {"sugar", 10, "Sugar"},
            {"ice", 5, "Ice"},
            {"white_rum", 150, "White rum"},
            {"club_soda", 100, "Club soda"},

            {"light_rum", 150, "Light rum"},
            {"dark_rum", 150, "Dark rum"},
            {"gold_rum", 150, "Gold rum"},
            {"curacao", 100, "Orange Curacao liqeur"},
            {"syrup", 70, "Orgeat syrup"},

            {"water", 10, "Water"},
            {"bourbon", 150, "Bourbon"},

            {"cachaca", 100, "Cachaca"},
            
            {"limeade", 100, "Limeadge"},
            {"triple_sec", 150, "Triple sec"},

            {"coconut_milk", 50, "Coconut milk"},
            {"pineapple_juice", 50, "Pineapple juice"},
        },
        Cocktails = {
            {"cosmopolitan", 1090, "Cosmopolitan"},
            {"wodka_onIce", 235, "Vodka on Ice"},
            {"mojito", 655, "Mojito"},
            {"mai_tai", 1100, "Mai Tai"},
            {"mint_julep", 380, "Mint Julep"},
            {"caipirinha", 240, "Caipirinha"},
            {"margarita", 1350, "Margarita"},
            {"pina_colada", 1200, "Pina Colada"},
            {"cola", 500, "Coca Cola"},
            {"red_bull", 500, "Red Bull"},
            {"coffee", 300, "Kaffee"},
        },
        Recipes = {
        --[[
            {
                Label = "Name of the drink",
                Name = "item name",
                Ingredients = {
                    {"ingredient", amount}
                }
            }
        --]]
            {
                Label = "Cosmopolitan",
                Name = "cosmopolitan",
                Ingredients = {
                    {"wodka", 4},
                    {"cointreau", 2},
                    {"cranberry_juice", 1},
                    {"fresh_mix", 1}
                }
            },
            {
                Label = "Vodka on Ice",
                Name = "wodka_onIce",
                Ingredients = {
                    {"wodka", 1},
                    {"ice", 1},
                    {"cranberry_juice", 1}
                }
            },
            {
                Label = "Mojito",
                Name = "mojito",
                Ingredients = {
                    {"mint", 10},
                    {"lime", 1},
                    {"sugar", 2},
                    {"ice", 1},
                    {"white_rum", 2},
                    {"club_soda", 1}
                }
            },
            {
                Label = "Mai Tai",
                Name = "mai_tai",
                Ingredients = {
                    {"light_rum", 2},
                    {"gold_rum", 2},
                    {"dark_rum", 2},
                    {"curacao", 1},
                    {"syrup", 1},
                    {"lime", 1}
                }
            },
            {
                Label = "Mint Julep",
                Name = "mint_julep",
                Ingredients = {
                    {"water", 1},
                    {"sugar", 1},
                    {"mint", 3},
                    {"bourbon", 2},
                }
            },
            {
                Label = "Caipirinha",
                Name = "caipirinha",
                Ingredients = {
                    {"cachaca", 2},
                    {"lime", 1},
                    {"sugar", 1}
                }
            },
            {
                Label = "Margarita",
                Name = "margarita",
                Ingredients = {
                    {"limeade", 1},
                    {"tequila", 6},
                    {"cointreau", 1},
                    {"triple_sec", 1}
                }
            },
            {
                Label = "Pina Colada",
                Name = "pina_colada",
                Ingredients = {
                    {"light_rum", 4},
                    {"coconut_milk", 2},
                    {"pineapple_juice", 10}
                }
            },
        },
    },
}
