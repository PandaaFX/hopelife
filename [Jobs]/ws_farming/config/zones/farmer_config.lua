WS_FARMER = {}

WS_FARMER.zones = {

    -- Route anfang --

    ["Weedsamen"] = {
        coords = vector3(2225.947266, 5576.940430, 53.846924),
        output = "highgradefemaleseed", 
        outputanzahl = 3,
        helpmsg = "~INPUT_CONTEXT~ um Samen zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Codeine"] = {
        coords = vector3(157.147247, 6658.351563, 31.504028),
        output = "codeine", 
        outputanzahl = 4,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Koksblatt"] = {
        coords = vector3(829.29, 1308.26, 364.02),
        output = "koksblatt", 
        outputanzahl = 3,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 6, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Ice"] = {
        coords = vector3(957.916504, -2127.507813, 31.453491),
        output = "ice", 
        outputanzahl = 5,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 7, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Benzin"] = {
        coords = vector3(204.474731, 6618.619629, 31.638794),
        output = "benzin", 
        outputanzahl = 3,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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


    ["hydrogen"] = {
        coords = vector3(561.217590, -484.180206, 24.966309),
        output = "hydrogen", 
        outputanzahl = 4,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["oxygen"] = {
        coords = vector3(1668.89, 2.88, 166.12),
        output = "oxygen", 
        outputanzahl = 3,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 6, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["nitrogen"] = {
        coords = vector3(-190.13, 6067.82, 31.38),
        output = "nitrogen", 
        outputanzahl = 5,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 4, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Carbon"] = {
        coords = vector3(2676.540771, 3499.767090, 53.290894),
        output = "carbon", 
        outputanzahl = 4,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["sodium_hydroxide"] = {
        coords = vector3(3537.626465, 3660.145020, 28.117188),
        output = "sodium_hydroxide", 
        outputanzahl = 5,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 5, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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

    ["Schlafmohn"] = {
        coords = vector3(4881.613281, -5105.815430, 1.898926),
        output = "schlafmohn", 
        outputanzahl = 4,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 8, -- in secs
        zonesize = 10.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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
    ["pseudoefedrine"] = {
        coords = vector3(-248.821976, 6330.896484, 32.413940),
        output = "pseudoefedrine", 
        outputanzahl = 4,
        helpmsg = "~INPUT_CONTEXT~ um zu sammeln", 
        time = 10, -- in secs
        zonesize = 5.0,
        animation = {
            animDictionary = "pickup_object", 
	        animationName = "pickup_low"
        },
        disallowed_jobs = {
            "admin",
        },
        blip = {
            id = 1, 
            color = 1, 
            scale = 1.0,
            shortrange = true,
            name = "Samenfarm",
            enabled = false,
        },
        marker = {
            typ = 1,
            move = false,
            rotate = true,
            z_offset = 1.8,
            color = {
                r = 0,
                g = 28,
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
    -- Route Ende --
}