Config              = {}

Config.Locale = 'de'

Config.DistancePrice = 3.6 -- = each Distance * this = money for 1 delivery

Config.SafeDeposit = 4000

Config.Blips = {

    Startpoint = {
        coords  = {x = -62.31, y = -2516.92, z = 7.4},
        type    = 477,
        colour = 29,
        name = 'Spedition',
        scale = 0.8,
    },
}

Config.TrailerBlip = {
    Blip = {
        type = 479,
        colour = 26,
        name = 'Anhänger',
        scale = 0.8,
    }
}

Config.VehicleDeleter = {x = 147.07, y = -2501.21, z = 6.0}

Config.AvailableJobs = {
    -- #TruckSpawnPoints should be same as #TrailerSpawnPoints
    -- better use different spawnpoint for each job (otherwise u can block other spawnpoints)

    Cargo = {
        name = 'Frachtauftrag',
        truck = 'phantom',
        trailer = 'TRAILERS',
        deliver_counter = 3, -- has to be lower or equal then total deliverySpots
        TrailerSpawnPoints = {
            { coords = {x = -107.55, y = -2520.52, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -118.69, y = -2536.04, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -113.33, y = -2528.26, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -52.50, y = -2410.09, z = 6.0}, heading = 270.0, range = 3.0},
            { coords = {x = -52.50, y = -2418.20, z = 6.0}, heading = 270.0, range = 3.0},
        },

        TruckSpawnPoints = {
            { coords = {x = 45.07, y = -2475.06, z = 6.32}, heading = 55.0, range = 3.0},
            { coords = {x = 41.98, y = -2479.58, z = 6.90}, heading = 55.0, range = 3.0},
            { coords = {x = 38.89, y = -2483.96, z = 5.90}, heading = 55.0, range = 3.0},
            { coords = {x = -111.27, y = -2420.91, z = 6.0}, heading = 90.0, range = 3.0},
            { coords = {x = -111.27, y = -2412.91, z = 6.0}, heading = 90.0, range = 3.0},
        },

        DeliverySpots = {
            { name = 'Theater', coords = {x = 627.468140,y = 625.318665,z = 128.895996}, complete = false},
            { name = 'Mall', coords = {x = 13.4241, y = -1742.25, z = 29.29}, complete = false},
            { name = 'Fridged', coords = {x = 970.338440,y = -1580.980225,z= 30.610962}, complete = false},
            { name = 'Baustele', coords = {x = 973.674744,y= 2458.087891, z= 50.864502}, complete = false},
            { name = 'Truckerdepot', coords = {x = 190.589020, y= 2709.085693,z = 42.304810}, complete = false},
            { name = 'Firma', coords = {x = 345.230774,y= 3416.637451,z= 36.457886}, complete = false},
            { name = 'Grapeseed Wonderama', coords = {x = 1688.558228,y= 4779.718750, z= 41.917236}, complete = false},
            { name = 'Paleto Diner', coords = {x = 1581.573608,y= 6444.764648,z= 24.949463}, complete = false},
            
        }
    },

    Fracht = {
        name = 'Landwirtschaft',
        truck = 'tractor2',
        trailer = 'BALETRAILER',
        deliver_counter = 2, -- has to be lower or equal then total deliverySpots
        TrailerSpawnPoints = {
            { coords = {x = 56.848351, y = -2530.232910, z = 5.993408}, heading = 328.818909, range = 3.0}
        },

        TruckSpawnPoints = {
            { coords = {x = -42.527473,y= -2546.333984,z = 6.0 }, heading = 323.149597, range = 3.0}
        },

        DeliverySpots = {
            { name = 'Paleto', coords = {x = -563.076904,y=  6176.861328, z= 6.701050}, complete = false},
            { name = 'Paleto Farm', coords = {x = 418.008789, y= 6477.085938, z= 28.808105}, complete = false},
            { name = 'Farm', coords = {x = 2208.804443,y= 5614.285645,z= 53.897461}, complete = false},
            { name = 'Farm Grapeseed', coords = {x = 2549.010986, y= 4673.261719, z= 34.065186}, complete = false},
            { name = 'Weingut', coords = {x = -1940.993408,y = 1774.457153, z= 174.272583}, complete = false},
        }
    },

    
    Fueler = {
        name = 'Tankauftrag',
        truck = 'phantom',
        trailer = 'TANKER',
        deliver_counter = 5, -- has to be lower or equal then total deliverySpots
        TrailerSpawnPoints = {
            { coords = {x = -107.55, y = -2520.52, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -118.69, y = -2536.04, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -113.33, y = -2528.26, z = 6.0}, heading = 235.0, range = 3.0},
            { coords = {x = -52.50, y = -2410.09, z = 6.0}, heading = 270.0, range = 3.0},
            { coords = {x = -52.50, y = -2418.20, z = 6.0}, heading = 270.0, range = 3.0},
        },

        TruckSpawnPoints = {
            { coords = {x = 45.07, y = -2475.06, z = 6.32}, heading = 55.0, range = 3.0},
            { coords = {x = 41.98, y = -2479.58, z = 6.90}, heading = 55.0, range = 3.0},
            { coords = {x = 38.89, y = -2483.96, z = 5.90}, heading = 55.0, range = 3.0},
            { coords = {x = -111.27, y = -2420.91, z = 6.0}, heading = 90.0, range = 3.0},
            { coords = {x = -111.27, y = -2412.91, z = 6.0}, heading = 90.0, range = 3.0},
        },

        DeliverySpots = {
            { name = 'OMV', coords = {x = -66.64, y = -1762.05, z = 29.27}, complete = false},
            { name = 'Shell', coords = {x = -1431.14, y = -271.86, z = 46.21}, complete = false},
            { name = 'Aral', coords = {x = 634.13, y = 269.11, z = 103.09}, complete = false},
            { name = 'Esso', coords = {x = -2570.25, y = 2320.96, z = 33.06}, complete = false},
            { name = 'Agip', coords = {x = 2007.15, y = 3770.79, z = 32.18}, complete = false},
            { name = 'Agip', coords = {x = -526.02, y = -1211.0, z = 18.18}, complete = false},
            { name = 'Esso', coords = {x = -316.23, y = -1469.63, z = 30.55}, complete = false},
            { name = 'Shell', coords = {x = 269.65, y = -1261.19, z = 29.14}, complete = false},
            { name = 'Aral', coords = {x = 821.90, y = -1009.69, z = 26.09}, complete = false},
            { name = 'OMV', coords = {x = 1704.17, y = 6419.15, z = 32.64}, complete = false},
            { name = 'Shell', coords = {x = -91.96, y = 6417.39, z = 31.47}, complete = false},
            { name = 'Aral', coords = {x = -2092.18, y = -317.95, z = 13.03}, complete = false},
        }
    },
    Car = {
        name = 'Fahrzeuglieferung',
        truck = 'phantom',
        trailer = 'TR4',
        deliver_counter = 3, -- has to be lower or equal then total deliverySpots
        TrailerSpawnPoints = {
            { coords = {x = 79.1, y = -2539.9, z = 6.07}, heading = 210.0, range = 3.0},
            { coords = {x = 84.09, y = -2535.13, z = 6.07}, heading = 210.0, range = 3.0},
            { coords = {x = 88.33, y = -2528.83, z = 6.07}, heading = 210.0, range = 3.0},
        },

        TruckSpawnPoints = {
            { coords = {x = 70.39, y = -2517.14, z = 6.08}, heading = 55.0, range = 3.0},
            { coords = {x = 67.3, y = -2521.5, z = 6.08}, heading = 55.0, range = 3.0},
            { coords = {x = 63.59, y = -2527.08, z = 6.08}, heading = 55.0, range = 3.0},
        },

        DeliverySpots = {
            { name = 'Simeon Cars', coords = {x = -16.19, y = -1102.17, z = 26.68}, complete = false},
            { name = 'Import Cars', coords = {x = -55.52, y = 342.96, z = 112.11}, complete = false},
            { name = 'LKW Händler', coords = {x = -981.46, y = -2059.32, z = 9.41}, complete = false},
            { name = 'Larrys Cars', coords = {x = 1227.68, y = 2709.25, z = 38.01}, complete = false},
            { name = 'Euro Cars', coords = {x = -232.68, y = 6255.36, z = 31.49}, complete = false},
        }
    },
}