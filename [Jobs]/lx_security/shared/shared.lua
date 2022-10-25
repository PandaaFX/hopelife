CCTV_Config = {}

CCTV_Config.HideRadar = true -- Controls if the minimap will be disabled when in a camera.
CCTV_Config.HideHUD = true -- Controls if the HUD will be disabled when in a camera. (Reference Utils.ToggleHUD() in Utils.lua)

CCTV_Config.UseAces = false -- Controls if you're using default permissions or not

CCTV_Config.ShowNoPerms = false -- Controls whether or not to display the no permissions error

CCTV_Config.Cameras = { -- All of the logged cameras
    {location = vector4(34.12, -1348.48, 30.5, 59.20), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Innocence Boulevard)", camera = 1},
    {location = vector4(24.22, -1342.64, 30.5, 235.62), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Innocence Boulevard)", camera = 2},
    {location = vector4(30.99, -1341.13, 30.52, 49.42), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Innocence Boulevard)", camera = 3},
    {location = vector4(381.34, 323.01, 104.69, 34.69), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Clinton Avenue)", camera = 1},
    {location = vector4(373.53, 331.02, 104.69, 209.73), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Clinton Avenue)", camera = 2},
    {location = vector4(380.57, 330.62, 104.69, 32.19), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Clinton Avenue)", camera = 3},
    {location = vector4(2558.81, 390.11, 109.85, 143.36), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Palomino Freeway)", camera = 1},
    {location = vector4(2552.54, 380.92, 109.85, 313.33), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Palomino Freeway)", camera = 2},
    {location = vector4(2551.39, 387.73, 109.85, 135.86), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Palomino Freeway)", camera = 3},
    {location = vector4(-3036.09, 585.05, 9.6, 319.68), canRotate = true, cameraType = "low", type = "General Stores", name = "General Store (Inseno Road)", camera = 1},
    {location = vector4(-3040.77, 594.27, 9.08, 158.74), canRotate = true, cameraType = "medium", type = "General Stores", name = "General Store (Inseno Road)", camera = 2},
    {location = vector4(-3043.44, 582.91, 9.08, 336.27), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Inseno Road)", camera = 3},
    {location = vector4(-3046.84, 588.96, 9.08, 158.71), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Inseno Road)", camera = 4},
    {location = vector4(-3240.23, 1009.21, 13.90, 129.43), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Barbereno Road)", camera = 1},
    {location = vector4(-3246.92, 1000.3, 13.90, 311.88), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Barbereno Road)", camera = 2},
    {location = vector4(-3247.78, 1007.18, 14.01, 136.92), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Barbereno Road)", camera = 3},
    {location = vector4(548.98, 2674.68, 43.16, 35.94), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Harmony)", camera = 1},
    {location = vector4(537.4, 2671.29, 43.79, 128.4), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Harmony)", camera = 2},
    {location = vector4(539.14, 2671.23, 43.29, 233.44), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Harmony)", camera = 3},
    {location = vector4(549.85, 2666.71, 43.29, 50.89), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Harmony)", camera = 4},
    {location = vector4(543.36, 2664.36, 43.29, 233.4), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Harmony)", camera = 5},
    {location = vector4(1968.82, 3743.63, 33.49, 77.66), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Alhambra Drive)", camera = 1},
    {location = vector4(1657.69, 3744.0, 33.5, 257.56), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Alhambra Drive)", camera = 2},
    {location = vector4(1962.79, 3748.66, 33.49, 77.66), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Alhambra Drive)", camera = 3},
    {location = vector4(2683.92, 3287.4, 56.32, 107.43), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Senora Freeway)", camera = 1},
    {location = vector4(2673.82, 3281.56, 56.32, 292.39), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Senora Freeway)", camera = 2},
    {location = vector4(2675.99, 3288.17, 56.32, 109.95), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Senora Freeway)", camera = 3},
    {location = vector4(1740.25, 6406.94, 36.15, 201.8), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (East | Great Ocean Highway)", camera = 1},
    {location = vector4(1735.7, 6410.0, 36.15, 21.8), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (East | Great Ocean Highway)", camera = 2},
    {location = vector4(1729.81, 6419.38, 36.08, 199.44), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (East | Great Ocean Highway)", camera = 3},
    {location = vector4(1736.51, 6417.86, 36.08, 21.8), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (East | Great Ocean Highway)", camera = 4},
    {location = vector4(1133.25, -978.84, 47.48, 221.79), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Vespucci Boulevard)", camera = 1},
    {location = vector4(-1224.77, -910.71, 13.43, 335.67), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (San Andreas Avenue)", camera = 1},
    {location = vector4(-1483.36, -380.25, 41.31, 74.71), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Prosperity Street)", camera = 1},
    {location = vector4(-2966.23, 387.35, 16.27, 26.65), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (West | Great Ocean Highway)", camera = 1},
    {location = vector4(1169.49, 2711.16, 39.32, 118.61), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Route 68)", camera = 1},
    {location = vector4(-56.89, -1752.07, 30.54, 275.94), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Davis Avenue)", camera = 1},
    {location = vector4(-43.42, -1755.28, 30.54, 98.44), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Davis Avenue)", camera = 2},
    {location = vector4(-40.0, -1751.34, 30.09, 120.42), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Davis Avenue)", camera = 3},
    {location = vector4(-43.97, -1748.2, 30.12, 188.44), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Davis Avenue)", camera = 4},
    {location = vector4(1153.6, -326.81, 70.33, 325.41), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (West Mirror Drive)", camera = 1},
    {location = vector4(1164.76, -318.51, 70.25, 147.90), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (West Mirror Drive)", camera = 2},
    {location = vector4(1164.05, -313.02, 69.96, 170.47), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (West Mirror Drive)", camera = 3},
    {location = vector4(1159.16, -314.42, 69.81, 237.90), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (West Mirror Drive)", camera = 4},
    {location = vector4(-717.72, -915.68, 20.31, 318.77), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Ginger Street)", camera = 1},
    {location = vector4(-705.42, -909.55, 20.24, 136.27), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Ginger Street)", camera = 2},
    {location = vector4(-705.05, -903.92, 19.98, 161.27), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Ginger Street)", camera = 3},
    {location = vector4(-710.21, -904.43, 19.82, 228.77), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Ginger Street)", camera = 4},
    {location = vector4(-1827.22, 784.84, 139.4, 2.34), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (North Rockford Drive)", camera = 1},
    {location = vector4(-1822.38, 797.85, 139.17, 172.34), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (North Rockford Drive)", camera = 2},
    {location = vector4(-1825.91, 802.22, 138.91, 204.84), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (North Rockford Drive)", camera = 3},
    {location = vector4(-1829.37, 898.26, 138.8, 267.34), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (North Rockford Drive)", camera = 4},
    {location = vector4(1703.03, 4933.52, 43.18, 188.32), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Grapeseed)", camera = 1},
    {location = vector4(1701.05, 4919.84, 43.18, 10.82), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Grapeseed)", camera = 2},
    {location = vector4(1705.21, 4916.74, 42.73, 35.83), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Grapeseed)", camera = 3},
    {location = vector4(1708.04, 4920.94, 42.67, 103.32), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Grapeseed)", camera = 4},
    {location = vector4(-1090.0, -2588.47, 14.98, 104.98), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (LSIA)", camera = 1},
    {location = vector4(-1099.73, -2593.77, 15.08, 289.90), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (LSIA)", camera = 2},
    {location = vector4(-1097.69, -2587.18, 15.08, 107.48), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (LSIA)", camera = 3},
    {location = vector4(264.58, -987.13, 30.49, 296.89), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Strawberry Avenue)", camera = 1},
    {location = vector4(273.45, -979.77, 30.48, 119.43), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Strawberry Avenue)", camera = 2},
    {location = vector4(272.63, -986.63, 30.48, 297.0), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Strawberry Avenue)", camera = 3},
    {location = vector4(166.27, 6634.11, 32.86, 0.07), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Paleto Bay)", camera = 1},
    {location = vector4(163.78, 6644.98, 32.86, 185.2), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Paleto Bay)", camera = 2},
    {location = vector4(169.56, 6641.29, 32.81, 7.58), canRotate = true, cameraType = "highquality", type = "General Stores", name = "General Store (Paleto Bay)", camera = 3},

    
    {location = vector4(149.47, -1035.65, 31.08, 308.42), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 1},
    {location = vector4(152.69, -1041.89, 29.79, 55.92), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 2},
    {location = vector4(146.48, -1038.21, 29.79, 248.42), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 3},
    {location = vector4(143.44, -1039.94, 30.04, 315.89), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 4},
    {location = vector4(142.93, -1041.93, 30.11, 220.91), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 5},
    {location = vector4(145.15, -1043.27, 29.92, 220.92), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 6},
    {location = vector4(150.61, -1046.72, 29.91, 58.42), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 7},
    {location = vector4(149.90, -1051.08, 30.08, 18.42), canRotate = true, cameraType = "highquality", type = "Banks", name = "Legion Square", camera = 8},

    {location = vector4(271.06, -834.65, 52.81, 172.91), canRotate = true, cameraType = "highquality", type = "Place", name = "Wuerfelpark", camera = 1},
    {location = vector4(-552.61, -235.25, 46.16, 280.62), canRotate = true, cameraType = "highquality", type = "Place", name = "Rathaus", camera = 1},
    {location = vector4(-623.86, 238.70, 85.99, 25.51), canRotate = true, cameraType = "highquality", type = "Place", name = "Medical Center", camera = 1},
    {location = vector4(210.61, 169.39, 138.23, 351.49), canRotate = true, cameraType = "highquality", type = "Place", name = "Staatsbank", camera = 1},
    {location = vector4(627.77, -34.33, 97.80, 277.79), canRotate = true, cameraType = "highquality", type = "Place", name = "Police Department", camera = 1},
    {location = vector4(214.10, -936.03, 34.68, 76.53), canRotate = true, cameraType = "highquality", type = "Place", name = "Wuerfelpark Buehne", camera = 1}
    
}

CCTV_Config.TimecycleTypes = {
    ["blackwhite"] = "CAMERA_BW",
    ["clear"] = "eyeINtheSKY",
    ["highquality"] = "heliGunCam"
}