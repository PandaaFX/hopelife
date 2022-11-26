
Config = {}
Config.Framework = 'esx' -- esx - oldqb - newqb
Config.Mysql = 'mysql-async' -- mysql-async, ghmattimysql, oxmysql
Config.DefaultImage = 'https://cdn.discordapp.com/attachments/983471660684423240/1018885207358705674/defaultimage.png'
Config.MenuOpenKey = 38  -- [E] Keys Reference : https://docs.fivem.net/docs/game-references/controls/
Config.CancelKey = 120 -- [X] Keys Reference : https://docs.fivem.net/docs/game-references/controls/
Config.UseBotToken = true
Config.BotToken = "ODg3MDcwNDkxOTA5Njg1MjU5.Gj_vYu.lcFBhuPcDhunYZuPCjDWygaFmfhqj0VLwGXzXM"
Config.EnableAFKMode = true
Config.DatabaseName = "codem-fishing"
Config.DatabaseRewardName = "codem-fishing-rewards"

Config.Fish = {
    -- COMMON CATEGORY
    {itemname = 'fish',                  xp = 10, name = 'Alter Fisch',               sell = true, category = 'common',   price = 500},
    {itemname = 'bluegill',              xp = 10, name = 'Bluegill',                  sell = true, category = 'common',   price = 1000},
    {itemname = 'goldentrout',           xp = 15, name = 'Golden Trout',              sell = true, category = 'common',   price = 1000},
    {itemname = 'silverymonnow',         xp = 25, name = 'Silvery Monnow',            sell = true, category = 'common',   price = 1000},
    {itemname = 'strippedbass',          xp = 13, name = 'Stripped Bass',             sell = true, category = 'common',   price = 1000},
    {itemname = 'tench',                 xp = 16, name = 'Tench',                     sell = true, category = 'common',   price = 1000},
    {itemname = 'whitefish',             xp = 5, name = 'White Fish',                sell = true, category = 'common',   price = 1000},
    {itemname = 'crappie',               xp = 13, name = 'Crappie',                   sell = true, category = 'common',   price = 1000},
    {itemname = 'cruciancarp',           xp = 12, name = 'Crucian Carp',              sell = true, category = 'common',   price = 1000},
    -- UNCOMMON CATEGORY--------------   ------------------------------        ---------------------
    {itemname = 'bluebackherring',       xp = 20, name = 'Blueback Herring',         sell = true, category = "uncommon", price = 1500},
    {itemname = 'bulltrout',             xp = 30, name = 'Bull Trout',               sell = true, category = "uncommon", price = 1500},
    {itemname = 'laketrout',             xp = 25, name = 'Lake Trout',               sell = true, category = "uncommon", price = 1500},
    {itemname = 'perch',                 xp = 25, name = 'Perch',                    sell = true, category = "uncommon", price = 1500},
    {itemname = 'chub',                  xp = 26, name = 'Chub',                     sell = true, category = "uncommon", price = 1500},
    {itemname = 'colorodopikeminnow',    xp = 23, name = 'Colorodo Pike Minnow',     sell = true, category = "uncommon", price = 1500},
    {itemname = 'drumfish',              xp = 18, name = 'Drum Fish',                sell = true, category = "uncommon", price = 1500},
    {itemname = 'wallaye',               xp = 32, name = 'Walleye',                  sell = true, category = "uncommon", price = 1500},
    -- RARE CATEGORY------------------   ------------------------------        ----------------------
    {itemname = 'americanshad',          xp = 50, name = 'American Shad',            sell = true, category = "rare",     price = 2000},
    {itemname = 'palidsturgeon',         xp = 55, name = 'Palid Sturgeon',           sell = true, category = "rare",     price = 2000},
    {itemname = 'pike',                  xp = 48, name = 'Pike',                     sell = true, category = "rare",     price = 2000},
    {itemname = 'blackcrappie',          xp = 42, name = 'Black Crappie',            sell = true, category = "rare",     price = 2000},
    {itemname = 'bream',                 xp = 45, name = 'Bream',                    sell = true, category = "rare",     price = 2000},
    {itemname = 'brooktrout',            xp = 45, name = 'Brook Trout',              sell = true, category = "rare",     price = 2000},
    {itemname = 'shortnosesucker',       xp = 45, name = 'Shortnose Sucker',         sell = true, category = "rare",     price = 2000},
    {itemname = 'smallmouthbass',        xp = 45, name = 'Smallmouth Bass',          sell = true, category = "rare",     price = 2000},
    --LEGENDARY CATEGORY --
    {itemname = 'arowana',               xp = 90, name = 'Arowana',                  sell = true, category = "legendary",price = 2500},
    {itemname = 'sweetfish',             xp = 60, name = 'Sweetfish',                sell = true, category = "legendary",price = 2500},
    {itemname = 'whitebass',             xp = 75, name = 'White Bass',               sell = true, category = "legendary",price = 2500},
    {itemname = 'alabamasturgeon',       xp = 80, name = 'Alabama Sturgeon',         sell = true, category = "legendary",price = 2500},
    --EPIC CATEGORY --
    {itemname = 'lakesturgeon',          xp = 100, name = 'Lake Sturgeon',            sell = true, category = "epic",     price = 3500},
    {itemname = 'koicarpblack',          xp = 120, name = 'Koi Carp Black',           sell = true, category = "epic",     price = 3500},
    {itemname = 'lahontancutthroattrout',xp = 110, name = 'Lahontan Cutthroat Trout', sell = true, category = "epic",     price = 3500},


    --------------------------- BAITS ------------------------                       sell = false  -- do not change
    {itemname = 'spoonlurebait',    baitLevel = 1,  fishQualityScale = {'common'},   sell = false, name = 'Spoon Lure Köder',  category = "baits", price = 5, stars = 1, baitsuse = true},
    {itemname = 'threesidedbait',   baitLevel = 2,  fishQualityScale = {'uncommon'}, sell = false, name = 'Three Sided Köder', category = "baits", price = 7, stars = 2, baitsuse = true},
    {itemname = 'tailfishbait',     baitLevel = 3,  fishQualityScale = {'rare'},     sell = false, name = 'Tail Fish Köder',   category = "baits", price = 10, stars = 3, baitsuse = true},
    {itemname = 'doublehookbait',   baitLevel = 4,  fishQualityScale = {'legendary'},sell = false, name = 'Double Hook Köder', category = "baits", price = 20, stars = 4, baitsuse = true},
    {itemname = 'triplehooksbait',  baitLevel = 5,  fishQualityScale = {'epic'},     sell = false, name = 'Triple Hook Köder', category = "baits", price = 50, stars = 5, baitsuse = true},


    --------------------------- RODS ------------------------                          sell = false  -- do not change
    {itemname = 'woodenrod',       minigameDiff = 'veryHard',  name = 'Holz Angel',        sell = false, category = "rods", price = 30000, stars = 1, minlevel = 10, use = true},
    {itemname = 'slimmaterialrod', minigameDiff = 'hard',      name = 'Angel (Dünn)', sell = false, category = "rods", price = 80000, stars = 2, minlevel = 20, use = true},
    {itemname = 'danishrod',       minigameDiff = 'medium',    name = 'Normale Angel',        sell = false, category = "rods", price = 150000, stars = 3, minlevel = 30, use = true},
    {itemname = 'koidrod',         minigameDiff = 'easy',      name = 'Koiangel',           sell = false, category = "rods", price = 200000,stars = 4, minlevel = 40, use = true},
    {itemname = 'finewood',        minigameDiff = 'veryEasy',  name = 'Spezialangel',      sell = false, category = "rods", price = 500000,stars = 5, minlevel = 50, use = true},
}


