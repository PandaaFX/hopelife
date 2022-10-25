
Config = {
    IndependentGarage = false, -- if you store a vehicle in garage A, you can not take it out from garage B.
    ShowJobVehicles = true, -- show job vehicles such as police cars
    Damages = true, -- save & load damages when storing / retrieving a car?
    Use3DText = true, -- use 3d text?
    ImpoundPrice = 2500, -- price to retrieve a vehicle from the impound
    AllowMultiple = false, -- allow people to take out vehicles from the impound if it is already out?
    DefaultJob = "", -- this is the job for cars which are not for jobs. For some servers, this should be just "" and for others "civ"
    DefaultType = {"car", "motos, car2"}, -- if type is not defined for the garage, it will chec kif the "type" in owned_vehicles is DefaultType

    Impounding = {
        AllowJobsToImpound = true, -- allow specific jobs to impound vehicles?
        Command = "impound", -- command for impounding, or false for disabled
        AllowedJobs = { -- the specific jobs allowed to impound vehicles, if AllowJobsToImpound is enabled
            "police",
            "fib",
        },
    },

    Interior = {
        Enabled = false, -- should you browse vehicles at the interior or at the garage location?
        Coords = vector4(228.8, -986.97, -99.96, 180.0) -- vector4(x, y, z, heading) location of the interior.
    },
    
    Garages = {
        --[[
            garage_name = coords = vector4(x, y, z, heading) -- garage location
        ]]
        Theater = {
            browse = vector3(732.47, 658.38, 128.21),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(725.815369, 645.481323, 128.895996, 158.740158),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Crastenburg = {
            browse = vector3(-1211.340698, -182.136261, 39.322388),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1218.843994, -185.076920, 39.170654, 107.716537),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Spedition = {
            browse = vector3(-39.797802, -2553.890137, 5.993408),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-43.767033, -2544.197754, 5.993408, 14.173228),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Cafe = {
            browse = vector3(-584.914307, -1086.738403, 22.320923),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-581.789001, -1100.993408, 22.169189, 90.708656),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Unicorn = {
            browse = vector3(147.389008, -1292.650513, 28.330444),
            spawn = vector4(150.118683, -1285.265991, 28.993408, 212.598419),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Hills = {
            browse = vector3(719.7, 254.28, 92.4),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(705.23, 255, 93.05, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        HumanLabs = {
            browse = vector3(3585.216796875, 3667.7956542969, 33.888652801514),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(3574.4689941406, 3653.5061035156, 33.894062042236, 46.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        FFA = {
            browse = vector3(2771.6291503906, 3472.7351074219, 55.478267669678),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(2782.5549316406, 3474.4458007813, 55.294086456299, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Norschleife = {
            browse = vector3(1464.2261962891, 6542.35546875, 14.417057991028),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1455.1763916016, 6559.369140625, 14.248965263367, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Talstation = {
            browse = vector3(-768.71435546875, 5595.4624023438, 33.48567199707),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-774.14227294922, 5569.0698242188, 33.485549926758, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Bergdorf = {
            browse = vector3(-1086.8543701172, 4898.8798828125, 214.25112915039),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1091.2322998047, 4914.33203125, 215.03756713867, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        FortZacudo = {
            browse = vector3(-2338.2124023438, 3425.59765625, 29.754398345947),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-2343.9465332031, 3431.3452148438, 29.36462020874, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Naturtankstelle = {
            browse = vector3(-2528.5234375, 2318.5556640625, 33.215885162354),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-2523.3386230469, 2337.5661621094, 33.059909820557, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Trailerpark = {
            browse = vector3(67.997596740723, 3617.2866210938, 39.846920013428),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(77.156044, 3629.894531, 39.692993, 323.149597),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Hafen = {
            browse = vector3(203.48365783691, -3130.9575195313, 5.7902660369873),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(192.43656921387, -3126.4501953125, 5.7902183532715, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Hafen2 = {
            browse = vector3(1195.8120117188, -3252.9782714844, 7.0960307121277),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1187.2550048828, -3251.8586425781, 6.0287647247314, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Flughafen = {
            browse = vector3(-989.28033447266, -2951.8347167969, 12.945067405701),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-969.16961669922, -2966.2028808594, 13.945066452026, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        FlughafenSandy = {
            browse = vector3(1726.8139648438, 3295.7727050781, 41.223514556885),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1731.2456054688, 3311.169921875, 41.223476409912, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        FlughafenSandy2 = {
            browse = vector3(2135.8608398438, 4794.7680664063, 41.114448547363),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(2134.5971679688, 4781.6752929688, 40.970317840576, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Wuerfelparkoben = {
            browse = vector3(213.7451, -809.3802, 29.99854),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(230.044, -799.978, 30.66042, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Wuerfelparkunten = {
            browse = vector3(100.6967, -1073.499, 28.36414),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(111.1516, -1064.4, 29.17871, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Stadtlinks = {
            browse = vector3(-280.6659, -887.8813, 30.30188),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-284.9011, -896.0439, 31.06592, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Vespucciunten = {
            browse = vector3(-1184.347, -1509.574, 4.645386),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1191.653, -1500.158, 4.375854, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        LSMD = {
            browse = vector3(-697.09, 370.56, 78.12),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-693.55, 366.3, 78.12, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Vespuccioben = {
            browse = vector3(-2161.978027, -380.624176, 13.171387),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-2147.301, -386.4264, 13.22192, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Golfplatz = {
            browse = vector3(-1371.007, 56.53187, 53.69519),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1393.516, 78.8044, 53.7627, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Lifeinvader = {
            browse = vector3(-898.1671, -154.7209, 40.68354),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-912.5275, -162.7121, 41.8667, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Vinewood1 = {
            browse = vector3(-340.6077, 266.5319, 84.67615),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-344.2154, 277.3582, 85.30554, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Schleife = {
            browse = vector3(-73.05495, 908.4132, 234.6227),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-70.19341, 900.6088, 235.5721, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Vinewood2 = {
            browse = vector3(362.5187, 298.378, 102.874),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(367.7934, 290.6374, 103.3685, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Vinewood3 = {
            browse = vector3(275.4462, -344.822, 44.16919),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(272.8484, -337.3318, 44.9165, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Grovestreet = {
            browse = vector3(1036.563, -763.556, 56.99194),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1026.963, -761.8945, 57.9751, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Fabrik = {
            browse = vector3(724.2857, -2016.422, 28.57991),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(727.2923, -2027.103, 29.27991, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Stadion = {
            browse = vector3(-73.23956, -2004.356, 17.26013),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-67.3055, -2013.626, 18.00732, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Southside = {
            browse = vector3(-70.64725, -1833.547, 26.93774),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-62.46593, -1838.215, 26.70178, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Ballas = {
            browse = vector3(393.0198, -1630.689, 28.27991),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(391.8593, -1623.851, 29.27991, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Cayo = {
            browse = vector3(4519.319, -4514.703, 4.493774),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(4510.679, -4514.545, 4.139893, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Observatorium = {
            browse = vector3(-400.86, 1210.87, 325.94),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-409.62, 1212.14, 325.64, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Westhighway = {
            browse = vector3(-3142.497, 1125.046, 19.83813),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-3138.936, 1117.371, 20.6864, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Paleto = {
            browse = vector3(113.0769, 6619.306, 30.84106),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(122.6506, 6617.262, 31.82422, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        SG = {
            browse = vector3(1899.376, 2605.965, 45.96118),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1923.705, 2615.829, 46.18018, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Bennys = {
            browse = vector3(-176.68, -1283.47, 30.3),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-181.08, -1287.95, 31.3, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Einreise = {
            browse = vector3(-989.67, -2706.97, 13.83),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-972.68, -2703.7, 13.86, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        DOJ = {
            browse = vector3(-574.193420, -249.547256, 34.885010),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-579.336243, -247.582413, 35.817627, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Hookies = {
            browse = vector3(-2190.013184, 4266.975586, 48.724487),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-2195.472412, 4259.683594, 48.151611, 149.69),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Casino = {
            browse = vector3(889.622009, -56.676918, 78.750977),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(897.204407, -59.591206, 78.750977, 144.566910),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Mine = {
            browse = vector3(-600.830750, 2108.822021, 127.918701),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-621.613159, 2112.804443, 125.323853, 144.566910),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Friedhof = {
            browse = vector3(-1675.529663, -246.843948, 54.554565),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1661.894531, -249.178024, 54.908447, 342.992126),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        HookahLounge = {
            browse = vector3(-419.512085, -41.221977, 46.213867),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-425.472534, -41.617580, 46.213867, 0.000000),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Ranch = {
            browse = vector3(1370.87, 1145.49, 113.76),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1367.96, 1150.6, 113.76, 0.000000),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Autohaus = {
            browse = vector3(-723.019775, -1491.731812, 4.999268),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-730.997803, -1483.147217, 4.999268, 323.14959),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },

        --- Boote

        CayoFlugzeuge = {
            browse = vector3( -761.749451, -1377.507690, 1.57873),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-760.799988, -1391.696655, -0.409546, 141.732285),
            vehicletype = "boat",
        },

        Marina = {
            browse = vector3(-831.547241, -1412.123047, 1.000581),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-840.197815, -1410.923096, -0.089355, 204.094498),
            vehicletype = "boat",
        },

    -- FLUGZEUGGARAGEN
        
        CayoFlugzeuge = {
            browse = vector3(4441.253, -4483.701, 3.257935),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(4450.92, -4492.12, 4.21, 46.69),
            vehicletype = "aircraft",
        },
        FlughafenFlugzeuge = {
            browse = vector3(-1018.870, -3018.514, 13.129),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-980.162, -2997.494, 13.929, 56.69),
            vehicletype = "aircraft",
        },   
        FlughafenSandyFlugzeuge = {
            browse = vector3(1725.495, 3289.24, 40.17578),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(1709.683, 3252.237, 41.02417, 104.69),
            vehicletype = "aircraft",
        },   
        FlughafenSandy2Flugzeuge = {
            browse = vector3(2118.25, 4788.435, 40.17578),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(2114.176, 4801.688, 41.17578, 117.69),
            vehicletype = "aircraft",
        },       
       
    },


    Impounds = {
        {
            Retrieve = vector3(408.61, -1625.47, 28.29), -- where you open the menu to retrieve the car
            Spawn = vector4(405.6, -1643.4, 28.61, 229.99), -- where the car spawns
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        {
            Retrieve = vector3(-1615.52, -3137.48, 13.3), -- where you open the menu to retrieve the plane
            Spawn = vector4(-1654.096, -3146.48, 13.57, 329.89), -- where the plane spawns
            vehicletype = "aircraft",
        },
        {
            Retrieve = vector3(-834.303284, -1402.602173, 1.000427), -- where you open the menu to retrieve the car
            Spawn = vector4(-840.197815, -1410.923096, -0.089355, 204.094498), -- where the car spawns
            vehicletype = "boat",
        },
    }
}
