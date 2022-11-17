Config = {}
Translation = {}

Config.Locale = 'de'

Config.NotificationPicture = 'CHAR_MANUEL'

Config.EnableBuyOption = true -- Should players be able to sell items at the shop
Config.PriceBuyDivide = 2 -- Sell price / this value = buy price
Config.useWeightSystem = true

Config.disablePeds = true -- should shop npcs be disabled?
Config.showMarker = false -- should there be markers on the ground

Config.Shops = {

    {requiredJob = 'mechanic', type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =372.48, y =326.74, z =103.57, rot = 240.0},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x = 2556.94, y = 380.71, z = 108.62, rot = 342.38},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-3039.04, y =584.18, z =7.91, rot = 357.0},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-3242.54, y = 999.74, z =12.830, rot = 336.15},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =549.25, y =2671.34, z =42.156, rot = 82.59},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1959.97, y =3739.96, z =32.34, rot = 288.98},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =2677.51, y =3279.49, z =55.241, rot = 303.4},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1727.91, y =6415.52, z =35.04, rot = 214.3},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1134.12, y =-982.77, z =46.42, rot = 279.46},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-1222.16, y =-908.53, z =12.33, rot = 23.5},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-1486.21, y =-377.92, z =40.163, rot = 126.46},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-2966.28, y =390.67, z =15.043, rot = 85.91},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1166.14, y =2710.830, z =38.157, rot = 168.31},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1392.69, y =3606.548, z =34.980, rot = 186.81},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-47.08, y =-1758.46, z =29.421, rot = 53.42},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1164.883, y =-323.38, z =69.21, rot = 106.81},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-705.9601, y =-914.250, z = 19.215, rot = 110.24},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-1819.8, y =793.92, z =138.09, rot = 154.0},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1697.65, y =4923.14, z = 42.063, rot = 352.85},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =4466.86, y =-4463.28, z = 4.3, rot = 207.02},
    {type = "shop", name = "Shop", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =373.92, y =326.35, z = 103.57, rot = 271.02},   
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=810.1583, y=-2157.745, z=29.61682, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=2567.842, y=293.9473, z=108.7267, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=-1117.952, y=2698.853, z=18.54651, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=-3172.312, y=1088.083, z=20.83813, rot = 251.7},
    --{type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=-662.1099, y=-935.2879, z=21.81543, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=252.211, y=-50.14945, z=69.93848, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=1693.661, y=3760.035, z=34.6886, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=-331.39, y=6085.85, z=31.45349, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=842.3077, y=-1033.754, z=28.18457, rot = 251.7},
    {type = "ammunation", name= "Ammunation", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= 110, color = 8, x=23.18242, y=-1105.451, z=29.7854, rot = 158.7402},

    {type = "juwe", name= "Juwelier", pedmodel = "csb_anita", banner = "shopui_title_highendsalon", blip= 617, color = 46, x=-623.512085,y= -230.175812,z= 38.041748,rot = 121.889763},

	--  {type = "digitalden", name= "DigitalDen", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 459, color = 19, x=-657.0, y=-857.1, z=23.5, rot = 180.0},

}