Config.RequiredXP = {
    [1] = 500,
    [2] = 500,
    [3] = 500,
    [4] = 500,
    [5] = 500,
    [6] = 500,
    [7] = 500,
    [8] = 500,
    [9] = 500,
    [10] = 1000,
    [11] = 1000,
    [12] = 1000,
    [13] = 1000,
    [14] = 1000,
    [15] = 1000,
    [16] = 1000,
    [17] = 1000,
    [18] = 1000,
    [19] = 1000,
    [20] = 1500,
    [21] = 1500,
    [22] = 1500,
    [23] = 1500,
    [24] = 1500,
    [25] = 1500,
    [26] = 1500,
    [27] = 1500,
    [28] = 1500,
    [29] = 1500,
    [30] = 2500,
    [31] = 2500,
    [32] = 2500,
    [33] = 2500,
    [34] = 2500,
    [35] = 2500,
    [36] = 2500,
    [37] = 2500,
    [38] = 2500,
    [39] = 2500,
    [40] = 2500,
    [41] = 5000,
    [42] = 5000,
    [43] = 5000,
    [44] = 5000,
    [45] = 5000,
    [46] = 5000,
    [47] = 5000,
    [48] = 5000,
    [49] = 5000,
    [50] = 5000,
    [51] = 100000,
    [52] = 100000,
    [53] = 100000,
    [54] = 100000,
    [55] = 100000,
    [56] = 100000,
    [57] = 100000,
    [58] = 100000,
    [59] = 100000,
    [60] = 100000,
}

