 Config = {}
Translation = {}

Config.Locale = 'de'

Config.ShowFarmingBlipText = true

Config.useNewESX = true -- ESX 1.2 or newer
Config.MenuPosition = {x = 0, y = 0}

Config.FarmingAreas = { 

    -- optional config
    -- requiredItems:array
    --requiredItems = {{name = '<databasename>', label = "<itemlabel>", amount = <numericamount>, removeAfterCollect = <true or false>}}
    --[[
        name                : name of item in database
        label               : your label for the item
        amount              : amount of items required (if removeAfterCollect is set to true, this amount is removed from inventory as well) -2166.290039, 164.479126, 173.143555
        removeAfterCollect  : if true the required items is removed from inventory after collecting
    ]]--
	-- you can set blip = nil to hide the blip

    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 1, data = nil}, items = {{name = 'grapperaisin', label = 'Trauben', randoma = 1, randomb = 3}}, x = -1721.828613,y= 2348.953857,z= 58.345825, range = 50.0, collectingTime = 10, animation = {type = 'animation', dict = "mini@repair", anim = "fixing_a_ped"}, requiredItems={}},
    {requiredJob = 'unemployed', xptype = nil, blip = {sprite = 1, color = 36, data = nil}, items = {{name = 'schrauben', label = 'Schrauben', randoma = 1, randomb = 3}}, x = 2427.375732,y= 3084.263672,z= 48.842529, range = 5.0, collectingTime = 10, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 33, data = nil}, items = {{name = 'weat', label = 'Weizen', randoma = 2, randomb = 5}}, x = 2616.83, y = 4451.19, z = 39.06, range = 60.0, collectingTime = 15, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 4, data = nil}, items = {{name = 'baumwolle', label = 'Baumwolle', randoma = 1, randomb = 3}}, x = 5353.332031,y= -5334.685547,z= 38.159668, range = 60.0, collectingTime = 10, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 1, data = nil}, items = {{name = 'apple', label = 'Apfel', randoma = 1, randomb = 3}}, x = 2519.208740, y= 4356.118652,z = 39.086426, range = 30.0, collectingTime = 7, animation = {type = 'scenario', anim = "PROP_HUMAN_BUM_BIN"}, requiredItems={}}, -- or orange
    {requiredJob = 'unemployed', xptype = nil, blip = {sprite = 1, color = 50, data = nil}, items = {{name = 'tomatos', label = 'Tomaten', randoma = 1, randomb = 3}}, x = 2286.97, y = 4763.68, z = 38.61, range = 10.0, collectingTime = 11, animation = {type = 'scenario', anim = "PROP_HUMAN_BUM_BIN"}, requiredItems={}},
    {requiredJob = 'unemployed', xptype = nil, blip = {sprite = 1, color = 69, data = nil}, items = {{name = 'salad', label = 'Salat', randoma = 1, randomb = 3}}, x = 3288.39, y = 5181.42, z = 18.56, range = 8.0, collectingTime = 15, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = nil, items = {{name = 'hopfen', label = 'Hopfen', randoma = 1, randomb = 2}}, x = 1773.903320,y= 5000.637207,z= 52.229248, range = 7.0, collectingTime = 20, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = nil, items = {{name = 'agave', label = 'Agavensaft', randoma = 1, randomb = 2}}, x = 1583.512085,y= 3292.061523,z= 42.169922, range = 7.0, collectingTime = 20, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 44, data = nil}, items = {{name = 'pilz', label = 'Pilze', randoma = 1, randomb = 3}}, x = -2166.290039,y= 164.47,z= 173.14, range = 30.0, collectingTime = 8, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 71, data = nil}, items = {{name = 'aramid', label = 'Aramid', randoma = 1, randomb = 2}}, x = 2731.45,y= 2879.47,z= 38.02, range = 20.0, collectingTime = 8, animation = {type = 'scenario', anim = "world_human_gardener_plant"}, requiredItems={}},
    {requiredJob = nil, xptype = nil, blip = {sprite = 1, color = 20, data = nil}, items = {{name = 'stone', label = 'Steine', percentage = 20, randoma = 1, randomb = 3}, {name = 'coal', label = 'Kohle', percentage = 40, randoma = 1, randomb = 3},{name = 'copper', label = 'Kupfer', percentage = 60, randoma = 1, randomb = 3}, {name = 'iron', label = 'Eisen', percentage = 85, randoma = 1, randomb = 3}, {name = 'diamond', label = 'Diamant', percentage = 95, randoma = 1, randomb = 1}, {name = 'emerald', label = 'Saphir', percentage = 100, randoma = 1, randomb = 1}}, x = -587.221985,y= 2050.114258,z= 129.957520, range = 38.0, collectingTime = 10, animation = {type = 'scenario', anim = "WORLD_HUMAN_CONST_DRILL"}, requiredItems={}},
}