Config.ShopItems = {
    ['shop'] = {
        {label = "Wasser", name = "water", price = 80, max = 80},
        {label = "Brot", name = "bread", price = 100, max = 100},
        {label = "Dünger", name = "fertilizer", price = 100, max = 5},
        {label = "Handy", name = "phone", price = 5000, max = 500},
        {label = "Drehpapier", name = "paper", price = 10, max = 8},
        {label = "Öl&Reifen Flickset", name = "repairkit", price = 3000, max = 1000},
        {label = "Verbände", name = "bandage", price = 10000, max = 1},
        {label = "Rubbellos", name = "scratch_ticket", price = 8000, max = 7000},
        {label = "Spray", name = "spray", price = 5500, max = 5000},
        {label = "Spray Remover", name = "spray_remover", price = 2500, max = 2000},
        {label = "Tüte", name = "headbag", price = 4000, max = 4000},
        {label = "Tablet", name = "tablet", price = 15000, max = 15000},
        {label = "Lappen", name = "lappen", price = 1500, max = 1500},
        {label = "Eis", name = "ice", price = 50, max = 50},
        {label = "Lockpick", name = "lockpick", price = 250, max = 250},
       -- {label = "Batterie", name = "battery", price = 100, max = 250},
       -- {label = "powerbank", name = "Powerbank", price = 70, max = 250},
    },
   --[[ ['bar'] = {
        {label = "Beer", name = "beer", price = 30, max = 100},
        {label = "Wine", name = "wine", price = 200, max = 100},
        {label = "Vodka", name = "vodka", price = 50, max = 100},
        {label = "Whiskey", name = "whisky", price = 50, max = 100}
    },]]--
    ['ammunation'] = {
        {type = 'weapon', label = "Pistole", name = "WEAPON_PISTOL", price = 85000, max = 1},
        {type = 'weapon', label = "Taschenlampe", name = "WEAPON_FLASHLIGHT", price = 40000, max = 1},
        {type = 'weapon', label = "Baseballschläger", name = "WEAPON_BAT", price = 65000, max = 1},
        {label = "Magazin", name = "weabox", price = 1000, max = 20},
        {label = "Fernglas", name = "binocular", price = 3500, max = 2000},
        {type= 'weapon', label = "Pfefferspray", name = "WEAPON_PEPPERSPRAY", price = 35000, max = 1},
        {type= 'weapon', label = "Gegenmittel", name = "WEAPON_ANTIDOTE", price = 10000, max = 1},
    },

    ['juwe'] = {
        {label = "Ehering", name = "ehering", price = 5000000, max = 2},
    }

}

Translation = {
    ['de'] = {
        ['infobar_interact'] = 'Drücke ~g~E~s~, um einzukaufen',
        ['buy'] = '~g~Kaufen',
        ['sell'] = '~r~Verkaufen',
        ['how_much'] = 'Wieviel darfs sein?',
        ['how_much_sell'] = 'Wieviel?',
        ['purchased'] = '~g~',
        ['purchased2'] = 'x ',
        ['purchased3'] = ' ~s~für ~g~',
        ['purchased4'] = '$ ~s~gekauft!',
        ['sold'] = '~o~',
        ['sold2'] = 'x ',
        ['sold3'] = ' ~s~für ~o~',
        ['sold4'] = '$ ~s~verkauft!',
        ['shop'] = 'Geschäft',
        ['purchased_title'] = 'Gegenstand gekauft!',
        ['sold_title'] = 'Gegenstand verkauft!',
        ['can_not_carry'] = '~r~Du kannst nicht so viel tragen!',
        ['not_enough_money'] = 'Du hast nicht genügend Geld!',
        ['not_enough_items'] = '~r~Du hast nicht so viel dabei!',
    },

    ['en'] = {
        ['infobar_interact'] = 'Press ~g~E~s~, to buy items',
        ['buy'] = '~g~Buy',
        ['sell'] = '~r~Sell',
        ['how_much'] = 'How much?',
        ['how_much_sell'] = 'How much?',
        ['purchased'] = '~g~',
        ['purchased2'] = 'x ',
        ['purchased3'] = ' ~s~purchased for ~g~',
        ['purchased4'] = '$~s~!',
        ['sold'] = '~o~',
        ['sold2'] = 'x ',
        ['sold3'] = ' ~s~sold for ~o~',
        ['sold4'] = '$~s~!',
        ['shop'] = 'Shop',
        ['purchased_title'] = 'Item purchased!',
        ['sold_title'] = 'Item sold!',
        ['can_not_carry'] = '~r~You can not carry that much!',
        ['not_enough_money'] = 'You do not have enough money!',
        ['not_enough_items'] = '~r~You do not have enough items!',
    },
}