Config.Draw = {
    ["enabled"]  =  true ,
    ["textmarket"] = '[E] Um den Markt zu Öffnen',
}

Config.FishingRestaurant = {
    ["name"] = "Fishmarkt & Zubehör",
    ["blip"] = {
        ["sprite"] = 628,
        ["color"] = 3
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-1038.4545898438, -1397.0551757813, 4.5),
        ["heading"] = 75.0
    }
}

Config.Spots = {

    {
        id = "del_perro",
        doBlip = true,
        blipName = "Del Perro Pier",
        spotLvlStars = 1,
        bgimage = 'delperro.png',
        requiredLvl = 0,
        coords = vector3(-1847.1, -1250.8, 8.61577),
        location = "Pazifischer Ozean",
        statement = "Der Del Perro Pier befindet sich in Los Santos. Der Hauptzugang befindet sich an der Red Desert Avenue. Der Del Perro Pier ist berühmt für seine frohe und bunte Farbenvielfalt, die gerade während der Nacht, glitzert und die umliegenden Strände erhellt.",
        spotQuality = "Standard",
        afkCatchInMinute = 1,
        fishQualityScale = "Normal",
        fishQualityScaleTable = {'common'},

    },

    {
        id = "chumash",
        doBlip = true,
        blipName = "Chumash Family Pier",
        spotLvlStars = 2,
        bgimage = 'chumash.png',
        requiredLvl = 10,
        coords = vector3(-3427.9, 966.576, 8.34668),

        location = "Alamo See",
        statement = "The Chumash Historic Family Pier befindet sich im Herzen Chumashs und liegt direkt an der Barbareno Road.",
        spotQuality = "Normal",
        afkCatchInMinute = 3,
        fishQualityScale = "Normal - Besser",
        fishQualityScaleTable = {'common', 'uncommon'},

    },

    {
        id = "procopio",
        doBlip = true,
        blipName = "Procopio Beach Pier",
        spotLvlStars = 3,
        bgimage = 'procopio.png',
        requiredLvl = 20,
        coords = vector3(-278.00, 6638.32, 8.61577),

        location = "Alamo See",
        statement = "Procopio Beach ist ein Stand im Norden von Blaine County, östlich von Paleto Bay. Der Pier befindet sich in der nähe vom Great Ocean Highway östlich der Procopio Promenade.",
        spotQuality = "Gut",
        afkCatchInMinute = 4,
        fishQualityScale = "Normal - Selten",
        fishQualityScaleTable = {'common', 'rare'},

    },
    {
        id = "millars",
        doBlip = true,
        blipName = "Millars Fishery",
        spotLvlStars = 4,
        bgimage = 'millars.png',
        requiredLvl = 30,
        coords = vector3(-1612.5, 5262.59, 3.97410),

        location = "Alamo See",
        statement = "Der Pier der Millars Fishery und seine Geschäfte befinden sich an der Nordküste der Alamo-See am westlichen Ende der Ansiedlung Galilee.",
        spotQuality = "Sehr Gut",
        afkCatchInMinute = 4,
        fishQualityScale = "Besser - Selten",
        fishQualityScaleTable = {'uncommon', 'rare'},
    },

    {
        id = "califida",
        doBlip = true,
        blipName = "Califida Rd",
        spotLvlStars = 4.5,
        bgimage = 'califida.png',
        requiredLvl = 40,
        coords = vector3(1298.87, 4216.70, 33.9086),

        location = "Alamo See",
        statement = "Der Alamo See ist der größte See in San Andreas.",
        spotQuality = "Legendär",
        afkCatchInMinute = 5,
        fishQualityScale = "Normal - Legendär",
        fishQualityScaleTable = {'common', 'legendary'},

    },
    {
        id = "whitesea",
        doBlip = true,
        blipName = "White Sea Fishing Spot",
        spotLvlStars = 5,
        bgimage = 'whitesea.png',
        requiredLvl = 50,
        coords = vector3(-1518.7, 1509.42, 111.624),

        location = "Fluss Zancudo",
        statement = "Der White Sea Fishing Spot ist mittig am Tongva Drive im Tongva Valley, Los Santos County direkt an der Mündung die in den Zancudo River verläuft.",
        spotQuality = "Episch",
        afkCatchInMinute = 5,
        fishQualityScale = "Selten - Episch",
        fishQualityScaleTable = {'rare', 'epic'},
    },


}