Config.CraftBlipIcon = 1 -- default when not set below individual
Config.CraftBlipColour = 2


-- Optional parameters:
-- hideBlip: Set to true, if the blip should be invisible
-- marker = {r = 100, g = 100, b = 100} set up a marker, which should be drawn when near a processor
-- set ped = nil, when you want to disable the ped
-- animation = nil, when you want to disable the animation
Config.Processor = {
    {requiredJob = nil, requiredrank = 0,ItemsId = 1, label = 'Saft', XPType = 'juice', ped = "s_m_m_migrant_01", x = 2741.59, y = 4412.76, z = 48.62, rot = 190.0},
    {requiredJob = 'unemployed',requiredrank = 0, ItemsId = 2, label = 'Baeckerei', XPType = 'bakery', animation = {type = 'scenario', anim = "PROP_HUMAN_BUM_BIN"}, ped = "s_m_m_strvend_01", x = 395.04,y= -792.10,z= 29.29,rot= 266.57},
    {requiredJob = 'unemployed',requiredrank = 0,ItemsId = 6, label = 'Salatherstellung', XPType = 'salad', ped = nil, x = -1693.92, y = -1085.12, z = 13.15, rot = 130.0}, --"a_m_m_farmer_01"
    {requiredJob = nil, requiredrank = 0,ItemsId = 7, label = 'Schmelze', XPType = 'stone', ped = "ig_chef2", x = 1109.076904,y= -2009.063721,z= 30.931152,rot= 36.850395},
    {requiredJob = 'club' ,requiredrank = 0,ItemsId = 9, label = 'Brauerei', XPType = 'brewery', ped = "ig_chef2", x = -56.571423,y= 6431.696777,z= 32.683472,rot= 303.307098},
    {hideBlip= true, requiredJob = nil ,requiredrank = 0,ItemsId = 10, label = 'Pilze', XPType = 'psilocybin', ped = "ig_chef2", x = -1810.11,y= -1226.13,z= 13.02,rot= 303.307098},
    --{hideBlip= true, requiredJob = nil ,requiredrank = 0,ItemsId = 11, label = 'Maische', XPType = 'maische', ped = "ig_chef2", x = -1889.643921,y= 2050.562744,z= 140.808838,rot= 150.236221},
    --{hideBlip= true, requiredJob = nil ,requiredrank = 0,ItemsId = 12, label = 'Wein', XPType = 'wein', ped = "ig_chef2", x = -1909.978027,y= 2071.358154,z= 140.370728,rot= 138.897629},
    {requiredJob = nil ,requiredrank = 0,ItemsId = 13, label = 'Stoff', XPType = 'stoff', ped = "ig_chef2", x = 5066.980469,y= -4591.279297,z= 2.842529,rot= 184.251968},  
    {requiredJob = nil ,requiredrank = 0,ItemsId = 14, label = 'Taschen', XPType = 'taschen', ped = "ig_chef2", x= 451.424164,y=  -739.200012,z = 27.342163, rot = 257.952759},
    {requiredJob = nil ,requiredrank = 0,ItemsId = 15, label = 'Aramid', XPType = 'aramid', ped = "ig_chef2", x = 2677.67,y= 2761.35,z= 37.88,rot= 34.015747},
    {requiredJob = nil ,requiredrank = 0,ItemsId = 16, label = 'Kevlar', XPType = 'kevlar', ped = "ig_chef2", x = 719.393433,y= -960.026367,z= 30.391968,rot= 133.228333},
    {requiredJob = nil ,requiredrank = 0,ItemsId = 17, label = 'Steine', XPType = 'stone', ped = nil, x = 1901.024170, y= 365.643951, z= 160.978027,rot=nil},
    --{requiredJob = nil,ItemsId = 8, label = 'Jeweler', XPType = 'jewellery', ped = "u_f_y_jewelass_01", x = -622.05590820313, y = -232.09861755371, z = 38.057010650635, rot = 126.61913299561},
}

Config.Seller = {
    {requiredJob = nil, isExport = true, label = 'Großmarkt Port Los Santos', priceModifier = 1.3, x = -332.6, y = -2792.68, z = 5.0, rot = 90.0, type = 'export'}, -- The type defines which content of Config.SellItems is used.
    {hideBlip = false, requiredJob = nil, isExport = true, label = 'Großmarkt JetSan Terminal', priceModifier = 1.1, x = 797.01, y = -2988.83, z = 6.02, rot = 90.0, type = 'export'}, 
    {requiredJob = nil, isExport = false, label = 'Lieferjobs', priceModifier = 1.3, x = -1283.37, y = -565.02, z = 31.71, rot = 310.0},
    {hideBlip = false, requiredJob = nil, isExport = true, label = 'Pfandsammler', priceModifier = 1.7, x = 29.037365, y=-1769.894531,z= 29.599976, rot = 62.0, type = 'pfand'},
}

