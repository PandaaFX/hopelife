Config              = {}

Config.Locale = 'de'

Config.DistancePrice = 4.5 -- = each Distance * this = money for 1 delivery

Config.SafeDeposit = 2500

Config.BusStopTimer = 10 * 1000 -- 10 seconds

Config.Blips = {

    Startpoint = {
        coords  = {x = 453.5, y = -622.07, z = 28.53},
        type    = 513,
        colour = 2,
        name = _U('blip_name'),
        scale = 0.7,
    },
}


Config.VehicleDeleter = {x = 470.88, y = -583.22, z = 28.5}

Config.AvailableRoutes = {

    Route_1 = {
        name = 'Linie 1 Mittel',
        bus = 'bus',
        color = 111, -- put color code here, codes = https://pastebin.com/pwHci0xK

        BusSpawnPoints = {
            { coords = {x = 462.61, y = -605.4, z = 28.5}, heading = 215.0, range = 3.0},
            { coords = {x = 461.31, y = -611.55, z = 28.5}, heading = 215.0, range = 3.0},
        },

        BusStops = {
            { name = 'City Center, Strawberry Avenue', coords = {x = 306.82, y = -765.86, z = 29.21}},
            { name = 'Olympic, Strawberry Station', coords = {x = 265.75, y = -1187.3, z = 29.47}},
            { name = 'Strawberry, South LS', coords = {x = 29.13, y = -1524.89, z = 29.23}},
            { name = 'International Airport', coords = {x = -987.68, y = -2744.75, z = 13.71}},
            { name = 'International Airport, Parking 2', coords = {x = -775.26, y = -2327.93, z = 14.78}},
            { name = 'South Rockford, Puerta Del Sol', coords = {x = -694.49, y = -1200.59, z = 10.56}},
            { name = 'Magellan, Vespucci Beach', coords = {x = -1209.28, y = -1410.62, z = 4.13}},
            { name = 'Del Perro Beach / Pier', coords = {x = -1659.55, y = -944.19, z = 7.78}},
            { name = 'Magellan, Vespucci Beach', coords = {x = -1168.0, y = -1472.01, z = 4.28}},
            { name = 'South Rockford, Puerta Del Sol', coords = {x = -685.0, y = -1256.01, z = 10.56}},
            { name = 'International Airport, Parking 2', coords = {x = -782.99, y = -2335.0, z = 14.86}},
            { name = 'International Airport', coords = {x = -987.68, y = -2744.75, z = 13.71}},
            { name = 'Strawberry, South LS', coords = {x = 50.65, y = -1535.16, z = 29.22}},
            { name = 'Olympic, Strawberry Station', coords = {x = 265.75, y = -1187.3, z = 29.47}},
            { name = 'P+R Terminal, Integrity Way', coords = {x = 456.46, y = -653.61, z = 27.88}},
        }
    },


    Route_2 = {
        name = 'Linie 2 Kurz',
        bus = 'bus',
        color = 111,

        BusSpawnPoints = {
            { coords = {x = 462.61, y = -605.4, z = 28.5}, heading = 215.0, range = 3.0},
            { coords = {x = 461.31, y = -611.55, z = 28.5}, heading = 215.0, range = 3.0},
        },

        BusStops = {
            { name = 'Motodrom, Vinewood Park', coords = {x = 1039.63, y = 200.74, z = 80.85}},
            { name = 'Vinewood Theater, Vinewood Hills', coords = {x = 683.05, y = 670.35, z = 128.91}},
            { name = 'Vinewood Center, Vinewood Boulevard', coords = {x = 293.34, y = 175.89, z = 103.89}},
            { name = 'Rockford Hills, Marathon Avenue', coords = {x = -1169.2, y = -401.12, z = 35.11}},
            { name = 'Del Perro, Boulevard Del Perro', coords = {x = -1527.11, y = -467.17, z = 35.1}},
            { name = 'Del Perro Beach, Red Desert Avenue', coords = {x = -1598.72, y = -1041.9, z = 13.02}},
            { name = 'Rockfort Hills, Dorset Street', coords = {x = -679.05, y = -376.46, z = 34.03}},
            { name = 'Pillbox Hill, Vespucci Boulevard', coords = {x = -249.09, y = -884.53, z = 30.27}},
            { name = 'P+R Terminal, Integrity Way', coords = {x = 457.42, y = -646.14, z = 28.29}},
        }
    },

    Route_3 = {
        name = 'Linie 3 Lang',
        bus = 'bus',
        color = 111,

        BusSpawnPoints = {
            { coords = {x = 462.61, y = -605.4, z = 28.5}, heading = 215.0, range = 3.0},
            { coords = {x = 461.31, y = -611.55, z = 28.5}, heading = 215.0, range = 3.0},
        },

        BusStops = {
            { name = 'Mission Row, Adams Apple Boulevard', coords = {x = 259.54, y = -1123.99, z = 29.22}},
            { name = 'Pillbox Hill, Milles High Tower', coords = {x = -183.84, y = -1130.96, z = 22.94}},
            { name = 'Little Soul, Vespucci Boulevard', coords = {x = -712.22, y = -827.67, z = 23.43}},
            { name = 'Del Perro, Red Desert Avenue', coords = {x = -1334.31, y = -669.34, z = 26.38}},
            { name = 'Banham Canyon, Great Ocean Highway', coords = {x = -2976.79, y = 442.82, z = 15.08}},
            { name = 'Chumash, Barbareno Road', coords = {x = -3224.46, y = 971.73, z = 12.94}},
            { name = 'North Chumash, Great Ocean Highway', coords = {x = -2448.16, y = 3736.98, z = 16.54}},
            { name = 'North Chumash, Hookies Restaurant', coords = {x = -2215.46, y = 4282.15, z = 47.51}},
            { name = 'Chiliad Mountain, Naturschutzgebiet', coords = {x = -1527.7, y = 4950.01, z = 61.97}},
            { name = 'Paleto Forest, Seilbahn', coords = {x = -773.31, y = 5574.45, z = 33.49}},
            { name = 'Paleto Bay, Clucking Bell', coords = {x = -156.41, y = 6206.55, z = 31.21}},
            { name = 'Procopio Beach, Ocean', coords = {x = 1416.07, y = 6590.28, z = 13.00}},
            { name = 'Grapeseed, Townstation', coords = {x = 1662.26, y = 4855.88, z = 41.96}},
            { name = 'Grapeseed, Airport', coords = {x = 2116.61, y = 4717.12, z = 40.75}},
            { name = 'Grapeseed, Deadend', coords = {x = 2467.16, y = 4056.73, z = 37.57}},
            { name = 'Sandy Shores, Sheriff Station', coords = {x = 1857.10, y = 3671.95, z = 33.82}},
            { name = 'Sandy Shores, Ammunation', coords = {x = 1712.19, y = 3770.59, z = 34.37}},
            { name = 'Grand Senora Desert, Yellow Jack Inn', coords = {x = 1988.39, y = 3105.52, z = 46.99}},
            { name = 'Grand Senora Desert, Stateprison', coords = {x = 1856.81, y = 2585.04, z = 45.67}},
            { name = 'Grand Senora Desert, Highway Entrance', coords = {x = 2190.11, y = 2922.97, z = 46.4}},
            { name = 'Tataviam Bergkette, Rastplatz', coords = {x = 2570.29, y = 401.15, z = 108.46}},
            { name = 'P+R Terminal, Integrity Way', coords = {x = 457.42, y = -646.14, z = 28.29}},
        }
    },
}