Config.Achievenments = {
    {
        Achievenmentlvl = 5,
        Achievenmentsname = "Level 5",
        Achievenmentsimage = "xp",
        Achievenmentmoney = 100000,
       

    },
    {
        Achievenmentlvl = 10,
        Achievenmentsname = "Level 10",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
        

    },
    {
        Achievenmentlvl = 15,
        Achievenmentsname = "Level 15",
        Achievenmentsimage = "xp",
        Achievenmentmoney = 500000,
    


    },
    {
        Achievenmentlvl = 20,
        Achievenmentsname = "Level 20",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
 
    },

    {
        Achievenmentlvl = 25,
        Achievenmentsname = "Level 25",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,

    },
    {
        Achievenmentlvl = 30,
        Achievenmentsname = "Level 30",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
  
    },
    {
        Achievenmentlvl = 35,
        Achievenmentsname = "Level 35",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
      
    },
    {
        Achievenmentlvl = 40,
        Achievenmentsname = "Level 40",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
    
    },
    {
        Achievenmentlvl = 45,
        Achievenmentsname = "Level 45",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
   
    },
    {
        Achievenmentlvl = 50,
        Achievenmentsname = "Level 50",
        Achievenmentsimage = "money",
        Achievenmentmoney = 500000,
        
    },
    {
        Achievenmentlvl = 55,
        Achievenmentsname = "Level 50",
        Achievenmentsimage = "money",
        Achievenmentmoney = 1000000,
        
    },
    {
        Achievenmentlvl = 60,
        Achievenmentsname = "Level 50",
        Achievenmentsimage = "money",
        Achievenmentmoney = 1500000,
        
    },
}