Config.Buyer = {
    {requiredJob = 'hook', isImport = true, label = 'Metro LSIA', priceModifier = 1.0, x = -1039.160400,y= -2208.039551,z= 9.060059, rot = 238.110229, type = 'hookah'},
    {requiredJob = 'club', isImport = true, label = 'Metro LSIA', priceModifier = 1.0, x = -1039.160400,y= -2208.039551,z= 9.060059, rot = 238.110229, type = 'import'},
    {requiredJob = 'lafam', isImport = true, label = 'Metro LSIA', priceModifier = 1.0, x = -1039.160400,y= -2208.039551,z= 9.060059, rot = 238.110229, type = 'import'},
}


Config.useIntegratedWeightSystem = false
Config.useESXWeightSystem = true -- disable Config.useIntegratedWeightSystem when you want to use this

Config.MaxCarry = 300

Config.ItemLimits = {

    ['grapperaisin'] = 60,
    ['weat'] = 25,
    ['apple'] = 60,
    ['tomatos'] = 60,
    ['salad'] = 60,
    ['stone'] = 70,
    ['coal'] = 70,
    ['silver'] = 70,
    ['gold'] = 70,
	
    ['flour'] = 20,
    ['applejuice'] = 50,
    ['tomatojuice'] = 50,
    ['orangejuice'] = 50,
    ['berriesjuice'] = 50,
    ['mixedsalad'] = 50,
	
	['concrete'] = 70,
	['coalingot'] = 60,
	['silveringot'] = 60,
	['goldingot'] = 60,
	
	['ironbraclet'] = 50,
	['goldrings'] = 50,
	['necklace'] = 50,

}

Config.defaultCraftTime = 4 -- in seconds

