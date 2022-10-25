Config = {}

Config.Locale = "de"

Config.DPhone = true -- Enable this if youre using d-phone
Config.Debug = false

Config.hourplus = 1

Config.Key = 20

Config.item = "mininglaptop"

Config.ESX = {
    Legacy = false, -- Legacy is ESX 1.2, so if you're using it enable it
    getSharedObjectevent = 'esx:getSharedObject',
    esxprefix = "esx:",
    prefix2 = "esx_",
}

-- WARNING DONT DISABLE THIS IF YOU DONT EXACTLY KNOW WHAT YOU'RE DOING
Config.AutomaticLoadUserData = true
Config.AutomaticStartingTime = 60000

Config.Bitcoin = {
    standard = 5000,
    pricecap = {
        min = 100,
        max = 15000,
    },
    newpricerange = {
        min = 95,
        max = 105
    },
    -- 1 = 1 minute
    saverhytmus = 5,
}

-- Delets old data automatically after x days
Config.DeleteDays = 2

-- Multiplay the miningrate to get the amount of bitcoin
Config.miningrateminmultiply = 1
Config.miningratemaxmultiply = 99
Config.divisionthrough = 100000

-- How often the user should get the mining earnings ( 1 = 1 minute )
Config.miningminrhytmus =  3
Config.miningminrhytmus =  8

Config.StandardEquipment = {
    GPU = "aradeonrx580",
    CPU = "ipg6400",
    RAM = "4gb2400"
}

Config.Equipment = {
    GPU = {
        {
            name = "ia107gb",
            label = "Innosilicon A10 7GB",
            miningrate = 720,
            price = 20
        },
        {
            name = "ia106gb",
            label = "Innosilicon A10 6GB",
            miningrate = 500,
            price = 15
        },
        {
            name = "na100",
            label = "A100",
            miningrate = 400,
            price = 12
        },
        {
            name = "nrtx3090",
            label = "RTX 3090",
            miningrate = 350,
            price = 10
        },
        {
            name = "aradeon8",
            label = "Radeon VII",
            miningrate = 325,
            price = 8
        },
        {
            name = "nrtx3080",
            label = "RTX 3080",
            miningrate = 300,
            price = 7.5
        },
 
        {
            name = "aradeonrx6900",
            label = "Radeon RX 6900 XT",
            miningrate = 250,
            price = 7
        },
        {
            name = "nrtx3070",
            label = "RTX 3070",
            miningrate = 225,
            price = 6.5
        },
        {
            name = "aradeonrx6800",
            label = "Radeon RX 6800 XT",
            miningrate = 200,
            price = 6
        },
        {
            name = "nrtx3060",
            label = "RTX 3060",
            miningrate = 150,
            price = 5
        },
        {
            name = "nrtx2070",
            label = "RTX 2070",
            miningrate = 125,
            price = 5
        },
        {
            name = "aradeonrx5700",
            label = "Radeon RX 5700",
            miningrate = 100,
            price = 3
        },
        {
            name = "aradeonrx5600",
            label = "Radeon RX 5600",
            miningrate = 75,
            price = 2
        },
        {
            name = "aradeonrx580",
            label = "Radeon RX 580",
            miningrate = 50,
            price = 1
        },
    },
    CPU = {
        {
            name = "amdt3970x",
            label = "Ryzen Threadripper 3970X",
            miningrate = 500,
            price = 20
        },
        {
            name = "amdt3960x",
            label = "Ryzen Threadripper 3960X",
            miningrate = 400,
            price = 15
        },
        {
            name = "ii910900x",
            label = "Core i9-10900X",
            miningrate = 300,
            price = 10
        },
        {
            name = "amdryzen93950x",
            label = "Ryzen 9 3950X",
            miningrate = 200,
            price = 5
        },
        {
            name = "amdryzen53600x",
            label = "Ryzen 5 3600X",
            miningrate = 100,
            price = 2
        },
        {
            name = "ipg6400",
            label = "Pentium Gold G-6400",
            miningrate = 25,
            price = 0.25
        },
    },
    RAM = {
        {
            name = "32gb6400",
            label = "32GB DDR5 6400",
            miningrate = 200,
            price = 20
        },
        {
            name = "64gb3200",
            label = "64GB DDR4 3200",
            miningrate = 100,
            price = 8
        },
        {
            name = "32gb3200",
            label = "32GB DDR4 3200",
            miningrate = 60,
            price = 4
        },
        {
            name = "32gb2400",
            label = "32GB DDR4 2400",
            miningrate = 40,
            price = 2
        },
        {
            name = "16gb3200",
            label = "16GB DDR4 3200",
            miningrate = 35,
            price = 1.75
        },
        {
            name = "16gb2400",
            label = "16GB DDR4 2400",
            miningrate = 20,
            price = 1
        },
        {
            name = "8gb3200",
            label = "8GB DDR4 3200",
            miningrate = 15,
            price = 0.75
        },
        {
            name = "8gb2400",
            label = "8GB DDR4 2400",
            miningrate = 10,
            price = 0.5
        },
        {
            name = "4gb2400",
            label = "4GB DDR4 2400",
            miningrate = 5,
            price = 0.25
        },
    },
}

Config.TranactionShops = {
    {
        name = "shop",
        locale = _U("shop")
    },
    {
        name = "market",
        locale = _U("hmarket")
    }
}

-- WaitingTimes
Config.Transactionlimit = 1000

Config.FirstTimeSQL = 500
Config.MysqlWaitingTime = 500

-- Fontawesome Icons for the Notification
Config.Home = "fa-solid fa-house"
Config.Mining = "fas fa-microchip"
Config.Shop = "fas fa-shopping-cart"
Config.Market = "fab fa-bitcoin"
Config.Tranferi = "fa-solid fa-arrow-right-from-bracket"
Config.Tranfero = "fa-solid fa-arrow-left-from-bracket"
Config.Error = "fa-solid fa-triangle-exclamation"