Config.Locale = {
    ["WIKI"] = 'WIKI',
    ["BOARD"] = 'BOARD',
    ["MARKET"] = 'MARKT',
    ["SPOTS"] = 'SPOTS',
    ["FISHIN"] = 'FISHIN',
    ["FISHING"] = 'G',
    ["LOCATION"] = 'Orte',
    ["SPOTQUALITY"] = 'Fischqualität',
    ["AFKCATCHMIN"] = 'Beim AFK angeln',
    ["AFKCATCHMINUTE"] = '',
    ["FISHQUALITYSCALE"] = 'Fischqualität',
    ["ENABLEAFKMODE"] = 'AFK Mode an',
    ["CATCHFISH"] = 'FANGE FISCH',
    ["LOWLEVEL"] = 'Low level',
    ["AFKCATCHMIN1MIN"] = 'Beim AFK angeln',
    ["ALL"] = 'Alle',
    ["COMMON"] = 'Normal',
    ["UNCOMMON"] = 'Besser',
    ["RARE"] = 'Selten',
    ["LEGANDARY"] = 'Legendär',
    ["EPIC"] = 'Episch',
    ["RODS"] = 'Angel',
    ["BAITS"] = 'Köder',

    ["CARD"] = 'Inventar',
    ["TOTAL"] = 'Total',
    ["PAYVIACASH"] = 'Zahle Bar',
    ["PAYVIACARD"] = 'Zahle mit Karte',
    ["SELL"] = 'Verkaufen',
    ["BUY"] = 'Kaufen',

    ["DELETETOCARD"] = 'Aus dem Verkauf nehmen',
    ["ADDTOCARD"] = 'Zum Verkauf hinzufügen',
    ["BUYSTUFFS"] = 'Kaufe Equipment',
    ["FROMMARKET"] = 'aus dem Markt',
    ["SELLYOURSTUFF"] = 'Verkaufe',
    ["TOMARKETPLACE"] = 'zum Markt',

    ["MARKLOCATION"] = 'Kartenmarkierung setzen',
    ["CHANGEPROFILE"] = 'Foto ändern',
    ["DISCORDPHOTO"] = 'Discord Profil nutzen',

    ["DELETEPROFILE"] = 'Foto löschen',

    ["ACHIEVEMENTS"] = 'Auszeichnung',
    ["CLAIM"] = 'Claim',
    ["AWARD"] = 'Auszeichnung Erreicht',
    ["ACHIEVEMENTSLOCKED"] = 'Auszeichnung Gesperrt',


    -- Javascript Notify 

    ["ADDBASKET"] = 'In den Warenkorb.',
    ["REMOVEDBASKET"] = 'Aus den Warenkorb.',
    ["PURCHASED"] = 'KAUFEN.',
    ["ENOUGHMONEY"] = 'Nicht genug Geld.',
    ["AWARDS"] = 'Auszeichnung erreicht.',
    ["PHOTO"] = 'Foto Updated',
}



-- spot blip
function spotBlip()
    for k, v in pairs(Config.Spots) do
        if v.doBlip then
            local storeBlip = AddBlipForCoord(v.coords)
            SetBlipSprite(storeBlip, 88)
            SetBlipScale(storeBlip, 0.7)
            SetBlipColour(storeBlip, 3)
            SetBlipAsShortRange(storeBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(storeBlip)
        end
    end
end



Config.Notification = function(message, type, isServer, src)-- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end

Config.Notifications = { -- Notifications
    ["rodtostart"] = {
        message = 'Benutze eine Angel',
        type = "success",
    },
    ["usedbait"] = {
        message = 'Köder benutzt',
        type = "success",
    },
    ["thisspot"] = {
        message = 'Der Köder ist hier UNBRAUCHBAR',
        type = "success",
    },
    ["notwater"] = {
        message = 'Du bist nicht nah genug am Wasser',
        type = "success",
    },

    ["waitingbait"] = {
        message = 'Warte bis etwas anbeißt...',
        type = "success",
    },
    ["waitinginput"] = {
        message = 'Warte...',
        type = "success",
    },
    ["waitingfish"] = {
        message = 'Warte auf den Fisch...',
        type = "success",
    },
    ["youcaught"] = {
        message = 'Du fängst etwas',
        type = "success",
    },
    ["escaped"] = {
        message = 'Fisch ist entkommen',
        type = "success",
    },
    ["fishingrod"] = {
        message = 'Keine Angel.',
        type = "success",
    },
    ["inventory"] = {
        message = 'Inventar-Check.',
        type = "success",
    },
    ["bait"] = {
        message = 'Keine Köder mehr.',
        type = "success",
    },
    ["checkspot"] = {
        message = 'Überprüfe Angelstelle...',
        type = "success",
    },
    ["notonline"] = {
        message = 'Spieler nicht Online...',
        type = "success",
    },

    
   
}


function GetIdentifier(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))

        if xPlayer then
            return xPlayer.getIdentifier()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.citizenid
        else
            return "0"
        end
    end
end

function GetName(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end
