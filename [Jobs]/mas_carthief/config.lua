config = {}

config.CopsRequired = 0

config.CDdispatch = false

config.HackerWebhook = "" --If someone is more than 10 from sell position and triggering event to get money.

config.Notification = 'esx' -- you can put [esx, mythic_old, mythic_new, other], if you put other go into clien.lua , line 406 and give there your own

config.ItemMoney = false -- if you have item money or you have default money

config.ProgressBarTime = 3 -- how much sec

config.Peds = {
    startJob = {
        ped = 'mp_m_g_vagfun_01',
        coords = vector4(470.366058, -731.483948, 27.419270-0.98, 89.21)
    }
}

config.Blips = {
    GetCar = {
        type = 58,
        color = 2,
        name = 'Auto'
    },
    StolenCar = {
        type = 58,
        color = 2,
        name = 'Gestohlenes Auto'
    },
    SellCar = {
        type = 58,
        color = 2,
        name = 'Auto verkaufen'
    }
}

config.Marker = {
    type = 2,
    r = 0,
    g = 153,
    b = 0,
    a = 155
}

config.RandomSpots = {
    [1] = {pos = vector4(139.424927, 317.502777, 112.138573, 171.93)},
    [2] = {pos = vector4(-1507.937378, 429.255920, 111.072006, 171.93)},
    [3] = {pos = vector4(-1255.677490, -385.457428, 59.287449, 171.93)},
    [4] = {pos = vector4(-736.370422, -73.840576, 41.747192, 171.93)},
    [5] = {pos = vector4(0.956205, -205.081970, 52.741871, 171.93)},
    [6] = {pos = vector4(-458.503784, -767.394470, 45.019104, 171.93)},
    [7] = {pos = vector4(-1109.588135, -1242.348999, 2.329223, 171.93)},
    [8] = {pos = vector4(-978.143982, -1483.639282, 5.009792, 171.93)},
    [9] = {pos = vector4(-1954.543335, 212.932022, 86.037560, 171.93)},
    [10] = {pos = vector4(-1107.310425, 793.690186, 165.017883, 171.93)},
    [11] = {pos = vector4(-1567.629150, -236.816132, 49.474174, 171.93)}
}

-- if you add car here, then you need to go into helper.lua, line 7 and add the car for helper there too. (i will change this in update) also same if you remove
config.RandomCars = {
    [1] = {car = 'banshee'},
    [2] = {car = 'retinue'},
    [3] = {car = 'issi7'},
    [4] = {car = 'ninef'},
    [5] = {car = 'ninef2'},
    [6] = {car = 'comet3'},
    [7] = {car = 'feltzer2'},
    [8] = {car = 'jester'},
    [9] = {car = 'jester3'},
    [10] = {car = 'surano'},
    [11] = {car = 'adder'},
    [12] = {car = 'nero2'},
    [13] = {car = 'osiris'},
    [14] = {car = 'voltic'},
    [15] = {car = 'cheetah'},
    [16] = {car = 'zentorno'},
    [17] = {car = 'vacca'},
    [18] = {car = 'mesar'},
    [19] = {car = 'brawler'},
    [20] = {car = 'bullet'},
    [21] = {car = 'infernus'},
    [22] = {car = 'neo'}
}

config.CarPrice = {
    banshee = math.random(100000, 150000),
    retinue = math.random(100000, 150000),
    issi7 = math.random(100000, 150000),
    ninef = math.random(100000, 150000),
    ninef2 = math.random(100000, 150000),
    comet3 = math.random(100000, 150000),
    feltzer2 = math.random(100000, 150000),
    jester = math.random(150000, 250000),
    jester3 = math.random(150000, 250000),
    surano = math.random(100000, 150000),
    adder = math.random(250000, 350000),
    nero2 = math.random(250000, 350000),
    osiris = math.random(200000, 300000),
    voltic = math.random(150000, 250000),
    cheetah = math.random(200000, 300000),
    zentorno = math.random(250000, 350000),
    vacca = math.random(200000, 300000),
    mesar = math.random(100000, 200000),
    brawler = math.random(100000, 200000),
    bullet = math.random(250000, 350000),
    infernus = math.random(200000, 300000),
    neo = math.random(250000, 350000)
}

config.Sell = {
    coords = vector3(1643.492676, 4839.423340, 42.027603)
}

config.TimerSec = 0.3 -- 3 sec is one %
config.DriverSecBetweenNextDrive = 75 -- 125 minits you will wait, then you can use driver position again
config.HelperSecBetweenNextDrive = 75 -- 125 minits you will wait, then you can use helper position again

ProgressBar = function (time)

    --Here u can change progressbar on your own
    exports.rprogress:Custom({
        Duration = time,
        Label = 'Auto öffnen',
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        }
    })

end

Lang = {
    ['start_job'] = 'Mit John reden',
    ['stop_job'] = 'Du hast es abgebrochen',
    ['talk_john'] = '[E] Mit John reden',
    ['enough_pd'] = 'Nicht genug PD',
    ['location'] = 'Du hast einen Parkplatz, hol dir ein Fahrzeug',
    ['driver_timer'] = 'Warte, du bist gerade noch gefahren',
    ['open_car'] = '[E] Auto öffnen',
    ['opening_car'] = 'öffne auto....',

    --CDdispatch
    ['title'] = 'Autodieb',
    ['message'] = 'Autodieb',
    ['text'] = 'Autodieb',

    ['get_location'] = '[E] Standort erhalten',
    ['location_set'] = 'Sie haben den Standort erhalten, an dem Sie das Fahrzeug verkaufen werden',
    ['not_removed'] = 'Der Passagier hat das Ortungsgerät noch nicht entfernt',
    ['delivery_vehicle'] = '[E] Übergabe des Fahrzeugs',
    ['stolen_vehicle'] = 'Netter Versuch, wo ist Ihr gestohlenes Fahrzeug?',
    ['30_get_back'] = 'Sie haben 30 Sekunden Zeit, um in das Fahrzeug einzusteigen',
    ['mission_end'] = 'Mission abgeschlossen, Sie sind nicht in das Fahrzeug eingestiegen',

    --Helper
    ['helper_drive'] = 'Gehen Sie mit dem Fahrer zum Fahrzeug',
    ['helper_timer'] = 'Warten Sie einen Moment, Sie haben geholfen',
    ['destroy_locator'] = '[E] Lokalisierer zerstören',
    ['remaining_time'] = 'Verbleibende Zeit ',
    ['%'] = ' %',

    --Menu
    ['driver_label'] = 'Fahrer',
    ['helper_label'] = 'Hacker',

    --ChatSuggestion

    ['command'] = '/carthief',
    ['description'] = 'Transport eines gestohlenen Fahrzeugs Fahrer/Helfer'

}