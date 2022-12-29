
Config = {
    IndependentGarage = false, -- if you store a vehicle in garage A, you can not take it out from garage B.
    ShowJobVehicles = true, -- show job vehicles such as police cars
    Damages = true, -- save & load damages when storing / retrieving a car?
    Use3DText = true, -- use 3d text?
    ImpoundPrice = 2500, -- price to retrieve a vehicle from the impound
    AllowMultiple = false, -- allow people to take out vehicles from the impound if it is already out?
    DefaultJob = "", -- this is the job for cars which are not for jobs. For some servers, this should be just "" and for others "civ"
    DefaultType = {type1 = "car", type2 = "motos", type3 = "car2", type4 = "aircraft", type5 = "boat"}, -- if type is not defined for the garage, it will chec kif the "type" in owned_vehicles is DefaultType

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
        lssdoffi = {
            browse = vector3(-458.334076, 6052.522949, 31.487183),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-449.248352, 6052.812988, 31.335571, 212.598419),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        Hotellifeinvader = {
            browse = vector3(-924.013184, -463.160431, 37.232910),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-933.692322, -458.136261, 37.216064, 28.346457),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        galaxy = {
            browse = vector3(286.773621, 189.520874, 104.413208),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(288.962646, 177.573624, 104.177246, 62.362206),
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
            browse = vector3(-614.268127, -940.799988, 22.068115),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-616.417603, -920.465942, 23.399292, 102.047249),
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
        Tequilalala = {
            browse = vector3(-567.04, 311.22, 84.18),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-579.771423, 323.591217, 84.766357, 0.000000),
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
            browse = vector3(391.8593, -1623.851, 29.27991),
            --location = vector4(232.2, -792.48, 29.9, 160.0), 
            spawn = vector4(393.0198, -1630.689, 28.27991, 149.69),
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
        --[[
        Weinhandel = {
            browse = vector3(-1923.481323, 2032.364868, 140.724487),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-1913.459351, 2043.784668, 140.724487, 308.976379),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        ]]
        CasinoParkplatz = {
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
        FIBGARAGE = {
            browse = vector3(2555.512207, -413.301086, 93.157471),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(2555.960449, -406.035156, 92.989014, 351.496063),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            hideblip = true,
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
        FrakShop = {
            browse = vector3(-765.863708, -2064.738525, 9.009521),
            --location = vector4(232.2, -792.48, 29.9, 160.0),
            spawn = vector4(-742.246155, -2065.068115, 8.908447, 342.992126),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },   
        
        PEARLS = {
            browse = vector3(-1791.942871, -1196.083496, 13.002930),
            spawn = vector4(-1795.213135, -1188.250488, 13.002930, 317.480316),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        
       
    -- FRAK GARAGEN
        FIB = {
            browse = vector3(2546.742920, -436.483521, 93.191162),
            spawn = vector4(2549.670410, -451.239563, 93.022705, 317.480316),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "aircraft",
            specifiedJob = "fib",
        },

        LSPD = {
            browse = vector3(592.931885, 5.920880, 70.612427),
            spawn = vector4(590.307678, 3.257143, 70.612427, 167.244080),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "police",
        },
        LSPDHeli = {
            browse = vector3(588.606567, 12.369232, 103.216797),
            spawn = vector4(579.758240, 12.474727, 103.216797, 85.039368),
            vehicletype = "aircraft",
            specifiedJob = "police",
        },

        SAINTS = {
            browse = vector3(-1825.714233, -1172.083496, 13.002930),
            spawn = vector4(-1822.074707, -1170.421997, 13.002930, 229.606293),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "saints",
        },
        Ballas = {
            browse = vector3(133.687912, -1936.654907, 20.585327),
            spawn = vector4(125.986816, -1936.641724, 20.669556, 28.346457),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "ballas",
        },
        --[[
        SAINTSHeli = {
            browse = vector3(-1748.914307, 371.578033, 89.720093),
            spawn = vector4(-1722.435181, 378.936249, 93.359741, 297.637787),
            vehicletype = "aircraft",
            specifiedJob = "saints",
        },
        ]]
        bauamt = {
            browse = vector3(-562.760437, -886.628540, 25.202148),
           spawn = vector4(-553.595581, -896.558228, 24.460815, 178.58267),
            vehicletype = "car",
           vehicletype2 = "motos",
            vehicletype3 = "car2",
           specifiedJob = "bauamt",
        },
        camorra = {
             browse = vector3(-3212.822021, 822.764832, 8.925293),
            spawn = vector4(-3200.980225, 811.964844, 8.925293, 212.598419),
             vehicletype = "car",
            vehicletype2 = "motos",
             vehicletype3 = "car2",
            specifiedJob = "irish",
         },
        
         camorraheli = {
             browse = vector3(-3251.775879, 838.127502, 2.909912),
             spawn = vector4(-3258.316406, 838.984619, 2.909912, 45.354328),
             vehicletype = "aircraft",
             specifiedJob = "irish",
        },
        Oblocks = {
            browse = vector3(337.542847, -2035.635132, 21.377319),
            spawn = vector4(335.696716, -2039.301147, 20.720093, 48.188972),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "oblocks",
        },
        OblocksHeli = {
            browse = vector3(345.217590, -2064.224121, 20.871826),
            spawn = vector4(351.336273, -2054.518555, 21.798584, 317.480316),
            vehicletype = "aircraft",
            specifiedJob = "oblocks",
        },

        LCN = {
            browse = vector3(-1522.325317, 99.270332, 56.711304),
            spawn = vector4(-1523.643921, 89.446152, 56.458618, 238.110229),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "lcn",
        },
        
        LCNHeli = {
            browse = vector3(-1559.789063, 101.419785, 57.570679),
            spawn = vector4(-1570.839600, 95.907700, 58.278442, 110.551186),
            vehicletype = "aircraft",
            specifiedJob = "lcn",
        },

         MG13 = {
            browse = vector3(1257.982422, -1589.287964, 53.156006),
            spawn = vector4(1261.318726, -1596.052734, 53.088623, 300.472443),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "mg13",
        },
        
        MG3Heli = {
            browse = vector3(1246.654907, -1598.571411, 53.021240),
            spawn = vector4(1244.452759, -1608.487915, 53.021240, 116.220474),
            vehicletype = "aircraft",
            specifiedJob = "mg13",
        },

        Outlaws = {
            browse = vector3(162.896698, -3018.145020, 5.926025),
            spawn = vector4(172.470337, -3006.487793, 5.808105, 340.157471),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "outlaws",
        },
        
        OutlawsHeli = {
            browse = vector3(168.118683, -3018.738525, 5.875488),
            spawn = vector4(174.210983, -3028.074707, 5.774414, 204.0944987),
            vehicletype = "aircraft",
            specifiedJob = "outlaws",
        },

        A18Street = {
            browse = vector3(-16.272526, -1451.815430, 30.543579),
            spawn = vector4(-17.578018, -1460.690063, 30.610962, 263.622070),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "18th",
        },
        
        A18StreetHeli = {
            browse = vector3(-29.353844, -1453.345093, 30.998535),
            spawn = vector4(-42.487911, -1480.958252, 41.293823, 277.795288),
            vehicletype = "aircraft",
            specifiedJob = "18th",
        },

        Hoover = {
            browse = vector3(-1321.806641, -1046.835205, 7.442505),
            spawn = vector4(-1323.626343, -1058.716431, 7.240234, 206.929138),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "hoover",
        },
        
        HooverHeli = {
            browse = vector3(-1314.580200, -1061.841797, 7.038086),
            spawn = vector4(-1318.364868, -1070.782471, 7.004395, 221.102371),
            vehicletype = "aircraft",
            specifiedJob = "hoover",
        },
        
        SonsofAnarchie = {
            browse = vector3(987.520874, -2504.558350, 28.285767),
            spawn = vector4(994.180237, -2500.931885, 28.285767, 2.834646),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "soa",
        },
        
        SonsofAnarchieHeli = {
            browse = vector3(1019.947266, -2485.780273, 28.454224),
            spawn = vector4(1025.986816, -2497.938477, 28.454224, 85.039368),
            vehicletype = "aircraft",
            specifiedJob = "soa",
        },

        Tschetschenen = {
            browse = vector3(-3006.633057, 82.061539, 11.604370),
            spawn = vector4(-2989.859375, 80.795609, 11.604370, 68.031494),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "che",
        },
        
        TschetschenenHeli = {
            browse = vector3(-3068.096680, 101.208794, 13.542114),
            spawn = vector4(-3075.270264, 98.215393, 13.407349, 161.574799),
            vehicletype = "aircraft",
            specifiedJob = "che",
        },
        Casino = {
            browse = vector3(939.639587, 25.674726, 81.143555),
            spawn = vector4(950.690125, 25.542860, 81.143555, 150.236221),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "casino",
        },

        LSMD = {
            browse = vector3(-679.27, 353.08, 78.12),
            spawn = vector4(-674.18, 345.51, 78.12, 80.87),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "ambulance",
        },
        
        LSMDHeli = {
            browse = vector3(-696.11, 322.95, 140.15),
            spawn = vector4(-708.12, 322.82, 140.15, 181.72),
            vehicletype = "aircraft",
            specifiedJob = "ambulance",
        },

        NIA = {
            browse = vector3(39.731873, -899.696716, 29.970703),
            spawn = vector4(23.736265, -887.327454, 30.122314, 249.448822),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "lssd",
        },
        
        -- LSSDHeli = {
        --     browse = vector3(-495.586823, 5992.087891, 31.301880),
        --     spawn = vector4(-475.318695, 5988.553711, 31.335571, 317.480316),
        --     vehicletype = "aircraft",
        --     specifiedJob = "lssd",
        -- },

        SNC = {
            browse = vector3(205.964828, -302.505493, 54.925293),
            spawn = vector4(201.705490, -300.909882, 54.925293, 345.826782),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "snc",
        },

        FRAKBENNYS = {
            browse = vector3(-186.659332, -1332.540649, 31.419800),
            spawn = vector4(-181.872528, -1323.402222, 31.251343, 0.000000),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "mechanic",
        },

        UNICORN = {
            browse = vector3(168.435165, -1295.367065, 29.431519),
            spawn = vector4(160.918686, -1284.369263, 29.077637, 141.732285),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "lafam",
        },

        SINALOA = {
            browse = vector3(-2592.052734, 1926.501099, 167.296753),
            spawn = vector4(-2579.66, 1930.01, 167.36, 71.83),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "sinaloa",
        },

                
        SINALOAHeli = {
            browse = vector3(-2598.224121, 1874.584595, 171.492310),
            spawn = vector4(-2591.802246, 1883.920898, 173.345825, 133.228333),
            vehicletype = "aircraft",
            specifiedJob = "sinaloa",
        },
        --[[
        irishgang = {
            browse = vector3(-1551.81, 882.2, 180.32),
            spawn = vector4(-1548.62, 875.52, 180.34, 205.88),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "irish",
        },

                
        irishgangheli = {
            browse = vector3(-1579.490112, 812.123047, 185.983154),
            spawn = vector4(-1589.815430, 816.487915, 185.983154, 25.511812),
            vehicletype = "aircraft",
            specifiedJob = "irish",
        },

        WEIN = {
            browse = vector3(-1923.507690, 2060.848389, 140.808838),
            spawn = vector4(-1918.061523, 2056.760498, 140.724487, 260.787415),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "wein",
        },
]]
        crips = {
            browse = vector3(-345.810974, 75.191208, 49.095215),
            spawn = vector4(-348.065918, 73.701103, 49.095215, 85.039368),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "crips",
        },
        VAGOS = {
            browse = vector3(-1129.714233, -1604.492310, 4.392700),
            spawn = vector4(-1126.404419, -1611.494507, 4.392700, 303.307098),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "vagos",
        },

                
        VAGOSHeli = {
            browse = vector3(-1118.558228, -1580.822021, 12.379517),
            spawn = vector4(-1111.569214, -1583.156006, 11.874023, 303.307098),
            vehicletype = "aircraft",
            specifiedJob = "vagos",
        },

        triangolo = {
            browse = vector3(4996.008789, -5735.010742, 19.877686),
            spawn = vector4(4992.685547, -5726.057129, 19.877686, 17.007874),
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
            specifiedJob = "triangolo",
        },

        triangoloHeli = {
            browse = vector3(4891.477051, -5751.652832, 26.331177),
            spawn = vector4(4890.989258, -5736.276855, 26.348022, 354.330719),
            vehicletype = "aircraft",
            specifiedJob = "triangolo",
        },

    },

    Impounds = {
        {
            Retrieve = vector3(408.672516, -1625.485718, 29.279907), -- where you open the menu to retrieve the car
            Spawn = vector4(405.6, -1643.4, 28.61, 229.99), -- where the car spawns
            vehicletype = "car",
            vehicletype2 = "motos",
            vehicletype3 = "car2",
        },
        {
            Retrieve = vector3(-217.582413, 6201.600098, 31.487183),
            Spawn = vector4(-199.186813, 6212.360352, 31.487183, 235.275589),
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
        }
    }

}