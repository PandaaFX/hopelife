Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'de'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'Tequilalala',
        pos = vector3(-562.219788, 281.881317, 85.676147),
        requiredJob = nil, 
        range = 30.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Casino',
        pos = vector3(940.61, 26.8, 71.83),
        requiredJob = 'casino', 
        range = 15.0, 
        volume = 0.1 --[[ do not touch the volume! --]]
    },
    {
        name = 'Club',
        pos = vector3(-205.75, -352.13, 56.65),
        requiredJob = "club", 
        range = 20.0, 
        volume = 0.1 --[[ do not touch the volume! --]]
    },
    {
        name = 'Unicorn',
        pos = vector3(116.782417, -1281.784668, 29.246094),
        requiredJob = nil, 
        range = 25.0, 
        volume = 0.1 --[[ do not touch the volume! --]]
    },
    {
        name = 'Cayo',
        pos = vector3(4884.68, -4916.42, 3.7),
        requiredJob = nil, 
        range = 25.0, 
        volume = 0.1 --[[ do not touch the volume! --]]
    },
    {
        name = 'outlaws',
        pos = vector3(134.835175, -2994.672607, 7.695190),
        requiredJob = nil, 
        range = 25.0, 
        volume = 0.1 --[[ do not touch the volume! --]]
    }
    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}