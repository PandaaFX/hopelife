Config = {}

Config.Options = {
    MenuAlign = "top-left", -- where the menus are aligned (esx_menu_default)
    MainAction = 51, -- where all keys are "E" by default, remember to change the control in language.lua so it corresponds with this
    SecondaryAction = 47, -- where all the keys are "G" by default, remember to change the control in language.lua so it corresponds with this
    Inventory = "default", -- what inventory you use, valid options: 
    --[[
        default (menu based)
        modfreakz (MF inventory: https://modit.store/products/mf-inventory?variant=39985142268087) PAID
        linden (linden_inventory: https://github.com/thelindat/linden_inventory) FREE, I RECOMMEND THIS
        ox_inventory (https://github.com/overextended/ox_inventory) FREE, VERY GOOD
    --]]
    Stripper = {
        Enabled = true, -- allow people to pole dance & lap dance?
        PoleDancing = true, -- allow people to pole dance?
        LapDance = true, -- allow people to lapdance?
        Zigarreten = true,
    },

    
}

Config.useWeightSystem = true