rs('tofdrugs:configsrv', function()
    configloaddgs = false
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------
-------------- general parameters -----------------
---------------------------------------------------
Options =  {}
Options.Debug = false                -- Config here the debug mode (true | false)
Options.afkf = false     -- config if the afk farm is allow (true | false)
Options.inventory = 'default'-- config your inventory here (oxinventory | default)
Options.oxtarget = false         -- config if you want to use oxtarget

Options.mincopsh = 0                -- config here the minimum number of cops to harvest
Options.mincopsc = 3                -- config here the minimum number of cops to craft
Options.mincopss = 0                -- config here the minimum number of cops to sell to narcos
Options.mincopsnpc = 0              -- config here the minimum number of cops to sell to npc

Options.alertlspdw = 20             -- config here the % of chance that cops will be alerted when there's wholesale sell
Options.alertlspdnpc = 20           -- config here the % of chance that cops will be alerted when there's npc sell
Options.delayblip = 10           -- config here the delay of the blip lspd when there' npc sell

Options.nonpc = 20                  -- config here the % of chance that npc refuse a sell

---------------------------------------------------------- WebHook --------------------------------------------------------
-- it is advisable to create your webhooks on a discord different from the main discord
-- webhook cheat = webhook with information needed to ban offline a cheater (triggers research etc.)
-- webhook stats = to let you know where is illegal on your server. When a player disconnects, global stats for manufacturing,
-- processing, sales, etc. on your discord (can also be useful for refunds etc.)
---------------------------------------------------------------------------------------------------------------------------

Options.webhook = true
Options.webhookcheat = 'https://discord.com/api/webhooks/1032008050942414882/bJRFpjpJ3V9cXLaNPfjS9IKKdn5n8Xh-HFB55w8_RTmvQlnuwHPoTjyxgsNGmlqVWMgV'
Options.webhookstat = 'https://discord.com/api/webhooks/1032008189723557968/4L7pkgZKDc1DE6sEyOV9KQz9kzsalTqlfRvk77B4h2TPPja2wB7rCNpHdvios93D5dew'

-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- config harvest items -------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

drugsharvest = {
    ------------------------------------------------------------------------- Weed ------------------------------------------------------------------
    {item = 'highgradefemaleseed', label = 'Weedsamen', qty = 1, timer = 10000, coord = {x = 2225.44, y = 5577.22, z = 53.83, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act = 'harvest'},
    ------------------------------------------------------------------------- Opium -----------------------------------------------------------------
--    {item = 'drug_opium', label = 'Opium', qty = 6, timer = 3000, coord = {x = -94.01, y = 2893.87, z = 51.58, h = 167.244}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    ------------------------------------------------------------------------- Lean ------------------------------------------------------------------
    {item = 'codeine', label = 'Codein', qty = 2, timer = 8000, coord = {x = 157.16, y = 6657.42, z = 31.56, h = 65.196}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    {item = 'ice', label = 'Ice', qty = 4, timer = 3000, coord = {x = 957.87, y = -2127.55, z = 31.46, h = 65.196}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    ----------------------------------------------------------------------- Cocaine -----------------------------------------------------------------
    {item = 'koksblatt', label = 'Koks Blatt', qty = 8, timer = 8000, coord = {x = 829.29, y = 1305.26, z = 364.02, h = 208.19}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    {item = 'benzin', label = 'Benzin', qty = 8, timer = 8000, coord = {x = -355.92, y = -1486.67, z = 30.19, h = 270.56}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    --------------------------------------------------------------------- LSD / Ecstasy --------------------------------------------------------------
    {item = 'hydrogen', label = 'Hydrogen', qty = 2, timer = 8000, coord = {x = 561.26, y = -485.30, z = 24.98, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    {item = 'oxygen', label = 'Oxygen', qty = 3, timer = 8000, coord = {x = 1665.89, y = 2.88, z = 166.12, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
    {item = 'nitrogen', label = 'Nitrogen', qty = 2, timer = 8000, coord = {x = -190.13, y = 6067.82, z = 31.38, h = 104.881}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
     ------------------------------------------------------------------------ Meth -------------------------------------------------------------------
     {item = 'carbon', label = 'Carbon', qty = 2, timer = 8000, coord = {x = 2675.7, y = 3499.38, z = 54.30, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
     {item = 'sodium_hydroxide', label = 'Sodium Hydroxide', qty = 2, timer = 8000, coord = {x = 3538.20, y = 3660.09, z = 28.12, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
     --{item = 'pseudoefedrine', label = 'pseudoefedrine', qty = 8, timer = 300, coord = {x = 249.41, y = -1374.78, z = 39.53, h = 221.103}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
     -------------------------------------------------------------------------------------------------------------------------------------------------
      ------------------------------------------------------------------------ Heroin -------------------------------------------------------------------
      {item = 'schlafmohn', label = 'Schlafmohn', qty = 2, timer = 300, coord = {x = 4879.78, y = -5101.16, z = 2.42, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='harvest'},
      -------------------------------------------------------------------------------------------------------------------------------------------------
}

-------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- config craft labos -------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

drugscraft = {
    ------------------------------------------------------------------------ Lean -------------------------------------------------------------------
    {item = 'drug_lean', label = 'Lean', timer = 8000, coord = {x = -1363.08, y = -756.03, z = 22.31, h = 274.960}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    ----------------------------------------------------------------------- Cocaine -----------------------------------------------------------------
    {item = 'coke', label = 'Koks', timer = 8000, coord = {x = 1091.74, y = -3196.88, z = -38.99, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    {item = 'coke_pooch', label = 'Koks Päckchen', timer = 600, coord = {x = 1100.71, y = -3198.73, z = -38.99, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    ----------------------------------------------------------------------- LSD ---------------------------------------------------------------------
    {item = 'drug_lsd', label = 'LSD', timer = 8000, coord = {x = 92.9, y = 3755.4, z = 40.77, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    ------------------------------------------------------------------- Ecstasy ---------------------------------------------------------------------
   -- {item = 'drug_ecstasy', label = 'Ecstasy', timer = 30000, coord = {x = 2329.04, y = 2571.28, z = 46.68, h = 0.00}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    ------------------------------------------------------------------- Meth ---------------------------------------------------------------------
    {item = 'drug_meth', label = 'Methamphetamine', timer = 30000, coord = {x = 1009.65, y = -3194.97, z = -38.99, h = 11.338}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    ---------------------------------------------------------------------Heroin----------------------------------------------------------------------------
    {item = 'rohopium', label = 'Rohopium', timer = 30000, coord = {x = -1563.86, y = -3235.56, z = 26.34, h = 11.338}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    {item = 'morphin', label = 'Morphin', timer = 30000, coord = {x = -588.98, y = -1620.25, z = 33.01, h = 11.338}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
    {item = 'heroin', label = 'Heroin', timer = 30000, coord = {x = 722.55, y = 4189.35, z = 41.09, h = 11.338}, ped = false, type = 'a_m_m_rurmeth_01', marker = 31, act ='craft'},
}

-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- config craft recipes -------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

drugscraftrecipes = {
    ------------------------------------------------------------------------ Lean -------------------------------------------------------------------
    {item = 'drug_lean', label = 'Lean', qtyfinal = 2, item1 = 'applejuice', item2 = 'codeine', item3 = 'ice', item4 = '', item5 = '', item6 = '', qty1 = 2, qty2 = 4, qty3 = 4, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    ----------------------------------------------------------------------- Cocaine -----------------------------------------------------------------
    {item = 'coke', label = 'Koks', qtyfinal = 4, item1 = 'koksblatt', item2 = 'benzin', item3 = '', item4 = '', item5 = '', item6 = '', qty1 = 4, qty2 = 2, qty3 = 0, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    {item = 'coke_pooch', label = 'Koks Päckchen', qtyfinal = 1, item1 = 'coke', item2 = '', item3 = '', item4 = '', item5 = '', item6 = '', qty1 = 2, qty2 = 0, qty3 = 0, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    ----------------------------------------------------------------------- LSD ---------------------------------------------------------------------
    {item = 'drug_lsd', label = 'LSD', qtyfinal = 3, item1 = '', item2 = 'hydrogen', item3 = 'oxygen', item4 = 'nitrogen', item5 = '', item6 = '', qty1 = 0, qty2 = 3, qty3 = 2, qty4 = 4, qty5 = 0, qty6 = 0, act ='craft'},
    -------------------------------------------------------------------- Ecstasy --------------------------------------------------------------------
    --{item = 'drug_ecstasy', label = 'Ecstasy', qtyfinal = 6, item1 = 'carbon', item2 = 'hydrogen', item3 = 'oxygen', item4 = 'nitrogen', item5 = 'jolly_ranchers', item6 ='', qty1 = 6, qty2 = 6, qty3 = 6, qty4 = 6, qty5 = 6, qty6 = 0, act ='craft'},
    ---------------------------------------------------------------------- Meth ---------------------------------------------------------------------
    {item = 'drug_meth', label = 'Meth', qtyfinal = 3, item1 = 'carbon', item2 = 'sodium_hydroxide', item3 = 'pseudoefedrine', item4 = '', item5 = 's', item6 = '', qty1 = 2, qty2 = 4, qty3 = 3, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    ------------------------------------------------------------------------Heroin-------------------------------------------------------------------------
    {item = 'rohopium', label = 'Rohopium', qtyfinal = 1, item1 = 'schlafmohn', item2 = '', item3 = '', item4 = '', item5 = 's', item6 = '', qty1 = 3, qty2 = 0, qty3 = 0, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    {item = 'morphin', label = 'Morphin', qtyfinal = 1, item1 = 'rohopium', item2 = '', item3 = '', item4 = '', item5 = 's', item6 = '', qty1 = 3, qty2 = 0, qty3 = 0, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},
    {item = 'heroin', label = 'Heroin', qtyfinal = 1, item1 = 'morphin', item2 = 'essigsaure', item3 = '', item4 = '', item5 = 's', item6 = '', qty1 = 3, qty2 = 2, qty3 = 0, qty4 = 0, qty5 = 0, qty6 = 0, act ='craft'},

}   

-------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- config sell items --------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

drugssellnarcos = {
    ------------------------------------------------------------------------ Weed -------------------------------------------------------------------
    {item = 'weed_pooch', label = 'Weed', pricemin = 1300, pricemax = 1600, qtysell = 5, timer = 8000, coord = {x = -1691.27, y = -1071.257, z = 1.831, h = 141.732}, ped = true, type = 'a_m_m_og_boss_01', marker = 31, act ='sell'},
    {item = 'weedjoint', label = 'Weed', pricemin = 1450, pricemax = 1850, qtysell = 5, timer = 8000, coord = {x = -1611.03, y = -1046.23, z = 5.95, h = 131.31}, ped = true, type = 'a_m_m_og_boss_01', marker = 31, act ='sell'},
    ----------------------------------------------------------------------- Opium -------------------------------------------------------------------
   -- {item = 'drug_opium', label = 'Opium', pricemin = 50, pricemax = 60, qtysell = 100, timer = 3000, coord = {x = -298.852, y = -2768.716, z = 2.185, h = 320.314}, ped = true, type = 'a_m_o_salton_01', marker = 31, act ='sell'},
    ----------------------------------------------------------------------- Lean ---------------------------------------------------------------------
    {item = 'drug_lean', label = 'Lean', pricemin = 2050, pricemax = 2450, qtysell = 5, timer = 8000, coord = {x = 1554.197, y = -2710.193, z = 3.88, h = 124.724}, ped = true, type = 'a_m_y_genstreet_01', marker = 31, act ='sell'},
    ---------------------------------------------------------------------- Cocaine -------------------------------------------------------------------
    {item = 'coke_pooch', label = 'Koks', pricemin = 1650, pricemax = 1870, qtysell = 5, timer = 8000, coord = {x = 2771.36, y = -737.97, z = 9.09, h = 377.2}, ped = true, type = 'a_m_y_genstreet_01', marker = 31, act ='sell'},
    -------------------------------------------------------------------------- LSD -------------------------------------------------------------------
    {item = 'drug_lsd', label = 'LSD', pricemin = 2450, pricemax = 2830, qtysell = 5, timer = 8000, coord = {x = 3760.839, y = 4580.545, z = 3.516, h = 256.118}, ped = true, type = 'a_m_y_genstreet_01', marker = 31, act ='sell'},
    ---------------------------------------------------------------------- Ecstasy -------------------------------------------------------------------
   -- {item = 'drug_ecstasy', label = 'Ecstasy', pricemin = 300, pricemax = 360, qtysell = 100, timer = 3000, coord = {x = 1579.305, y = 6663.046, z = 2.792, h = 59.527}, ped = true, type = 'a_m_y_vindouche_01', marker = 31, act ='sell'},
    -------------------------------------------------------------------------- Meth -------------------------------------------------------------------
    {item = 'drug_meth', label = 'Methamphetamine', pricemin = 3150, pricemax = 3630, qtysell = 5, timer = 8000, coord = {x = -2279.802, y = 4394.320, z = 17.097, h = 79.370}, ped = true, type = 'a_m_y_genstreet_01', marker = 31, act ='sell'},
    -------------------------------------------------------------------------Heroin-------------------------------------------------------------------------
    {item = 'heroin', label = 'Heroin', pricemin = 3500, pricemax = 3750, qtysell = 5, timer = 8000, coord = {x = -2615.84, y = 2953.92, z = 9.34, h = 162.76}, ped = true, type = 'a_m_m_og_boss_01', marker = 31, act ='sell'},
}

drugssellNPC = {
    ------------------------------------------------------------------------ Weed -------------------------------------------------------------------
    {item = 'weed_pooch', label = 'Weed', pricemin = 1300, pricemax = 1600, timer = 15000, act ='sellnpc'},
    {item = 'weedjoint', label = 'Weed', pricemin = 1450, pricemax = 1850, timer = 15000, act ='sellnpc'},
    ----------------------------------------------------------------------- Opium -------------------------------------------------------------------
 --   {item = 'drug_opium', label = 'Opium', pricemin = 80, pricemax = 95, timer = 15000, act ='sellnpc'},
    ----------------------------------------------------------------------- Lean ---------------------------------------------------------------------
    {item = 'drug_lean', label = 'Lean', pricemin = 2250, pricemax = 2750, timer = 15000, act ='sellnpc'},
    ---------------------------------------------------------------------- Cocaine -------------------------------------------------------------------
    {item = 'coke_pooch', label = 'Cocaine', pricemin = 1650, pricemax = 1800, timer = 15000, act ='sellnpc'},
    -------------------------------------------------------------------------- LSD -------------------------------------------------------------------
    {item = 'drug_lsd', label = 'LSD', pricemin = 1370, pricemax = 3040, timer = 15000, act ='sellnpc'},
    ---------------------------------------------------------------------- Ecstasy -------------------------------------------------------------------
   -- {item = 'drug_ecstasy', label = 'Ecstasy', pricemin = 650, pricemax = 750, timer = 15000, act ='sellnpc'},
    -------------------------------------------------------------------------- Meth -------------------------------------------------------------------
    {item = 'drug_meth', label = 'Methamphetamine', pricemin = 3070, pricemax = 3750, timer = 15000, act ='sellnpc'},
    --------------------------------------------------------------------------Heroin------------------------------------------------------------------------
    {item = 'heroin', label = 'Heroin', pricemin = 3650, pricemax = 3850, timer = 15000, act ='sellnpc'},
 }

------------------------------------------------------- Interaction NPC ---------------------------------------------------
-- configure here the zones without interactions with the npc
---------------------------------------------------------------------------------------------------------------------------

zonenointeract = {
    {name = 'lspd', coord = {x = 446.6769, y = -984.1450, z = 30.6783}, radius = 30},
    {name = 'hospital', coord = {x = 341.4593, y = -1397.6702, z = 32.4981}, radius = 100},
}


---------------------------------------------------- Teleport functions ---------------------------------------------------
-- configure here zones of teleportation
-- entdepart => starting point for entry -------- entarriv => arrival point for entry
-- exitdepart => starting point for exit -------- exitarriv => arrival point for exit
-- ==> DO NOT OVERLAP THE POINTS
---------------------------------------------------------------------------------------------------------------------------

Options.teleport = true                 -- (true | false)

tppoints = {
    ---------------------------------------------------------------------------------------------------------------------------
    {zone = 'zone1', entdepart = {x= 723.38,y=-697.98,z=27.54}, entarriv = {x=998.64,y=-3195.60,z=-38.39}, exitdepart = {x=996.82,y=-3200.56,z=-37.39}, exitarriv = {x=723.41,y=-706.36,z=25.73}},
    ---------------------------------------------------------------------------------------------------------------------------
    {zone = 'zone2', entdepart = {x=1207.47,y=-3122.56,z=4.54}, entarriv = {x=1088.69,y=-3191.37,z=-39.99}, exitdepart = {x=1088.68,y=-3187.56,z=-39.99}, exitarriv = {x=1203.04,y=-3119.71,z=4.54}},
    ---------------------------------------------------------------------------------------------------------------------------
 }

---------------------------------------------------------------------------------------------------------------------------
-- configure here if you want the script manage the item's script in DB, so you will modify here the field of these items
-- and the script manage the update and the creation of these items in your database.
-- ** the database must contain at least fields : 'name' - 'label' - 'weight' **
---------------------------------------------------------------------------------------------------------------------------
-- if you use ox_inventory, the tremendous work of the overextended team means that the ox_inventory will automatically
-- download new items added to the db into the items.lua file.
---------------------------------------------------------------------------------------------------------------------------

Options.ManageDB = false     -- (true | false)

itemstocreate = {
    -------------------------------------------------------------------- Items BDD -------------------------------------------------------------------
    {name = 'drug_cannabis', label = 'Weed', weight = 100},
    {name = 'drug_opium', label = 'Opium', weight = 100},
    {name = 'drug_lean', label = 'Lean', weight = 100},
    {name = 'drug_cocaine', label = 'Cocaine', weight = 100},
    {name = 'drug_lsd', label = 'LSD', weight = 100},
    {name = 'drug_ecstasy', label = 'Ecstasy', weight = 50},
    {name = 'drug_meth', label = 'Methamphetamine', weight = 100},
    {name = 'codein', label = 'Codeine', weight = 50},
    {name = 'ice', label = 'ice', weight = 50},
    {name = 'drink_sprunk', label = 'Sprunk', weight = 50},
    {name = 'cocaleaves', label = 'Coca Leaves', weight = 50},
    {name = 'gasoline', label = 'Gasoline', weight = 50},
    {name = 'solvent', label = 'Solvent', weight = 50},
    {name = 'carbon', label = 'Carbon', weight = 50},
    {name = 'hydrogen', label = 'Hydrogen', weight = 50},
    {name = 'oxygen', label = 'Oxygen', weight = 50},
    {name = 'nitrogen', label = 'Nitrogen', weight = 50},
    {name = 'jolly_ranchers', label = 'Jolly ranchers', weight = 50},
    {name = 'red_sulfur', label = 'Red sulfur', weight = 50},
    {name = 'liquid_sulfur', label = 'Liquid sulfur', weight = 50},
    {name = 'muriatic_acid', label = 'Muriatic acid', weight = 50},
    {name = 'ammonium_nitrate', label = 'Ammonium nitrate', weight = 50},
    {name = 'sodium_hydroxide', label = 'Sodium hydroxide', weight = 50},
    {name = 'pseudoefedrine', label = 'Pseudoefedrine', weight = 50},
    --------------------------------------------------------------------------------------------------------------------------------------------------
}
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

    configloaddgs = true
    print('^2[CONFIG]^7 Drugs Config Loaded ServeR SidE ')
    if Options.ManageDB == true then
        te('tofdrugs:verifitemsbdd') 
    end
end)