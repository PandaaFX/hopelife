WS_VERKAUF = {}

WS_VERKAUF.zones = {

    -- Route anfang --

    ["weedjoint"] = {
        coords = vector3(-1611.03, -1046.23, 5.95),
        input = {
            item = "weedjoint", 
            label = "weedjoint", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 8000,
        generatePrice = {
            enabled = true,
            min = 1450,
            max = 1850
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["Weedpäckchen"] = {
        coords = vector3(-1691.27, -1071.257, 1.831),
        input = {
            item = "weed_pooch", 
            label = "Weed Päckchen", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 7500,
        generatePrice = {
            enabled = true,
            min = 1200,
            max = 1700
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["Leanverkauf"] = {
        coords = vector3(1554.197, -2710.193, 3.88),
        input = {
            item = "drug_lean", 
            label = "Lean", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 11000,
        generatePrice = {
            enabled = true,
            min = 2050,
            max = 2450
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["Koksverkauf"] = {
        coords = vector3(2771.36, -737.97, 9.09),
        input = {
            item = "coke_pooch", 
            label = "Koks Päckchen", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 8500,
        generatePrice = {
            enabled = true,
            min = 1550,
            max = 1950
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["LSDverkauf"] = {
        coords = vector3(3760.839, 4580.545, 3.516),
        input = {
            item = "drug_lsd", 
            label = "LSD", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 14000,
        generatePrice = {
            enabled = true,
            min = 2650,
            max = 3450
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["Methverkauf"] = {
        coords = vector3(-2279.802, 4394.320, 17.097),
        input = {
            item = "drug_meth", 
            label = "Meth", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 17500,
        generatePrice = {
            enabled = true,
            min = 3250,
            max = 3860
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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

    ["Heroinverkauf"] = {
        coords = vector3(-2615.84, 2953.92, 9.34),
        input = {
            item = "heroin", 
            label = "Heroin", 
            anzahl = 5, -- math.random(4, 10)
        },
        outputprice = 20000,
        generatePrice = {
            enabled = true,
            min = 3800,
            max = 4420
        },
        blackmoney = true,
        helpmsg = "~INPUT_CONTEXT~ um zu verkaufen", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "mp_common", 
	        animationName = "givetake1_a"
        },
        disallowed_jobs = {
            "police"
        
        },
        blip = {
            id = 496, 
            color = 2, 
            scale = 1.0,
            shortrange = true,
            name = "Wasser Verkauf",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = false,
            z_offset = 1.5,
            color = {
                r = 255,
                g = 136,
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