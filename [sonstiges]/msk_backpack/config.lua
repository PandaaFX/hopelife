Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = false
----------------------------------------------------------------
Config.ItemsInBag = true -- Set true if you want that players cant use 'nobag' Item if there are Items in the Bag

-- Expand the Inventory Space of the Player // Opens a Secondary Inventory by typing /openbag Command
Config.BagInventory = 'expand' -- 'expand' or 'secondary'

-- If set to true go to client.lua and change the IDs to what you set in esx_parachute
Config.useParachute = false -- Set true if you use my esx_parchute Script

Config.Animations = {
    dict = 'clothingtie',
    anim = 'try_tie_neutral_a',
    time = 2 -- in seconds (default: 2 seconds)
}
----------------------------------------------------------------
Config.Backpacks = {
    ['bagpack'] = { -- Item // Add this to your database
        skin = {
            male = {skin1 = 4, skin2 = 0},
            female = {skin1 = 22, skin2 = 0}
        },
        weight = 100,
    },
    ['bagpack2'] = { -- Item // Add this to your database
        skin = {
            male = {skin1 = 30, skin2 = 0},
            female = {skin1 = 102, skin2 = 0}
        },
        weight = 400,
    },
}