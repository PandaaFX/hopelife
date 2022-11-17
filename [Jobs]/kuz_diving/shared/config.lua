Config = {}
Config.Locale = 'en'

Config.Debug = false

Config.showOxygenRemaining = true

-- If all diving activities should be available for players with the `diving` job
Config.diverJobOnly = false

-- If players should receive divin/scuba gear when applying the items
Config.divingClothing = true

-- If diving stores should be available for players
Config.useDivingStores = true

-- If sell locations should ba available for players
Config.useSellLocations = true

Config.divingStores = {
    locations = {
        {
            x = -1093.9,
            y = -1349.3,
            z = 5.0,
        },
    },
    items = {
        {
            item = 'kuz_divinggeargood',
            label = 'Tauchausrüstung',
            price = 15000,
        }
    },
    payWithBank = true,
}

Config.sellLocations = {
    {
        locations = {
            {
                x = -621.0,
                y = -232.24,
                z = 38.06
            },
        },
        name = 'Juwelier',
        showOnMap = false,
        useAccount = 'bank',
        blipIcon = 617,
        blipColor = 46,
        blipScale = 0.8,
        items = {
            {
                item = 'kuz_watch',
                label = 'Teure Uhr',
                price = 1950,
            },
            {
                item = 'kuz_pearl',
                label = 'Perle',
                price = 1700,
            },
            {
                item = 'kuz_jewelry',
                label = 'Schmuck',
                price = 1440,
            },
            {
                item = 'kuz_goldcoin',
                label = 'Goldmünze',
                price = 970,
            },
            {
                item = 'kuz_silvercoin',
                label = 'Silbermünze',
                price = 725,
            },
            {
                item = 'kuz_plasmacutter',
                label = 'Schweißgerät',
                price = 1600,
            },
            {
                item = 'diamond',
                label = 'Diamant',
                price = 1000,
            },
            {
                item = 'painting',
                label = 'Gemälde',
                price = 500,
            },
            {
                item = 'gold',
                label = 'Gold',
                price = 650,
            },
            {
                item = 'emerald',
                label = 'Saphir',
                price = 950,
            },
            {
                item = 'kristall',
                label = 'Kristall',
                price = 550,
            },
        },
    },
    {
        locations = {
            {
                x = -1621.46,
                y = -380.81,
                z = 43.71
            },
            {
                x = -406.8,
                y = 6313.47,
                z = 28.94
            },
        },
        name = 'Münzsammler',
        showOnMap = true,
        useAccount = 'money',
        blipIcon = 431,
        blipColor = 46,
        blipScale = 0.8,
        items = {
            {
                item = 'kuz_rarecoin',
                label = 'Seltene Münze',
                price = 770,
            },
            {
                item = 'kuz_goldcoin',
                label = 'Goldmünze',
                price = 520,
            },
            {
                item = 'kuz_silvercoin',
                label = 'Silbermünze',
                price = 335,
            },
            {
                item = 'kuz_plasmacutter',
                label = 'Schweißgerät',
                price = 1400,
            },
        },
    },
    {
        locations = {
            {
                x = -1095.78,
                y = 4948.48,
                z = 218.35
            },
        },
        name = 'Waffenteilkäufer',
        showOnMap = true,
        useAccount = 'black_money',
        blipIcon = 437,
        blipColor = 64,
        blipScale = 0.7,
        items = {
            {
                item = 'kuz_merryweather',
                label = 'Merryweather Teile',
                price = 2450,
            },
            {
                item = 'kuz_plasmacutter',
                label = 'Underwater plasma cutter',
                price = 2600,
            },
        },
    }
}

-- Locations where the items will spawn which then can be picked up by players
Config.lootLocations = {
    paddleBoat = {
        name = "Tauchspot",
        showOnMap = true,
        x = 2688.0,
        y = -1392.0,
        z = -18.0,
        spotsCount = 100,
        radius = 50,
        loot = {
            {
                item = "kuz_goldcoin",
                chance = 30,
                amount_min = 1,
                amount_max = 1,
            },
            {
                item = "kuz_silvercoin",
                chance = 46,
                amount_min = 1,
                amount_max = 3,
            },
            {
                item = "kuz_pearl",
                chance = 10,
                amount_min = 1,
                amount_max = 1,
            },
            {
                item = "kuz_rarecoin",
                chance = 8,
                amount_min = 1,
                amount_max = 2,
            },
            {
                item = "kuz_plasmacutter",
                chance = 6,
                amount_min = 1,
                amount_max = 1,
            },
        },
        models = {
            "prop_luggage_07a",
        }
    },
    airliner = {
        name = "Tauchspot",
        showOnMap = true,
        x = -934.0,
        y = 6670.0,
        z = -27.0,
        spotsCount = 150,
        radius = 70,
        loot = {
            {
                item = "kuz_goldcoin",
                chance = 10,
                amount_min = 1,
                amount_max = 1,
            },
            {
                item = "kuz_silvercoin",
                chance = 30,
                amount_min = 1,
                amount_max = 2,
            },
            {
                item = "kuz_jewelry",
                chance = 12,
                amount_min = 1,
                amount_max = 1,
            },
			{
                item = "kuz_rarecoin",
                chance = 8,
                amount_min = 1,
                amount_max = 2,
            },
            {
                item = "kuz_watch",
                chance = 7,
                amount_min = 1,
                amount_max = 1,
            },
        },
        models = {
            "prop_luggage_07a",
        }
    },
    cargoShip = {
        name = "Tauchspot",
        showOnMap = false,
        requireItem = 'kuz_plasmacutter',
        animationDict = 'Scenario',
        animation = 'WORLD_HUMAN_WELDING',
        x = 3168.0,
        y = -316.0,
        z = -11.0,
        spotsCount = 30,
        radius = 60,
        loot = {
            {
                item = "kuz_merryweather",
                chance = 45,
                amount_min = 1,
                amount_max = 2,
            },
        },
        models = {
            "sum_ac_prop_container_01a",
        }
    }
}