Config.Items = {

    {
        id = 1,
        reqXP = 0,
        giveXP = {type = 'juice', a = 1, b = 3},
        requiredItemNotRemove = 'apple',
        randomchance = nil,
        reqItems = {
            {item = 'apple', label = 'Apfel', amount = 5}},
        newitem = {sqlitem = 'applejuice', label = 'Apfelsaft'},
        newitemamount = 1,
        craftAmount = 10,
        craftTime = 3,
    },
    {
        id = 1,
        reqXP = 1000,
        giveXP = {type = 'juice', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'tomatos', label = 'Tomaten', amount = 3}},
        newitem = {sqlitem = 'tomatojuice', label = 'Tomatensaft'},
        newitemamount = 1,
        craftAmount = 10,
        craftTime = 7,
    },
    {
        id = 1,
        reqXP = 2000,
        giveXP = {type = 'juice', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'grapperaisin', label = 'Trauben', amount = 2}},
        newitem = {sqlitem = 'berriesjuice', label = 'Traubensaft'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 2,
        reqXP = 0,
        giveXP = {type = 'bakery', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 3}},
        newitem = {sqlitem = 'flour', label = 'Mehl'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 2,
        reqXP = 3000,
        giveXP = {type = 'bakery', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'flour', label = 'Mehl', amount = 20}},
        newitem = {sqlitem = 'bread', label = 'Brot'},
        newitemamount = 2,
        craftAmount = 15
    },
    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'salad', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'salad', label = 'Salat', amount = 1},
            {item = 'tomatos', label = 'Tomaten', amount = 1}},
        newitem = {sqlitem = 'mixedsalad', label = 'Gemischter Salat'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 500,
        giveXP = {type = 'stone', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'stone', label = 'Stein', amount = 4}},
        newitem = {sqlitem = 'concrete', label = 'Beton'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 0,
        giveXP = {type = 'stone', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'coal', label = 'Kohle', amount = 3}},
        newitem = {sqlitem = 'coalingot', label = 'Kohlebrikette'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 2000,
        giveXP = {type = 'stone', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'coalingot', label = 'Kohlebrikette', amount = 2},
            {item = 'iron', label = 'Eisen', amount = 5}},
        newitem = {sqlitem = 'ironbraclet', label = 'Eisenbarren'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 2000,
        giveXP = {type = 'stone', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'coalingot', label = 'Kohlebrikette', amount = 2},
            {item = 'copper', label = 'Kupfer', amount = 5}},
        newitem = {sqlitem = 'copperbraclet', label = 'Kupferbarren'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 0,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'coalingot', label = 'Coal ingot', amount = 2},
            {item = 'silveringot', label = 'Silver ingot', amount = 1}},
        newitem = {sqlitem = 'ironbraclet', label = 'Iron braclet'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 0,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'goldingot', label = 'Gold ingot', amount = 2}},
        newitem = {sqlitem = 'goldrings', label = 'Gold ring'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 0,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'goldingot', label = 'Gold ingot', amount = 1},
            {item = 'silveringot', label = 'Silver ingot', amount = 2}},
        newitem = {sqlitem = 'necklace', label = 'Necklace'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 0,
        giveXP = {type = 'brewery', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 10},
            {item = 'hopfen', label = 'Hopfen', amount = 10}},
        newitem = {sqlitem = 'craftbeer', label = 'Craftbier'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 5000,
        giveXP = {type = 'brewery', a = 2, b = 5},
        randomchance = nil,
        reqItems = {
            {item = 'agave', label = 'Agavensaft', amount = 20}},
        newitem = {sqlitem = 'tequila', label = 'Tequila'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 10000,
        giveXP = {type = 'brewery', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 10}},
        newitem = {sqlitem = 'wodka', label = 'Wodka'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 10,
        reqXP = 0,
        giveXP = {type = 'psilocybin', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'pilz', label = 'Pilze', amount = 2}},
        newitem = {sqlitem = 'psilocybin', label = 'Psilocybin'},
        newitemamount = 1,
        craftAmount = 20
    },
    {
        id = 11,
        reqXP = 0,
        giveXP = {type = 'maische', a = 2, b = 4},
        randomchance = nil,
        reqItems = {
            {item = 'grapperaisin', label = 'Trauben', amount = 2}},
        newitem = {sqlitem = 'maische', label = 'Maische'},
        newitemamount = 2,
        craftAmount = 100
    },
    {
        id = 12,
        reqXP = 0,
        giveXP = {type = 'wein', a = 2, b = 5},
        randomchance = nil,
        reqItems = {
            {item = 'maische', label = 'Maische', amount = 2},
            {item = 'berriesjuice', label = 'Traubensaft', amount = 1}},
        newitem = {sqlitem = 'sekt', label = 'Sekt'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 12,
        reqXP = 2000,
        giveXP = {type = 'wein', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'maische', label = 'Maische', amount = 2},
            {item = 'berriesjuice', label = 'Traubensaft', amount = 1},
            {item = 'grapperaisin', label = 'Trauben', amount = 1}},
        newitem = {sqlitem = 'champagne', label = 'Champagner'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 12,
        reqXP = 2000,
        giveXP = {type = 'wein', a = 2, b = 5},
        randomchance = nil,
        reqItems = {
            {item = 'grapperaisin', label = 'Trauben', amount = 2}},
        newitem = {sqlitem = 'rotwein', label = 'Rotwein'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 12,
        reqXP = 2000,
        giveXP = {type = 'wein', a = 2, b = 5},
        randomchance = nil,
        reqItems = {
            {item = 'grapperaisin', label = 'Trauben', amount = 2}},
        newitem = {sqlitem = 'weisswein', label = 'Weißwein'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 13,
        reqXP = 0,
        giveXP = {type = 'stoff', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'baumwolle', label = 'Baumwolle', amount = 100}},
        newitem = {sqlitem = 'clothe', label = 'Stoff'},
        newitemamount = 2,
        craftAmount = 100
    },
    {
        id = 14,
        reqXP = 0,
        giveXP = {type = 'taschen', a = 30, b = 50},
        randomchance = nil,
        reqItems = {
            {item = 'clothe', label = 'Stoff', amount = 50}},
        newitem = {sqlitem = 'bagpack', label = 'Tasche'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 14,
        reqXP = 1500,
        giveXP = {type = 'taschen', a = 20, b = 40},
        randomchance = nil,
        reqItems = {
            {item = 'clothe', label = 'Stoff', amount = 75}},
        newitem = {sqlitem = 'bagpack2', label = 'Tasche Groß'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 14,
        reqXP = 1500,
        giveXP = {type = 'taschen', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'clothe', label = 'Stoff', amount = 100}},
        newitem = {sqlitem = 'parachute', label = 'Fallschirm'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 15,
        reqXP = 0,
        giveXP = {type = 'aramid', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'aramid', label = 'Aramid', amount = 5}},
        newitem = {sqlitem = 'aramidfaser', label = 'Aramidfasern'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 16,
        reqXP = 0,
        giveXP = {type = 'kevlar', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'aramidfaser', label = 'Aramidfasern', amount = 5}},
        newitem = {sqlitem = 'kevlar', label = 'Kevlar'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 16,
        reqXP = 0,
        giveXP = {type = 'kevlar', a = 1, b = 3},
        randomchance = nil,
        reqItems = {
            {item = 'kevlar', label = 'Kevlar', amount = 1}},
        newitem = {sqlitem = 'bulletproof2', label = 'Schutzweste'},
        newitemamount = 1,
        craftAmount = 100
    },
    {
        id = 17,
        reqXP = 0,
        giveXP = {type = 'stone', a = 1, b = 3},
        randomchance = 75,
        reqItems = {
            {item = 'stone', label = 'Steine', amount = 10}},
        newitem = {sqlitem = 'kristall', label = 'Kristall'},
        newitemamount = 2,
        craftAmount = 100
    },

}


Config.SellItems = {
    ['export'] = {
        {category = 'Hauptkategorie', content = {
            {sqlitem = 'grapperaisin', label = 'Trauben', priceBuy = 21.0},
            {sqlitem = 'weat', label = 'Weizen', priceBuy = 90.0},
            {sqlitem = 'apple', label = 'Apfel', priceBuy = 21.0},
            {sqlitem = 'tomatos', label = 'Tomaten', priceBuy = 21.0},
            {sqlitem = 'salad', label = 'Salat', priceBuy = 21.0},
            {sqlitem = 'stone', label = 'Steine', priceBuy = 19.0},
            {sqlitem = 'coal', label = 'Kohle', priceBuy = 24.0},
            {sqlitem = 'cooper', label = 'Kupfer', priceBuy = 34.0},
            {sqlitem = 'iron', label = 'Eisen', priceBuy = 34.0},
            {sqlitem = 'hopfen', label = 'Hopfen', priceBuy = 34.0},
            {sqlitem = 'pilz', label = 'Pilze', priceBuy = 55.0},
            {sqlitem = 'baumwolle', label = 'Baumwolle', priceBuy = 24.0},
            {sqlitem = 'clothe', label = 'Stoff', priceBuy = 35.0},
        }},
        {category = 'Salat', content = {
            {sqlitem = 'mixedsalad', label = 'Gemischter Salat', priceBuy = 226.0},
        }},
        {category = 'Säfte', content = {
            {sqlitem = 'applejuice', label = 'Apfelsaft', priceBuy = 511.0},
            {sqlitem = 'tomatojuice', label = 'Tomatensaft', priceBuy = 589.0},
            {sqlitem = 'berriesjuice', label = 'Traubensaft', priceBuy = 787.0},
        }},
        {category = 'Baeckerei', content = {
            {sqlitem = 'flour', label = 'Mehl', priceBuy = 250.0},
        }},
        {category = 'Bergbau', content = {
            {sqlitem = 'concrete', label = 'Beton', priceBuy = 497.0},
            {sqlitem = 'coalingot', label = 'Kohlebrikette', priceBuy = 159.0},
            {sqlitem = 'copperbraclet', label = 'Kupferbarren', priceBuy = 999.0},
            {sqlitem = 'ironbraclet', label = 'Eisenbarren', priceBuy = 999.0},
        }},
        {category = 'Brauerei', content = {
            {sqlitem = 'craftbeer', label = 'Craftbier', priceBuy = 297.0},
        }},
        {category = 'Stoff', content = {
            {sqlitem = 'bagpack', label = 'Tasche', priceBuy = 390.0},
            {sqlitem = 'bagpack2', label = 'Tasche groß', priceBuy = 690.0},
            {sqlitem = 'aramid', label = 'Aramid', priceBuy = 14.0},
            {sqlitem = 'kevlar', label = 'Kevlar', priceBuy = 25.0},
            {sqlitem = 'bulletproof2', label = 'Schutzweste', priceBuy = 1200.0},
        }},
    },
    ['pfand'] = {
        {category = 'Hauptkategorie', content = {
            {sqlitem = 'bottle', label = 'Flasche', priceBuy = 55.0},
            {sqlitem = 'gazbottle', label = 'Gasflasche', priceBuy = 150.0},
        }},
    },
    -- ['example'] = { -- Just an example to show how you could add new shops with different content
    --     {category = 'example category', content = {
    --         {sqlitem = 'grapperaisin', label = 'Grapperaisin', priceBuy = 21.0},
    --         {sqlitem = 'weat', label = 'Wheat', priceBuy = 9.0},
    --         {sqlitem = 'apple', label = 'Apple', priceBuy = 21.0},
    --     }},
    --     {category = 'another example', content = {
    --         {sqlitem = 'mixedsalad', label = 'Mixed salad', priceBuy = 226.0},
    --     }},
    -- },

}
Config.BuyItemsAktiv = false

Config.BuyItems = {
    ['import'] = {}
       --[[
    ['import'] = {
        {category = 'Hauptkategorie', content = {
            {sqlitem = 'cola', label = 'Cola', priceBuy = 800.0},
            {sqlitem = 'fanta', label = 'Fanta', priceBuy = 800.0},
            {sqlitem = 'nusse', label = 'Nüsse', priceBuy = 550.0},
            {sqlitem = 'sprite', label = 'Sprite', priceBuy = 800.0},
            {sqlitem = 'eistee', label = 'Eistee', priceBuy = 800.0},
            {sqlitem = 'coffee', label = 'Kaffee', priceBuy = 500.0},
        }},
    },
     
    ['hookah'] = {
        {category = 'Kühllager', content = {
            {sqlitem = 'fleisch', label = 'Fleisch', priceBuy = 250.0},
            {sqlitem = 'kase', label = 'Käse', priceBuy = 50.0},
            {sqlitem = 'patty', label = 'Nüsse', priceBuy = 150.0},
            {sqlitem = 'steakfleisch', label = 'Steakfleisch', priceBuy = 250.0},
        }},
        {category = 'Trockenlager', content = {
            {sqlitem = 'burgerbrot', label = 'Burgerbrot', priceBuy = 50.0},
            {sqlitem = 'donerbrot', label = 'Döner Brot', priceBuy = 100.0},
            {sqlitem = 'kartoffel', label = 'Kartoffel', priceBuy = 100.0},
            {sqlitem = 'ol', label = 'Öl', priceBuy = 50.0},
            {sqlitem = 'salz', label = 'Salz', priceBuy = 50.0},
            {sqlitem = 'zwiebel', label = 'Zwiebel', priceBuy = 50.0},
        }},
        {category = 'Getränke', content = {
            {sqlitem = 'cola', label = 'Cola', priceBuy = 800.0},
            {sqlitem = 'fanta', label = 'Fanta', priceBuy = 800.0},
            {sqlitem = 'coffee', label = 'Kaffee', priceBuy = 500.0},
            {sqlitem = 'beer', label = 'Bier', priceBuy = 500.0},
            {sqlitem = 'eistee', label = 'Eistee', priceBuy = 800.0},
        }},
    },
    --]]
}
--[[

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grapperaisin', 'Grapperaisin', 60, 0, 1),
	('weat', 'Weat', 60, 0, 1),
	('apple', 'Apple', 60, 0, 1),
	('tomatos', 'Tomatos', 60, 0, 1),
	('salad', 'Salad', 60, 0, 1),
	('stone', 'Stone', 60, 0, 1),
	('coal', 'Coal', 60, 0, 1),
	('silver', 'Silver', 60, 0, 1),
	('gold', 'Gold', 60, 0, 1),
	('mixedsalad', 'Mixed salad', 60, 0, 1),
	('applejuice', 'Apple juice', 60, 0, 1),
	('tomatojuice', 'Tomato juice', 60, 0, 1),
	('berriesjuice', 'Berries juice', 60, 0, 1),
	('flour', 'Flour', 60, 0, 1),
	('concrete', 'Concrete', 60, 0, 1),
	('coalingot', 'Coal ingot', 60, 0, 1),
	('silveringot', 'Silver ingot', 60, 0, 1),
	('goldingot', 'Gold ingot', 60, 0, 1);
]]

Config.RandomPickAmountOnStart = 7

Config.LocalItems = {
    {id = 1, label = 'Panic Catering', 
    price = 12620,
    requires = {
        {item = 'flour', label = 'Mehl', amount = 6},
        {item = 'apple', label = 'Apfel', amount = 8},
    }, 
    destination = {x = -278.05, y = -2037.44, z = 30.15},
    state = 0,
    recommendJob = nil},

    {id = 2, label = 'Richman Breakfast', 
    price = 13470, 
    requires = {
        {item = 'mixedsalad', label = 'Gemischter Salat', amount = 3},
    }, 
    destination = {x = -1274.4, y = 314.91, z = 65.51},
    state = 0,
    recommendJob = nil},

    {id = 3, label = 'Richman Happy Hour', 
    price = 12745, 
    requires = {
        {item = 'craftbeer', label = 'Craftbier', amount = 20}
    }, 
    destination = {x = -1274.4, y = 314.91, z = 65.51},
    state = 0,
    recommendJob = nil},

    {id = 4, label = 'Shark Bites Beach', 
    price = 15860, 
    requires = {
        {item = 'applejuice', label = 'Apfelsaft', amount = 8},
        {item = 'berriesjuice', label = 'Traubensaft', amount = 8},
    }, 
    destination = {x = -1298.01, y = -1387.61, z = 4.54},
    state = 0,
    recommendJob = 'unemployed'},

    --[[{id = 5, label = 'The Pearl Celebration', 
    price = 1540, 
    requires = {
        {item = 'golem', label = 'Golem', amount = 12},
        {item = 'whiskycoca', label = 'Whisky-Coca', amount = 5},
        {item = 'jusfruit', label = 'Fruit juice', amount = 6},
    }, 
    destination = {x = -1816.31, y = -1192.68, z = 14.31},
    state = 0,
    recommendJob = 'Clubs'},]]

    {id = 18, label = 'Airport Bilgeco', 
    price = 29500, 
    requires = {
        {item = 'tomatojuice', label = 'Tomatensaft', amount = 40},
    }, 
    destination = {x = -874.55, y = -2735.07, z = 13.9},
    state = 0,
    recommendJob = 'unemployed'},

    {id = 6, label = 'Crastenburg Breakfast', 
    price = 14030, 
    requires = {
        {item = 'tomatos', label = 'Tomaten', amount = 40},
        {item = 'mixedsalad', label = 'Gemischter Salat', amount = 30},
    }, 
    destination = {x= -1858.72, y= -348.64, z = 49.84},
    state = 0,
    recommendJob = 'unemployed'},

    {id = 7, label = 'Construction', 
    price = 12268, 
    requires = {
        {item = 'concrete', label = 'Beton', amount = 12},
    }, 
    destination = {x = -585.78631591797, y = -286.04611206055, z = 35.454780578613},
    state = 0,
    recommendJob = 'unemployed'},
}




Translation = {
    ['de'] = {
        ['enter_farming'] = 'Du betrittst nun ein ~g~',
        ['enter_farming2'] = ' Sammelgebiet~s~. Drücke ~g~E~s~, um mit dem Sammeln zu beginnen.',
        ['pre_collect'] = '',
        ['collect'] = ' sammeln',
        ['info_production'] = 'Drücke ~g~E~s~, um Waren zu verarbeiten',
        ['info_sell'] = 'Drücke ~g~E~s~, um Waren zu verkaufen',
        ['info_buy'] = 'Drücke ~g~E~s~, um Waren zu kaufen',
        ['info_available_missions'] = '~b~Verfügbare Aufträge',
        ['info_current_mission'] = 'Aktueller Auftrag:',
        ['info_destination'] = 'Zielort:',
        ['info_reward'] = 'Lohn bei Abgabe:',
        ['info_reqItems'] = '~HUD_COLOUR_NET_PLAYER21~BENÖTIGTE PRODUKTE:',
        ['info_abort'] = '~r~Auftrag abbrechen',
        ['info_abort_confirm'] = '~g~Der Auftrag wurde zurückgegeben und kann nun von jemand anderem bearbeitet werden.',
        ['prefix_in_processing'] = '~HUD_COLOUR_HB_YELLOW~IN BEARBEITUNG: ~s~',
        ['prefix_special'] = '~p~SPEZIAL: ~s~',
        ['prefix_in_processing_desc'] = 'Dieser Auftrag wird gerade von einer anderen Person bearbeitet.',
        ['prefix_special_desc'] = 'Dieser Job sollte von Mitarbeitern des ~p~',
        ['prefix_special_desc2'] = '~s~ erledigt werden.',
        ['info_case'] = 'Auftrag:',
        ['info_recommendJob'] = '~r~! ~s~Empfohlener Job:',
        ['info_recommendJob_desc'] = 'Dieser Auftrag beinhaltet Produkte, die nicht jeder herstellen kann.',
        ['info_accept'] = '~g~Auftrag annehmen',
        ['info_accept_desc'] = 'Wenn du alle Produkte hast, liefere diese nun aus.',
        ['sell'] = 'Verkaufen',
        ['sell_desc'] = 'Wähle aus wie viel du verkaufen möchtest?',
        ['input_howmuch'] = 'Wie viel soll verkauft werden?',
        ['input_howmuch2'] = 'Wie viel soll gekauft werden?',
        ['xp'] = ' Erfahrungspunkte',
        ['pre_craft'] = '',
        ['craft'] = ' herstellen',
        ['required'] = 'Benötigt ',
        ['start_craft'] = 'Gegenstände verarbeiten',
        ['not_enough_xp'] = 'Du hast nicht genügend Erfahrung! ~y~',
        ['not_enough_xp_required'] = ' Erfahrung benötigt.',
        ['notify_out_of_range'] = '~r~Du darfst den Umkreis des Verarbeiters ~w~5m ~r~nicht verlassen.',
        ['notify_aborted'] = 'Abgebrochen!',
        ['mission_started'] = '~g~Auftrag ~w~',
        ['mission_started2'] = ' ~g~angenommen. Gebe die Produkte am ~p~markierten Punkt ~g~ab.',
        ['collected'] = 'gesammelt',
        ['not_enough_items'] = '~r~Nicht genügend ~w~',
        ['craftting_finished'] = '~g~Herstellung von ~w~',
        ['craftting_finished2'] = ' ~g~abgeschlossen!',
        ['items_sold_for'] = '~s~Gegenstände verkauft für ~g~',
        ['you_only_have_items'] = '~y~Das hast nur ~w~',
        ['you_only_have_items2'] = 'x ~y~dabei',
        ['mission_in_process'] = '~y~Der Auftrag wird gerade von einer anderen Person bearbeitet.',
        ['mission_not_available'] = '~r~Dieser Auftrag ist nicht mehr verfügbar.',
        ['mission_success'] = '~g~Auftrag ~w~',
        ['mission_success2'] = ' ~g~abgeschlossen! Du hast ~w~',
        ['mission_success3'] = '$ ~g~erhalten.',
        ['too_heavy'] = '~r~Du kannst nicht so viel tragen.',
        ['missing_items'] = 'Dir fehlen Gegenstände zum Sammeln: ',
        ['removed_item'] = 'Gegenstand entfernt: ',
    },
    ['en'] = {
        ['enter_farming'] = 'You have entered ~g~',
        ['enter_farming2'] = ' farming zone~s~. Press ~g~E~s~, to start collecting.',
        ['pre_collect'] = 'Collect ',
        ['collect'] = '',
        ['info_production'] = 'Press ~g~E~s~, manufacture items',
        ['info_sell'] = 'Press ~g~E~s~, to sell items',
        ['info_available_missions'] = '~b~Available jobs',
        ['info_current_mission'] = 'Current job:',
        ['info_destination'] = 'Destination:',
        ['info_reward'] = 'Payment upon delivery:',
        ['info_reqItems'] = '~HUD_COLOUR_NET_PLAYER21~REQUIRED ITEMS:',
        ['info_abort'] = '~r~Abort job',
        ['info_abort_confirm'] = '~g~Your job was aborted, and is now available again.',
        ['prefix_in_processing'] = '~HUD_COLOUR_HB_YELLOW~IN PROCESSING: ~s~',
        ['prefix_special'] = '~p~SPECIAL: ~s~',
        ['prefix_in_processing_desc'] = 'This job is currently being processed by another person.',
        ['prefix_special_desc'] = 'This job should be done by employees of ~p~',
        ['prefix_special_desc2'] = '~s~.',
        ['info_case'] = 'Job:',
        ['info_recommendJob'] = '~r~! ~s~Recommend Job:',
        ['info_recommendJob_desc'] = 'This job required products that not everyone can manufacture.',
        ['info_accept'] = '~g~Do this job',
        ['info_accept_desc'] = 'When you have all the products, deliver them now.',
        ['sell'] = 'Sell',
        ['sell_desc'] = 'Decide how much do you want to sell?',
        ['input_howmuch'] = 'How much should be sold?',
        ['xp'] = ' Experience',
        ['pre_craft'] = 'Craft ',
        ['craft'] = ' ',
        ['required'] = 'Requires ',
        ['start_craft'] = 'Manufacturing',
        ['not_enough_xp'] = 'You do not have enough experience! ~y~',
        ['not_enough_xp_required'] = ' Experience required.',
        ['notify_out_of_range'] = '~r~You can not leave the range ~w~5m ~r~while manufacuring.',
        ['notify_aborted'] = 'Aborted!',
        ['mission_started'] = '~g~Job ~w~',
        ['mission_started2'] = ' ~g~started. Deliver the items to the~p~marked position~g~.',
        ['collected'] = 'collected',
        ['not_enough_items'] = '~r~Not enough ~w~',
        ['craftting_finished'] = '~g~Manufacturing of ~w~',
        ['craftting_finished2'] = ' ~g~completed!',
        ['items_sold_for'] = '~s~Items sold for ~g~',
        ['you_only_have_items'] = '~y~You only have ~w~',
        ['you_only_have_items2'] = 'x ~y~in your inventory',
        ['mission_in_process'] = '~y~This job is currently done by another person.',
        ['mission_not_available'] = '~r~This job is not available anymore.',
        ['mission_success'] = '~g~Job ~w~',
        ['mission_success2'] = ' ~g~completed! You got ~w~',
        ['mission_success3'] = '$~g~.',
        ['too_heavy'] = '~r~You can not carry that much.',
        ['missing_items'] = 'You are missing items to collect: ',
        ['removed_item'] = 'Item removed: ',
    }
}