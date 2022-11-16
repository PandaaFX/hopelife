# Requirements
* OneSync
* Install [loaf_lib](https://github.com/loaf-scripts/loaf_lib)
    * rename from loaf_lib-master to loaf_lib
    * add to your resources folder

# ESX
## Requirements
All of these should already be on your server.
* [esx_society](https://github.com/Loffes/esx_society) for bossmenu
* [skinchanger](https://github.com/mitlight/skinchanger) for outfits
* [esx_skin](https://github.com/mitlight/esx_skin) for outfits
* [esx_datastore](https://github.com/mitlight/esx_datastore) for weapon storage
* [esx_addoninventory](https://github.com/CourtneyKitty/esx_addoninventory) for item storage & fridge

## Installation
* Add "loaf_vanillaunicorn" to your resources folder
* Run `esx.sql`
* Add `ensure loaf_vanillaunicorn` to your server.cfg
* Restart your server

## Configuration
* Modify the `esx` table in the config/config.lua file to your liking.

# qb-core
## Requirements
All of these should already be on your server.
* [qb-inventory](https://github.com/qbcore-framework/qb-inventory) for storage
* [qb-bossmenu](https://github.com/qbcore-framework/qb-bossmenu) for bossmenu
* [qb-clothing](https://github.com/qbcore-framework/qb-clothing) for outfits
* [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu) to bill players
* [qb-shops](https://github.com/qbcore-framework/qb-shops) for the bar

## Installation
* Go to qb-core/shared/jobs.lua and add the following:
    ```lua
    ['unicorn'] = {
        label = 'Vanilla unicorn',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Bouncer',
                payment = 100
            },
            ['1'] = {
                name = 'Bartender',
                payment = 125
            },
            ['2'] = {
                name = 'Stripper',
                payment = 150
            },
            ['3'] = {
                name = 'Boss',
                isboss = true,
                payment = 250
            }
        }
    },
    ```
* Go to qb-core/shared/items.lua and add the following:
    ```lua
    -- Vanilla unicorn
    ['vodka'] = {['name'] = 'vodka', ['label'] = 'Vodka', ['weight'] = 1, ['type'] = 'item', ['image'] = 'vodka.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Vodka'},
    ['cointreau'] = {['name'] = 'cointreau', ['label'] = 'Cointreau', ['weight'] = 1, ['type'] = 'item', ['image'] = 'cointreau.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Cointreau'},
    ['cranberry_juice'] = {['name'] = 'cranberry_juice', ['label'] = 'Cranberry juice', ['weight'] = 1, ['type'] = 'item', ['image'] = 'cranberry_juice.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Cranberry juice'},
    ['fresh_mix'] = {['name'] = 'fresh_mix', ['label'] = 'Fresh sour mix', ['weight'] = 1, ['type'] = 'item', ['image'] = 'fresh_mix.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Fresh sour mix'},
    ['mint'] = {['name'] = 'mint', ['label'] = 'Mint', ['weight'] = 1, ['type'] = 'item', ['image'] = 'mint.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Mint'},
    ['lime'] = {['name'] = 'lime', ['label'] = 'Lime', ['weight'] = 1, ['type'] = 'item', ['image'] = 'lime.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Lime'},
    ['sugar'] = {['name'] = 'sugar', ['label'] = 'Sugar', ['weight'] = 1, ['type'] = 'item', ['image'] = 'sugar.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Sugar'},
    ['ice'] = {['name'] = 'ice', ['label'] = 'Ice', ['weight'] = 1, ['type'] = 'item', ['image'] = 'ice.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Ice'},
    ['white_rum'] = {['name'] = 'white_rum', ['label'] = 'White rum', ['weight'] = 1, ['type'] = 'item', ['image'] = 'white_rum.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'White rum'},
    ['club_soda'] = {['name'] = 'club_soda', ['label'] = 'Club soda', ['weight'] = 1, ['type'] = 'item', ['image'] = 'club_soda.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Club soda'},
    ['light_rum'] = {['name'] = 'light_rum', ['label'] = 'Light rum', ['weight'] = 1, ['type'] = 'item', ['image'] = 'light_rum.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Light rum'},
    ['dark_rum'] = {['name'] = 'dark_rum', ['label'] = 'Dark rum', ['weight'] = 1, ['type'] = 'item', ['image'] = 'dark_rum.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Dark rum'},
    ['gold_rum'] = {['name'] = 'gold_rum', ['label'] = 'Gold rum', ['weight'] = 1, ['type'] = 'item', ['image'] = 'gold_rum.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Gold rum'},
    ['curacao'] = {['name'] = 'curacao', ['label'] = 'Orange Curacao liqeur', ['weight'] = 1, ['type'] = 'item', ['image'] = 'curacao.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Orange Curacao liqeur'},
    ['syrup'] = {['name'] = 'syrup', ['label'] = 'Orgeat syrup', ['weight'] = 1, ['type'] = 'item', ['image'] = 'syrup.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Orgeat syrup'},
    ['water'] = {['name'] = 'water', ['label'] = 'Water', ['weight'] = 1, ['type'] = 'item', ['image'] = 'water.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Water'},
    ['bourbon'] = {['name'] = 'bourbon', ['label'] = 'Bourbon', ['weight'] = 1, ['type'] = 'item', ['image'] = 'bourbon.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Bourbon'},
    ['cachaca'] = {['name'] = 'cachaca', ['label'] = 'Cachaca', ['weight'] = 1, ['type'] = 'item', ['image'] = 'cachaca.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Cachaca'},
    ['limeade'] = {['name'] = 'limeade', ['label'] = 'Limeadge', ['weight'] = 1, ['type'] = 'item', ['image'] = 'limeade.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Limeadge'},
    ['tequila'] = {['name'] = 'tequila', ['label'] = 'Tequila', ['weight'] = 1, ['type'] = 'item', ['image'] = 'tequila.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Tequila'},
    ['triple_sec'] = {['name'] = 'triple_sec', ['label'] = 'Triple sec', ['weight'] = 1, ['type'] = 'item', ['image'] = 'triple_sec.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Triple sec'},
    ['coconut_milk'] = {['name'] = 'coconut_milk', ['label'] = 'Coconut milk', ['weight'] = 1, ['type'] = 'item', ['image'] = 'coconut_milk.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Coconut milk'},
    ['pineapple_juice'] = {['name'] = 'pineapple_juice', ['label'] = 'Pineapple juice', ['weight'] = 1, ['type'] = 'item', ['image'] = 'pineapple_juice.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Pineapple juice'},
    ['cosmopolitan'] = {['name'] = 'cosmopolitan', ['label'] = 'Cosmopolitan', ['weight'] = 2, ['type'] = 'item', ['image'] = 'cosmopolitan.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Cosmopolitan'},
    ['mojito'] = {['name'] = 'mojito', ['label'] = 'Mojito', ['weight'] = 2, ['type'] = 'item', ['image'] = 'mojito.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Mojito'},
    ['mai_tai'] = {['name'] = 'mai_tai', ['label'] = 'Mai Tai', ['weight'] = 2, ['type'] = 'item', ['image'] = 'mai_tai.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Mai Tai'},
    ['mint_julep'] = {['name'] = 'mint_julep', ['label'] = 'Mint Julep', ['weight'] = 2, ['type'] = 'item', ['image'] = 'mint_julep.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Mint Julep'},
    ['caipirinha'] = {['name'] = 'caipirinha', ['label'] = 'Caipirinha', ['weight'] = 2, ['type'] = 'item', ['image'] = 'caipirinha.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Caipirinha'},
    ['margarita'] = {['name'] = 'margarita', ['label'] = 'Margarita', ['weight'] = 2, ['type'] = 'item', ['image'] = 'margarita.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Margarita'},
    ['pina_colada'] = {['name'] = 'pina_colada', ['label'] = 'Pina Colada', ['weight'] = 2, ['type'] = 'item', ['image'] = 'pina_colada.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Pina Colada'},
    ```
* Go to qb-bossmenu/config.lua and add the following:
    ```lua
    ['unicorn'] = vector3(94.79, -1292.79, 29.27),
    ```
* Go to qb-bossmenu/accounts.json and add the following:
    ```json
    // Add this:
    "unicorn":0

    // Example:
    // before
    {"realestate":0,"taxi":0,"ambulance":0,"cardealer":0,"police":0,"mechanic":0}
    // after 
    {"realestate":0,"taxi":0,"ambulance":0,"cardealer":0,"police":0,"mechanic":0,"unicorn":0}
    ```
* Go to qb-clothing/config.lua and add the following:
    ```lua
    -- add this to Config.ClothingRooms:
    [7] = {requiredJob = "unicorn", coords = vector3(105.45, -1303.92, 28.77), cameraLocation = vector4(105.05, -1302.51, 28.77, 209.78)},

    -- add this to Config.Outfits
        ["unicorn"] = {
        ["male"] = {
            -- STRIPPER OUTFITS
            [1] = {
                outfitLabel = "Stripper outfit 1",
                outfitData = {
                   ["arms"] = { item = 40, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 61, texture = 9 }, 
                   ["shoes"] = { item = 16, texture = 9 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [2] = {
                outfitLabel = "Stripper outfit 2",
                outfitData = {
                   ["arms"] = { item = 14, texture = 0 }, 
                   ["torso2"] = { item = 62, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 4, texture = 0 }, 
                   ["shoes"] = { item = 34, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [3] = {
                outfitLabel = "Stripper outfit 3",
                outfitData = {
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 4, texture = 0 }, 
                   ["shoes"] = { item = 34, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [4] = {
                outfitLabel = "Stripper outfit 4",
                outfitData = {
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 61, texture = 5 }, 
                   ["shoes"] = { item = 34, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [5] = {
                outfitLabel = "Stripper outfit 5",
                outfitData = {
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 21, texture = 0 }, 
                   ["shoes"] = { item = 34, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [6] = {
                outfitLabel = "Stripper outfit 6",
                outfitData = {
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 81, texture = 0 }, 
                   ["shoes"] = { item = 34, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },
            [7] = {
                outfitLabel = "Stripper outfit 7",
                outfitData = {
                   ["arms"] = { item = 40, texture = 0 }, 
                   ["torso2"] = { item = 15, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 118, texture = 0 }, 
                   ["pants"] = { item = 61, texture = 9 }, 
                   ["shoes"] = { item = 16, texture = 9 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                }
            },

            -- BARTENDER OUTFITS
            [8] = {
                outfitLabel = "Bartender outfit 1",
                outfitData = {
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["torso2"] = { item = 11, texture = 1 }, 
                   ["pants"] = { item = 24, texture = 0 }, 
                   ["arms"] = { item = 4, texture = 0 }, 
                   ["t-shirt"] = { item = 22, texture = 4 }, 
                   ["shoes"] = { item = 20, texture = 0 }, 
                }
            },

            -- BOUNCER OUTFITS
            [9] = {
                outfitLabel = "Bouncer outfit 1",
                outfitData = {
                   ["torso2"] = { item = 22, texture = 1 }, 
                   ["arms"] = { item = 0, texture = 0 }, 
                   ["t-shirt"] = { item = 15, texture = 0 }, 
                   ["shoes"] = { item = 10, texture = 0 }, 
                   ["pants"] = { item = 13, texture = 0 }, 
                }
            },            
        },
        ["female"] = {
            -- STRIPPER OUTFITS
            [1] = {
                outfitLabel = "Stripper outfit 1",
                outfitData = {
                   ["torso2"] = { item = 22, texture = 0 }, 
                   ["shoes"] = { item = 18, texture = 0 }, 
                   ["accessory"] = { item = 61, texture = 1 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 4, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 22, texture = 0 }, 
                }
            },
            [2] = {
                outfitLabel = "Stripper outfit 2",
                outfitData = {
                   ["torso2"] = { item = 22, texture = 2 }, 
                   ["shoes"] = { item = 18, texture = 2 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 4, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 20, texture = 2 }, 
                }
            },
            [3] = {
                outfitLabel = "Stripper outfit 3",
                outfitData = {
                   ["torso2"] = { item = 22, texture = 1 }, 
                   ["shoes"] = { item = 19, texture = 3 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 19, texture = 1 }, 
                }
            },
            [4] = {
                outfitLabel = "Stripper outfit 4",
                outfitData = {
                   ["torso2"] = { item = 82, texture = 0 }, 
                   ["shoes"] = { item = 41, texture = 11 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 63, texture = 11 }, 
                }
            },
            [5] = {
                outfitLabel = "Stripper outfit 5",
                outfitData = {
                   ["torso2"] = { item = 15, texture = 5 }, 
                   ["shoes"] = { item = 41, texture = 2 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 63, texture = 2 }, 
                }
            },
            [6] = {
                outfitLabel = "Stripper outfit 6",
                outfitData = {
                   ["torso2"] = { item = 18, texture = 3 }, 
                   ["shoes"] = { item = 41, texture = 10 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 63, texture = 10 }, 
                }
            },
            [7] = {
                outfitLabel = "Stripper outfit 7",
                outfitData = {
                   ["torso2"] = { item = 111, texture = 6 }, 
                   ["shoes"] = { item = 41, texture = 6 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["arms"] = { item = 15, texture = 0 }, 
                   ["t-shirt"] = { item = 3, texture = 0 }, 
                   ["pants"] = { item = 63, texture = 6 }, 
                }
            },

            -- BARTENDER OUTFITS
            [8] = {
                outfitLabel = "Bartender outfit 1",
                outfitData = {
                   ["arms"] = { item = 4, texture = 0 }, 
                   ["decals"] = { item = 0, texture = 0 }, 
                   ["accessory"] = { item = 0, texture = 0 }, 
                   ["torso2"] = { item = 74, texture = 1 }, 
                   ["pants"] = { item = 12, texture = 7 }, 
                   ["shoes"] = { item = 42, texture = 4 }, 
                   ["t-shirt"] = { item = 14, texture = 0 }, 
                }
            },

            -- BOUNCER OUTFITS
            [9] = {
                outfitLabel = "Bouncer outfit 1",
                outfitData = {
                   ["pants"] = { item = 3, texture = 0 }, 
                   ["torso2"] = { item = 27, texture = 1 }, 
                   ["t-shirt"] = { item = 14, texture = 0 }, 
                   ["arms"] = { item = 0, texture = 0 }, 
                   ["shoes"] = { item = 27, texture = 0 }, 
                }
            },            
        }
    }
    ```
* Go to qb-radialmenu/config.lua and add the following to Config.JobInteractions:
    ```lua
    ["unicorn"] = {
        {
            id = "bill",
            title = "Bill player",
            icon = "dollar-sign",
            type = "client",
            event = "loaf_vanillaunicorn:bill_closest_player",
            shouldClose = true,
        }
    },
    ```
* Go to qb-shops/config.lua and add the following to Config.Products:
    ```lua
    ["bar"] = {
        {
            name = 'cosmopolitan',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 1,
        },
        {
            name = 'mojito',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 2,
        },
        {
            name = 'mai_tai',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 3,
        },
        {
            name = 'mint_julep',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 4,
        },
        {
            name = 'caipirinha',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 5,
        },
        {
            name = 'margarita',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 6,
        },
        {
            name = 'pina_colada',
            price = 100,
            amount = 9999999,
            info = {},
            type = 'item',
            slot = 7,
        },
    },
    ```
* Go to qb-shops/config.lua and add the following to Config.Locations:
    ```lua
    -- Loaf Vanilla Unicorn
    ["unicorn_bar"] = {
        ["label"] = "Vanilla Unicorn",
        ["type"] = "bar",
        ["coords"] = {vector3(136.36, -1288.32, 29.27)},
        ["products"] = Config.Products["bar"]
    }
    ```