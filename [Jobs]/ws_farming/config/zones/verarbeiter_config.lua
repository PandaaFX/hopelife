WS_VERARBEITER = {}

WS_VERARBEITER.zones = {

    -- Route anfang --

    ["Schlafmohn_Rohopium"] = {
        coords = vector3(-1563.86, -3235.56, 26.34),
        helpmsg = "~INPUT_CONTEXT~ um zu interagieren", 
        time = 5, -- in secs
        zonesize = 10.0,
        input = {
            item = "schlafmohn",
            label = "Schlafmohn",
            anzahl = 2, -- math.random(4, 10)
        },
        output = {
            item = "rohopium", 
            label = "Rohopium", 
            anzahl = 1, -- math.random(4, 10)
        },
        disallowed_jobs = {
            "police"
          
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Kokainfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 0,
                g = 0,
                b = 0,
                t = 140
            },
            size = {
                x = 0.0,
                y = 0.0,
                z = 2.0
            }
        }
    },

    ["Rohopium_Morphin"] = {
        coords = vector3(-588.9, -1620.25, 33.01),
        helpmsg = "~INPUT_CONTEXT~ um zu interagieren", 
        time = 5, -- in secs
        zonesize = 10.0,
        input = {
            item = "rohopium",
            label = "Rohopium",
            anzahl = 3, -- math.random(4, 10)
        },
        output = {
            item = "morphin", 
            label = "Morphin", 
            anzahl = 2, -- math.random(4, 10)
        },
        disallowed_jobs = {
            "police"
          
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Kokainfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 0,
                g = 0,
                b = 0,
                t = 140
            },
            size = {
                x = 0.0,
                y = 0.0,
                z = 2.0
            }
        }
    }

    -- Route Ende --

}