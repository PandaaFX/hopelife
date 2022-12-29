Config = {}
Config.Locale = "de"

nkn = {}
--esx
nkn.esx = "esx"
nkn.getSharedObject = "getSharedObject"
nkn.logWebhook = "https://discord.com/api/webhooks/912397031497166849/2AHduccF2NJduKXhprTdPOK6cExWqvJa8SMMxGKDVRzmzr47J0X5huVJ1t3Rr7Kxvgc4"

nkn.clientNotify = function(msg)
    ESX.ShowNotification(msg)
end

nkn.freeModeMessage = function(title, msg)
    ESX.Scaleform.ShowFreemodeMessage(title, msg, 5)
end

nkn.serverNotify = function(source, msg)
    TriggerClientEvent(nkn.esx..":showNotification", source, msg)
end


--- ENTER YOUR IMG FOR ITEMS IN =>>> html/img/items

--Own Laboratory
nkn.laborfews = 500000      -- Price to buy a Laboratory
nkn.maxOwns = 1             -- How Many Laboratory can a gang buy
nkn.cantBuy = {             -- Which Fraction cant buy a laboratory. Same time The Fraktions who Rob a laboraty with this Job the laboratory will be set to default
    'police',
    'lssd',
    'fib',
    'army',
    'unemployed',
}

--Rob Laboratory
nkn.checkMaxOwnesByRobbery = true                          -- boolean: true = active, false = inactive, this will be check nkn.maxOwns by robberys
nkn.minToRob = 6                                            -- int: min 1
nkn.robberyTime = 5                                       -- int: min 2
nkn.anim = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"       -- anim1
nkn.anim2 = "machinic_loop_mechandplayer"                   -- anim2
nkn.cantRob = {                                             -- which Job cant rob a Laboratory
    'unemployed',

}

nkn.cooldown = {            
    active = true,                                          -- boolean: true = active, false = inactive
    time = 60,                                               -- int: min 2
}

nkn.marker = {
    sprite = 1,
    sizex = 1.5,
    sizey = 1.5,
    sizez = 1.5,
    r = 0,
    g = 255,
    b = 0,
    a  = 100
}

nkn.progbar = {
    status = true,
    export = "exports['progressBars']:startUI(nkn.robberyTime * 60000, 'LABORRAUB...')"
}

nkn.contactFraktion = true                                  -- Contact the Job when a member put in or put out drugs to Process or processed

--https://docs.fivem.net/docs/game-references/blips/
nkn.laborblip = {
    blipsprite = 51, 
    blipscale = 1.0,
    jobcolors = {
        ['vagos'] = 33,
        ['lcn'] = 40,
        ['crips'] = 29,
        ['sinaloa'] = 37,
        ['irish'] = 25,
        ['triangolo'] = 61,
        ['outlaws'] = 13,
        ['oblocks'] = 56,
        ['ballas'] = 27,
        
    }
}

nkn.labore = {
    
    ['vespucci_laboratory'] = {                                     -- ['laborname'] is the Laborname
        coordsEnter = vector3(-521.393433, -2196.817627, 6.380981),            -- Coords to enter the Laboratory
        coordsExit = vector3(1027.74, -3101.44, -39.0),              -- Coords to Exit the Laboratory
        coordsWorkbench = vector3(1021.73, -3112.24, -39.0),       -- Coords to use The Laboratory and open UI
        coordsRob = vector3(994.55, -3100.01, -39.0),              -- Coords to rob the Laboratory
        routingBucket = 31,                                         -- Use another Routing bucket if you watn to use the same interrior for all 
        craftableDrugs = {

            ['coke_pooch'] = {                                          -- ['ITEMTOPROCESS'] is the Item you´ll get if the process is finished
                requiedItems = 'coke',                              -- Item to put in to process 
                requiedItemsAmount = 2,                             -- How many items needed to process Example: 2x kokainblatt = 1x Kokain
                maxTimeToCraft = 3600                                -- How long does a process take: in seconds
            }, 

            ['weedjoint'] = {
                requiedItems = 'weed',
                requiedItemsAmount = 2,
                maxTimeToCraft = 3600-- inSeconds
            }, 

            --You can put much items you want
        },
    },

    ['vespucci_laboratory_second'] = {
        coordsEnter = vector3(-2175.534180, 4294.799805, 49.044678), 
        coordsExit = vector3(1027.74, -3101.44, -39.0),             
        coordsWorkbench = vector3(1021.73, -3112.24, -39.0),       
        coordsRob = vector3(994.55, -3100.01, -39.0),              
        routingBucket = 30,
        craftableDrugs = {

            ['coke_pooch'] = {
                requiedItems = 'coke',
                requiedItemsAmount = 2,
                maxTimeToCraft = 3600
            },
            ['weedjoint'] = {
                requiedItems = 'weed',
                requiedItemsAmount = 2,
                maxTimeToCraft = 3600
            },
        },
    },

    --you can put much laboratorys you want!! Make sure put new laboratorys in your Database [Watch nkn.sql]

}
